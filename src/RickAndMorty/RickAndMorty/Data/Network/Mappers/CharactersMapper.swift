final class CharactersMapper {

    static func mapToCharacters(from response: CharactersResponse) -> Characters? {
        let list = response.results?.compactMap { (mapToCharacter(from: $0)) }
        guard
            let infoRes = response.info,
            let info = mapToCharacterInfo(from: infoRes),
            let list = list
        else {
            return nil
        }
        return .init(
            characterInfo: info,
            characterList: list
        )
    }
}

private extension CharactersMapper {

    static func mapToCharacterInfo(from response: CharacterInfoResponse) -> CharacterInfo? {
        guard
            let pages = response.pages
        else {
            return nil
        }
        return .init(pages: pages)
    }

    static func mapToCharacter(from response: CharacterResponse) -> Character? {
        guard
            let id = response.id,
            let name = response.name,
            let status = response.status,
            let species = response.species,
            let image = response.image,
            let locationRes = response.location,
            let location = mapToLocation(from: locationRes)
        else {
            return nil
        }
        return .init(
            id: id,
            name: name,
            status: status,
            species: species,
            image: image,
            location: location
        )
    }

    static func mapToLocation(from response: LocationResponse) -> Location? {
        guard
            let name = response.name
        else {
            return nil
        }
        return .init(name: name)
    }
}
