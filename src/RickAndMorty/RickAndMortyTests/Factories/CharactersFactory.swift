import RickAndMorty

final class CharactersFactory {

    static let characters = Characters(
        characterInfo: CharacterInfo(pages: 10),
        characterList: getCharacterList()
    )

    static let charactersEmptyList = Characters(
        characterInfo: CharacterInfo(pages: 10),
        characterList: []
    )

    static let characterList = getCharacterList()

    static let character = Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        isFav: false,
        location: Location(name: "Citadel of Ricks")
    )

    static let characterInDatabase = Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        isFav: true,
        location: Location(name: "Citadel of Ricks")
    )
}

private extension CharactersFactory {

    private static func getCharacterList() -> [Character] {
        var characterList = [Character]()
        characterList.append(
            Character(
                id: 1,
                name: "Rick Sanchez",
                status: "Alive",
                species: "Human",
                image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                isFav: false,
                location: Location(name: "Citadel of Ricks")
            )
        )
        characterList.append(
            Character(
                id: 2,
                name: "Morty Smith",
                status: "Alive",
                species: "Human",
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                isFav: false,
                location: Location(name: "Citadel of Ricks")
            )
        )
        characterList.append(
            Character(
                id: 3,
                name: "Summer Smith",
                status: "Alive",
                species: "Human",
                image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
                isFav: false,
                location: Location(name: "Earth (Replacement Dimension)")
            )
        )
        characterList.append(
            Character(
                id: 4,
                name: "Beth Smith",
                status: "Alive",
                species: "Human",
                image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
                isFav: false,
                location: Location(name: "Earth (Replacement Dimension)")
            )
        )
        characterList.append(
            Character(
                id: 5,
                name: "Jerry Smith",
                status: "Alive",
                species: "Human",
                image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
                isFav: false,
                location: Location(name: "Earth (Replacement Dimension)")
            )
        )
        return characterList
    }
}
