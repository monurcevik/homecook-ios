struct Recipe: Codable {
    let id: Int?
    let name: String?
    let ingredients: [Ingredient]?
    let cook: User?
    let instructions: String?
}
