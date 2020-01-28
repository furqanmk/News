import UIKit

final class NewsListBuilder {
    // MARK: Initalizers
    private init() { }

    // MARK: Builder
    static func build() -> UIViewController {
        let router = NewsListRouter()
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter(with: interactor, routerInput: router)

        let viewController = NewsListViewController(viewOutput: presenter)
        presenter.viewInput = viewController
        interactor.interactorOutput = presenter

        return viewController
    }
}
