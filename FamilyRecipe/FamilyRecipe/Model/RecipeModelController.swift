//
//  RecipeModelController.swift
//  FamilyRecipe
//
//  Created by Thiago Costa on 3/14/22.
//

import Foundation
import UIKit

class RecipeModelController {
    
    var recipes: [Recipe] = []
    
    func loadStaticRecipes() {
        let ingredient1 = Ingredient(description: "Egg")
        let ingredientQt = IngredientRecipe(ingredient: ingredient1, quantity: 1, unit: .unt)
        let ingredient2 = Ingredient(description: "hot watter")
        let ingredientQt2 = IngredientRecipe(ingredient: ingredient2, quantity: 2, unit: .cup)
        let recipe = Recipe(ID: UUID().uuidString, photoURL: "https://hips.hearstapps.com/delish/assets/18/08/1519321899-hard-boiled-eggs-horizontal.jpg", name: "boiled eggs", ingredients: [ingredientQt,ingredientQt2], instructions: "1 - warm up the wather till 100 degress \n2 - put the egg in the pot \n3 - wait for 5 minutes")
        
        recipes.append(recipe)
    }
    
    func fetchRecipes(for name: String) -> [Recipe] {
        
        guard name.count > 0 else {
            return recipes
        }
        
        return recipes.filter { recipe in
            recipe.name.contains(name)
        }
    }
    
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
    
    func deleteRecipe(recipeId: String) {
        guard let recipeIndex = recipes.firstIndex(where: {$0.ID == recipeId}) else { return }
        recipes.remove(at: recipeIndex)
    }
    
    func updateRecipe(recipe: Recipe) {
        deleteRecipe(recipeId: recipe.ID)
        addRecipe(recipe: recipe)
    }
}

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        // If the URL already exists as a key in our in-memory cache, we can immediately call the completion handler.
        // Since there is no active task and nothing to cancel later, we can return nil instead of a UUID instance.
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }

        // We create a UUID instance that is used to identify the data task that we’re about to create.
        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // When the data task completed, it should be removed from the running requests dictionary.
            // We use a defer statement here to remove the running task before we leave the scope of the data task’s completion handler.
            defer {self.runningRequests.removeValue(forKey: uuid) }

            // When the data task completes and we can extract an image from the result of the data task,
            // it is cached in the in-memory cache and the completion handler is called with the loaded image.
            // After this, we can return from the data task’s completion handler.
            if let data = data, let image = UIImage(data: data) {
              self.loadedImages[url] = image
              completion(.success(image))
              return
            }

            // If we receive an error, we check whether the error is due to the task being canceled.
            // If the error is anything other than canceling the task, we forward that to the caller of loadImage(_:completion:).
            guard let error = error else {
              // without an image or an error, we'll just ignore this for now
              // you could add your own special error cases for this scenario
              return
            }

            guard (error as NSError).code == NSURLErrorCancelled else {
              completion(.failure(error))
              return
            }

            // the request was cancelled, no need to call the callback
        }
        task.resume()

        // The data task is stored in the running requests dictionary using the UUID that was created in step 2.
        // This UUID is then returned to the caller.
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
}
