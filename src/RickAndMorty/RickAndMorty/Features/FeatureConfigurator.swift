import Moya

public final class FeatureConfigurator {

    init() {
        FeatureDependencies.shared.charactersRepository = CharactersRepository(
            provider: MoyaProvider<CharactersTarget>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
        )
    }

    public func prepareScene() -> UIViewController? {
        CharacterListConfigurator.prepareScene()
    }
}
