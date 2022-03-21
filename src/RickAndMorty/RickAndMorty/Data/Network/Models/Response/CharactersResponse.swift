struct CharactersResponse: Codable {
    let info: CharacterInfoResponse?
    let results: [CharacterResponse]?
}

struct CharacterInfoResponse: Codable {
    let pages: Int?
}

struct CharacterResponse: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let image: String?
    let location: LocationResponse?
}

struct LocationResponse: Codable {
    let name: String?
}
