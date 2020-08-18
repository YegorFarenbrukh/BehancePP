//
//  ObjectsModel.swift
//  BehancePP
//
//  Created by apple on 7/31/20.
//  Copyright © 2020 GQt. All rights reserved.
//

struct ObjectModel: Decodable {
    var drinks: [Drinks]
}

struct Drinks: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}
