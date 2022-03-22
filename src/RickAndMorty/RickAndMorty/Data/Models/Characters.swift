public struct Characters {
    public let characterInfo: CharacterInfo
    public let characterList: [Character]

    public init(characterInfo: CharacterInfo,
                characterList: [Character])
    {
        self.characterInfo = characterInfo
        self.characterList = characterList
    }
}

public struct CharacterInfo {
    public let pages: Int

    public init(pages: Int) {
        self.pages = pages
    }
}

public struct Character: Codable, Equatable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let image: String
    public let isFav: Bool
    public let location: Location

    public init(id: Int,
                name: String,
                status: String,
                species: String,
                image: String,
                isFav: Bool,
                location: Location)
    {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.image = image
        self.isFav = isFav
        self.location = location
    }

    public init(from character: Character, isFav: Bool) {
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

    public init(name: String) {
        self.name = name
    }
}
