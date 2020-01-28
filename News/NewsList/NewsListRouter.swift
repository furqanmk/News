import UIKit

// MARK: Presenter To Router Protocol
final class NewsListRouter: NewsListRouterInput {
    /// Open the article in Safari
    /// - Parameter article: article to be opened.
    func openBrowser(with article: Article) {
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
}
