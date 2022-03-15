final class CharactersMapper {

    static func mapToCharacters(from response: CharactersResponse) -> [Character]? {
        response.results?.compactMap { mapToCharacter(from: $0) }
    }
}

private extension CharactersMapper {

    static func mapToCharacter(from response: CharacterResponse) -> Character? {
        guard
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
