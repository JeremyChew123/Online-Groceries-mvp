//
//  ProductModel.swift
//  OnlineSupermarket
//
//  Created by Jeremy Chew on 3/11/25.
//

import Foundation

enum Unit: String, Codable, CaseIterable {
    case piece, bunch, kg, pack
}

struct Category: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let colorHex: String
    let imageAsset: String?
}

struct Groceries: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let subtitle: String
    let price: Double
    let unit: Unit
    let imageAsset: String?
    let categoryId: String
    var isFeatured: Bool = false
    let productDescription: String
}

//Mock data
let fruitsCategory = Category(id: "fruits", name: "Fruits", colorHex: "FFF3CD", imageAsset: "frash_fruits")
let vegetableCategory = Category(id: "vegetables", name: "Vegetables", colorHex: "FFF3CD", imageAsset: "ginger")
let staplesCategory = Category(id: "staples", name: "Staples", colorHex: "FFF3CD", imageAsset: "rice")
let beverageCategory = Category(id: "beverage", name: "Beverages", colorHex: "FFF3CD", imageAsset: "orenge_juice")
let mockCategory: [Category] = [fruitsCategory, vegetableCategory, staplesCategory, beverageCategory]
let mockGroceries: [Groceries] = [
    Groceries(id: "banana", name: "Banana", subtitle: "7pcs, price", price: 2.99, unit: .pack, imageAsset: "banana", categoryId: "fruits", productDescription: "Bananas originated in Southeast Asia and Papua New Guinea, possibly as early as 8,000 BCE, and were first domesticated for their fiber before being cultivated for fruit. Travelers spread them to India, Africa, and Polynesia, with Alexander the Great noting them in India in 327 BC. Following their introduction to the Americas by Portuguese colonists in the 15th century, bananas became a major export, evolving from seeded wild fruits to the seedless varieties we eat today through selective breeding."),
    Groceries(id: "apple", name: "Apple", subtitle: "3pcs, price", price: 1.80, unit: .pack, imageAsset: "apple", categoryId: "fruits", isFeatured: true, productDescription: "Apples have been part of the human experience since the beginning of human history. Apples have been found as a part of the diet of early humans in anthropological research and recorded in the story of Adam & Eve. Greek and Roman mythology refer to apples as symbols of love and beauty. And when the Romans conquered England about the first century B.C.E., they brought apples with them."),
    Groceries(id: "bellPepper", name: "Bell Peppers", subtitle: "3pcs, price", price: 2.50, unit: .pack, imageAsset: "bell_pepper_red", categoryId: "vegetables", productDescription: "Bell peppers originated in Central and South America, where they were cultivated for thousands of years before being brought to Europe by Christopher Columbus in the 15th century. Initially spicy, the modern sweet varieties were developed later and became popular in European cuisine. The name bell pepper came about because the original varieties' hard walls and a stigma that acted as a clapper made them ring when swayed by the wind."),
    Groceries(id: "chickenEgg", name: "Chicken Eggs", subtitle: "10pcs, price", price: 3.49, unit: .pack, imageAsset: "egg_chicken_red", categoryId: "staples", isFeatured: true, productDescription: "Chicken egg history begins with the domestication of jungle fowl in Southeast Asia around 7500 BCE, likely for eggs, with records from ancient China and Egypt showing fowl-laying eggs for human consumption by 1400 BCE. Eggs were a significant part of the diet and culture across various civilizations, including their use in Roman cooking and their symbolic importance in pre-Christian and early Christian Europe. Modern commercial egg production and egg cartons are much more recent developments, starting in the late 19th and early 20th centuries. "),
    Groceries(id: "eggNoodles", name: "Egg Noodles", subtitle: "1pc, price", price: 0.60, unit: .piece, imageAsset: "egg_noodies_new", categoryId: "staples", productDescription: "Egg noodles are believed to have originated in China over 4,000 years ago. Early records show that the Chinese were making noodles from a dough of wheat flour and whole eggs, creating a rich and nutritious food source. These early noodles were often hand-pulled or rolled out and cut into strips."),
    Groceries(id: "pasta", name: "Pasta", subtitle: "1pc, price", price: 1.20, unit: .piece, imageAsset: "egg_pasta", categoryId: "staples", isFeatured: true, productDescription: "a dish originally from Italy consisting of dough made from durum wheat, extruded or stamped into various shapes and cooked in boiling water, and typically served with a sauce."),
    Groceries(id: "rice", name: "Rice", subtitle: "5kg, price", price: 14.00, unit: .kg, imageAsset: "rice", categoryId: "staples", productDescription: "Rice is a cereal grain and in its domesticated form is the staple food of over half of the world's population, particularly in Asia and Africa. Rice is the seed of the grass species Oryza sativa (Asian rice)—or, much less commonly, Oryza glaberrima (African rice)."),
    Groceries(id: "sprite", name: "sprite_can", subtitle: "1pc, price", price: 0.90, unit: .piece, imageAsset: "sprite_can", categoryId: "beverages", isFeatured: true, productDescription: "Sprite can refer to the lemon-lime flavored soft drink made by the Coca-Cola Company, a mythical fairy-like creature, an electrical phenomenon in the atmosphere, or a computer graphics element. The soft drink is caffeine-free with natural flavors, while the other meanings describe supernatural beings, lightning-related light shows, and independent moving images in video games. "),
    Groceries(id: "coke", name: "Coca-Cola", subtitle: "1pc, price", price: 0.90, unit: .piece, imageAsset: "cocacola_can", categoryId: "beverages", productDescription: "Coke can refer to the carbonated soft drink Coca-Cola, a fuel residue derived from coal, or the drug cocaine. Without additional context, it is most commonly understood as Coca-Cola, a brand of cola drink produced by The Coca-Cola Company."),
    Groceries(id: "mayonnaise", name: "Mayonnaise", subtitle: "1pc, price", price: 4.99, unit: .piece, imageAsset: "mayinnars_eggless", categoryId: "staples", isFeatured: true, productDescription: "Mayonnaise is a thick, creamy cold sauce made from an emulsion of oil, egg yolk, and an acid like vinegar or lemon juice. It is used as a condiment for sandwiches, burgers, and salads, and serves as the base for many other sauces and dressings, such as tartar sauce and ranch dressing. The emulsification process involves slowly whisking oil into an egg-and-acid mixture until it thickens into a stable sauce. "),
    
]
