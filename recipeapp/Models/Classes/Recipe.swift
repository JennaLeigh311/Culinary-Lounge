//
//  Recipe.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/28/25.
//

import Foundation

// I'll implement recipe now but "reel" later when I actually need it,
// because I might change my mind on it depending on how hard it is

// To use Recipe in a set I need it to conform to Hashable
class Recipe: Post, Hashable {
    let id = UUID()
    let datePosted = Date()
    
    let author: User
    
    var likes: [Like] // array implementation
    var comments: [Comment] // array implementation
    var content: String = "" // placeholder

    var title: String
    var ingredients: [String]
    var description: String
    var cookTime: Int // minutes
    var servings: Int
    
    // sets are good for this because we don't want duplicated tags
    // set implementation - previously was an array
    var typeTags: Set<TypeTags>
    var cuisineTags: Set<CuisineTags>
    
    init(author: User,
         title: String,
         ingredients: [String],
         description: String,
         cookTime: Int,
         servings: Int,
         typeTags: Set<TypeTags>,
         cuisineTags: Set<CuisineTags>) {
        
        self.author = author
        self.title = title
        self.ingredients = ingredients
        self.description = description
        self.cookTime = cookTime
        self.servings = servings
        self.typeTags = typeTags
        self.cuisineTags = cuisineTags
        self.likes = []
        self.comments = []
        // for each tag in self.tags,
        // check if the dictionary exists at that key, if not create new key and initialize at null,
        // if it exists, append this recipe (self) to the key
        for tag in self.typeTags {
            recipesByTypeTag[tag, default: []].append(self)
        }
        for tag in self.cuisineTags {
            recipesByCuisineTag[tag, default: []].append(self)
        }
        // I'm seeing that some developers prefer to separate construction from registration, so potentially in the future I'll make a register() method for this tag filter stuff
    }
    
    // setters
    
    func changeTitle(newTitle: String) { self.title = newTitle }
    
    func changeIngredients(newIngredients: [String]) { self.ingredients = newIngredients}
    
    func changeDescription(newDescription: String) { self.description = newDescription }
    
    func changeCookingTime(newTime: Int) { self.cookTime = newTime }
    
    func changeServings(newServings: Int) { self.servings = newServings }
    
//    func changeTags(newTags: [String]) { self.tags = Set(newTags) }
    
    func changeContent(newContent: String) { self.content = newContent }
    
    // getters
    
    func getTitle() -> String { return title }
    
    func getIngredients() -> [String] { return ingredients  }
    
    func getDescription() -> String { return description }
    
    func getCookingTime() -> Int { return cookTime }
    
    func getServings() -> Int { return servings }
    
//    func getTags() -> Set<String> { return tags }
    
    func getContent() -> String { return content }
    
    // I had add like and add comment here but I changed my mind and I'll just do all that in User
    
    
    // these are apparently needed for this class to conform to the hashable protocol 
    
    // defines what it means for two Recipes to be equal
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
    
    // this is used to generate a unique key - don't ask me I don't understand this yet, I'll have to learn about it later
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
