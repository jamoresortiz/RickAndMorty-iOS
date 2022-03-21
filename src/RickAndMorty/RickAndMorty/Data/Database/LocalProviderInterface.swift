protocol LocalProviderInterface {
    func saveFav(character: Character)
    func deleteFav(character: Character)
    func getFavCharacters() -> [Character]
}
