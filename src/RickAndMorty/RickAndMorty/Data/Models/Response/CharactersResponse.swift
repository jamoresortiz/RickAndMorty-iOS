struct CharactersResponse: Codable {
    let results: [CharacterResponse]?
}

struct CharacterResponse: Codable {
    let name: String?
    let status: String?
    let species: String?
    let image: String?
    let location: LocationResponse?
}

struct LocationResponse: Codable {
    let name: String?
}
