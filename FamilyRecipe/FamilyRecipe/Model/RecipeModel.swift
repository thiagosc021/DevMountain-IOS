//
//  RecipeModel.swift
//  FamilyRecipe
//
//  Created by Thiago Costa on 3/14/22.
//

import Foundation

enum Unit {
    case teaspoon
    case tablespoon
    case cup
    case liter
    case pound
    case ounce
    case kg
    case mg
    case unt
}

struct Ingredient {
    var description: String
}

struct IngredientRecipe {
    var ingredient: Ingredient
    var quantity: Int
    var unit: Unit
    var description: String {
        return "\(quantity) \(unit) - \(ingredient.description)"
    }
}

struct Recipe {
    var ID: String
    var photoURL: String
    var name: String
    var ingredients: [IngredientRecipe]
    var instructions: String
    
    var shortDescription: String {
        String(instructions.prefix(200))
    }
}
