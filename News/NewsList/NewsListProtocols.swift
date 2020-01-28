// MARK: Presenter To View Interface
protocol NewsListViewInput: class {
    
    /// Reresh the table with new news items.
    func refreshNewsItems()
    
    /// Show loading state as a footer of the table.
    func showLoading()
    
    /// Show error as a native dialog
    /// - Parameter error: The type of error.
    func showError(_ error: Error)
}

// MARK: View To Presenter Interface
protocol NewsListViewOutput: class {
    
    /// List of articles fetched from the service.
    var articles: [Article] { get }
    
    /// View is visible and ready to accept user interaction.
    func viewIsReady()
    
    /// Table reached the end; should load more news items.
    func didReachPageEnd()
    
    /// A row was tapped; should open up the browser with the article.
    /// - Parameter index: Index of the cell tapped.
    func didSelectNewsItem(at index: Int)
}

// MARK: Presenter To Interactor Interface
protocol NewsListInteractorInput: class {
    
    /// Fetch the top headlines on the current page.
    func fetchTopHeadlines()
}

// MARK: Interactor To Presenter Interface
protocol NewsListInteractorOutput: class {
    
    /// Fetching of articles failed.
    /// - Parameter error: Contains reason of failure.
    func didFailFetching(with error: ClientError)
    
    /// Fetching succeeded.
    /// - Parameter state: List of new articles downloaded.
    func didFinishFetching(with state: [Article])
}

// MARK: Presenter To Router Interface
protocol NewsListRouterInput: class {
    
    /// Open the browser with the article.
    /// - Parameter article: Contains url for the article.
    func openBrowser(with article: Article)
}
