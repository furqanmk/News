final class NewsListPresenter {
    // MARK: Properties
    weak var viewInput: NewsListViewInput!
    let interactorInput: NewsListInteractorInput
    let routerInput: NewsListRouterInput
    var articles: [Article] = []

    // MARK: Initalizers
    init(with interactorInput: NewsListInteractorInput,
    	 routerInput: NewsListRouterInput) {
    	self.interactorInput = interactorInput
        self.routerInput = routerInput
    }
}

// MARK: View To Presenter Protocol
extension NewsListPresenter: NewsListViewOutput {
	func viewIsReady() {
        viewInput.showLoading()
        interactorInput.fetchTopHeadlines()
    }
    
    func didReachPageEnd() {
        viewInput.showLoading()
        interactorInput.fetchTopHeadlines()
    }
    
    func didSelectNewsItem(at index: Int) {
        let article = articles[index]
        routerInput.openBrowser(with: article)
    }
}

// MARK: Interactor To Presenter Protocol
extension NewsListPresenter: NewsListInteractorOutput {
    func didFailFetching(with error: ClientError) {
        viewInput.showError(error)
    }
    
    func didFinishFetching(with articles: [Article]) {
        self.articles += articles
        viewInput.refreshNewsItems()
    }
}
