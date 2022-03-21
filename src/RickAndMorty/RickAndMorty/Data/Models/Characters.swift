public struct Characters {
    public let characterInfo: CharacterInfo
    public let characterList: [Character]
}

public struct CharacterInfo {
    public let pages: Int
}

public struct Character: Codable, Equatable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let image: String
    public let isFav: Bool
    public let location: Location

    init(id: Int,
         name: String,
         status: String,
         species: String,
         image: String,
         location: Location) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.image = image
        self.isFav = false
        self.location = location
    }

    init(from character: Character, isFav: Bool) {
        self.id = character.id
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.image = character.image
        self.isFav = isFav
        self.location = character.location
    }
}

public struct Location: Codable, Equatable {
    public let name: String
}
