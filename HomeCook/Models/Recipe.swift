struct Recipe: Codable {
    let id: Int?
    let name: String?
    let ingredients: [Ingredient]?
    let cook: User?
    let instructions: String?
    let duration: Double? // in seconds
    let difficulty: RecipeDifficulty
}

enum RecipeDifficulty {
    case Easy, Meh, Hard
    
    var emoji: String {
        switch self {
        case .Easy:
            return "😬"
        case .Meh:
            return "🧐"
        case .Hard:
            return "😦"
        }
    }
}
