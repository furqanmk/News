import XCTest
@testable import News

class NewsListConfiguratorTests: XCTestCase {
    // MARK: Lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testConfigureModuleForViewController() {
        //given
        let viewController = NewsListBuilder.build() as! NewsListViewController

        //then
        XCTAssertNotNil(viewController.viewOutput, "NewsListViewController is nil after configuration")
        XCTAssertTrue(viewController.viewOutput is NewsListPresenter, "viewOutput is not NewsListPresenter")

        let presenter: NewsListPresenter = viewController.viewOutput as! NewsListPresenter
        XCTAssertNotNil(presenter.viewInput, "viewInput in NewsListPresenter is nil after configuration")
        XCTAssertNotNil(presenter.viewInput is NewsListViewController, "viewInput is not NewsListPresenter")
        XCTAssertNotNil(presenter.routerInput, "routerInput in NewsListPresenter is nil after configuration")
        XCTAssertTrue(presenter.routerInput is NewsListRouter, "router is not NewsListRouter")

        let interactor: NewsListInteractor = presenter.interactorInput as! NewsListInteractor
        XCTAssertNotNil(interactor.interactorOutput, "interactorOutput in NewsListInteractor is nil after configuration")
        XCTAssertTrue(interactor.interactorOutput is NewsListPresenter, "interactorOutput is not NewsListPresenter")
    }
}
