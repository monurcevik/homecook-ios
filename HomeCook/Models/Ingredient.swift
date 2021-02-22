struct Ingredient: Codable {
    let id: Int?
    let name: String?
    let amount: Double?
    let unit: IngredientUnit?
}

enum IngredientUnit: Codable {
    case TableSpoon, TeaSpoon, MilliLiter, Liter, Milligram, Gram, Kilogram, Cup
    
    var displayName: String {
        switch self {
        case .TableSpoon:
            return "tbsp"
        case .TeaSpoon:
            return "tsp"
        case .MilliLiter:
            return "mL"
        case .Liter:
            return "L"
        case .Milligram:
            return "mg"
        case .Gram:
            return "g"
        case .Kilogram:
            return "kg"
        case .Cup:
            return "cup"
        }
    }
}
