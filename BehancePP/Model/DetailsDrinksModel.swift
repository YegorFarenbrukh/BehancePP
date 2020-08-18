//
//  DetailsDrinksModel.swift
//  BehancePP
//
//  Created by apple on 8/4/20.
//  Copyright © 2020 GQt. All rights reserved.
//

struct DetailsDrinksModel: Decodable {
    var drinks: [DetailsDrinks?]
}

struct DetailsDrinks: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
    var strCategory: String
    var strInstructions: String
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
}
