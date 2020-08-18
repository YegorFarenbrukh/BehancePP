//
//  DetailsViewController.swift
//  BehancePP
//
//  Created by apple on 8/3/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

final class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var detailsImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var recipeLabel: UILabel!
    
    // MARK: - Var & Consts
    var detailModel: DetailsDrinksModel?
    var imageUrl: String?
    var idDrink: String? = ""
    private lazy var urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(idDrink!)"
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("details view controller view did load")
        print(urlString)
        request(URLString: urlString)
        view.backgroundColor = .black
    }
    
    // MARK: - Set Value
    private func setValue() {
        DispatchQueue.main.async {
            let drinks = self.detailModel?.drinks[0]
            let url = URL(string: self.detailModel?.drinks[0]?.strDrinkThumb ?? "")!
            self.detailsImageView.sd_setImage(with: url, completed: nil)
            self.nameLabel.text = self.detailModel?.drinks[0]?.strDrink
            self.ingredientsLabel.text = drinks?.strIngredient1
            if drinks?.strIngredient2 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient2 ?? ""
            }
            if drinks?.strIngredient3 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient3 ?? ""
                
            }
            if drinks?.strIngredient4 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient4 ?? ""
                
            }
            if drinks?.strIngredient5 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient5 ?? ""
                
            }
            if drinks?.strIngredient6 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient6 ?? ""
                
            }
            if drinks?.strIngredient7 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient7 ?? ""
                
            }
            if drinks?.strIngredient8 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient8 ?? ""
                
            }
            if drinks?.strIngredient9 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient9 ?? ""
                
            }
            if drinks?.strIngredient10 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient10 ?? ""
                
            }
            if drinks?.strIngredient11 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient11 ?? ""
                
            }
            if drinks?.strIngredient12 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient12 ?? ""
                
            }
            if drinks?.strIngredient13 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient13 ?? ""
                
            }
            if drinks?.strIngredient14 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient14 ?? ""
                
            }
            if drinks?.strIngredient15 != nil {
                self.ingredientsLabel.text! += ", "
                self.ingredientsLabel.text! += drinks?.strIngredient15 ?? ""
            }
            
            self.recipeLabel.text = self.detailModel?.drinks[0]?.strInstructions
        }
    }
    
    // MARK: - Request
    private func request(URLString: String) {
        guard let url = URL(string: URLString) else {
            print("Request func: URL has value \(URLString)")
            return
        }
        AF.request(url)
            .responseDecodable { (response: DataResponse<DetailsDrinksModel,AFError>) in
                print("Download is starting...")
                switch response.result {
                case .success(let data):
                    self.detailModel = data
                    self.setValue()
                    print("Download is complited")
                case .failure(let error):
                    print(error)
                }
        }
    }
}
