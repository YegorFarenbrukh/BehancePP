//
//  ViewController.swift
//  BehancePP
//
//  Created by apple on 7/31/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import BTNavigationDropdownMenu

final class ViewController: UIViewController {
    
    // MARK: - TableView outlet
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - Vars & Consts
    private var model: ObjectModel? = nil
    private var filteredDrinks: [Drinks]? = nil
    
    private let urlStringAlchohol = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
    private let urlStringNonAlchohol = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dropdownTitle()
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        request(URLString: urlStringAlchohol)
        searchSetup()
    }
    
    // MARK: - Custom DropDown Title
    private func dropdownTitle() {
        let items = ["Alchohol", "Non-Alchohol"]
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title(items[0]), items: items)
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            switch indexPath {
            case 0:
                self.request(URLString: self.urlStringAlchohol)
            case 1:
                self.request(URLString: self.urlStringNonAlchohol)
            default:
                self.request(URLString: self.urlStringAlchohol)
            }
        }
    }
    
    // MARK: - Search bar Setup
    private func searchSetup() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Drinks"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Search help vars
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: Search filter
    func filterContentForSearchText(_ searchText: String) {
        filteredDrinks = model?.drinks.filter({ (Drinks: Drinks) -> Bool in
            return Drinks.strDrink.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    // MARK: - Setup Table View
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        self.view.backgroundColor = .black
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.title = "Coctails"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    // MARK: - Request
    private func request(URLString: String) {
        guard let url = URL(string: URLString) else {
            print("Request func: URL has value \(URLString)")
            return
        }
        AF.request(url)
            .responseDecodable { (response: DataResponse<ObjectModel,AFError>) in
                print("Download is starting...")
                switch response.result {
                case .success(let data):
                    self.model = data
                    print("Download is complited")
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
    }
}

// MARK: - DataSource & Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredDrinks?.count ?? 0
        }
        
        return model?.drinks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        // Setting background color to cell ??
        cell.backgroundColor = .black
        
        // Records var
        var records: Drinks? = nil
        if isFiltering {
            records = filteredDrinks?[indexPath.row]
        } else {
            records = model?.drinks[indexPath.row]
        }
        
        
        // Title setting
        cell.nameLabel.text = records?.strDrink
        
        // Image download with SDWebImage
        DispatchQueue.main.async {
            let imageURL = records?.strDrinkThumb
            cell.previewImageView.sd_setImage(with: URL(string: imageURL ?? ""))
        }
        
        return cell
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.isActive = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue is starting...")
        if let indexPath = tableView.indexPathForSelectedRow {
            
            let detailsVC = segue.destination as! DetailsViewController
            if isFiltering {
                detailsVC.imageUrl = filteredDrinks?[indexPath.row].strDrinkThumb ?? ""
                detailsVC.idDrink = filteredDrinks?[indexPath.row].idDrink ?? ""
            } else {
                detailsVC.imageUrl = model?.drinks[indexPath.row].strDrinkThumb ?? ""
                detailsVC.idDrink = model?.drinks[indexPath.row].idDrink ?? ""
            }
        }
    }
}

// MARK: - Search Results Updating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

