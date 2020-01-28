import XCTest
@testable import News

class NewsListPresenterTest: XCTestCase {
    // MARK: Properties
    var presenter: NewsListPresenter!
    var viewInputMock = ViewInputMock()
    var interactorInputMock = InteractorInputMock()
    var routerInputMock = RouterInputMock()

    // MARK: Lifecycle
    override func setUp() {
        super.setUp()
        presenter = NewsListPresenter(with: interactorInputMock,
                                      routerInput: routerInputMock)
        presenter.viewInput = viewInputMock
        
        interactorInputMock.interactorOutput = presenter
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testRefreshNewsItems() {
        XCTAssertFalse(viewInputMock.didRefreshNewsItems)
        interactorInputMock.fetchTopHeadlines(success: true)
        XCTAssertTrue(viewInputMock.didRefreshNewsItems)
    }
    
    func testShowError() {
        XCTAssertFalse(viewInputMock.didShowError)
        interactorInputMock.fetchTopHeadlines(success: false)
        XCTAssertTrue(viewInputMock.didShowError)
    }

    // MARK: Mocked Classes
    class ViewInputMock: NewsListViewInput {
        var didRefreshNewsItems = false
        func refreshNewsItems() {
            didRefreshNewsItems = true
        }
        
        func showLoading() { }
        
        var didShowError = false
        func showError(_ error: Error) {
            didShowError = true
        }
        
        func setupInitialState() {
            
        }
    }

    class InteractorInputMock: NewsListInteractorInput {
        var interactorOutput: NewsListInteractorOutput!
        
        func fetchTopHeadlines(success: Bool) {
            if success {
                interactorOutput.didFinishFetching(with: [])
            } else {
                interactorOutput.didFailFetching(with: .noData)
            }
        }
        
        func fetchTopHeadlines() { }
    }

    class RouterInputMock: NewsListRouterInput {
        func openBrowser(with article: Article) { }
    }
}
