import Foundation
import Alamofire

enum ClientError: Error {
    case noData
    case decodeFailed
    case other(Error)
}

final class NewsListInteractor {
    // MARK: Properties
    weak var interactorOutput: NewsListInteractorOutput!
    
    private var isFetching = false
    private var currentPage = 0
    private let pageSize = 10
    private let apiKey = "fca7093831f343d5b947f08b078321df"
    private let country = "us"
}

// MARK: Presenter To Interactor Interface
extension NewsListInteractor: NewsListInteractorInput {
    func fetchTopHeadlines() {
        // Ideally this implementation should be wrapped inside a network layer.
        // But doing this seems beyond the scope of the exercise.
        guard !isFetching else {
            return
        }
        
        isFetching = true
        Alamofire.request("https://newsapi.org/v2/top-headlines",
                          method: .get,
                          parameters: [
                            "country": country,
                            "pageSize": 10,
                            "page": currentPage + 1,
                            "apiKey": apiKey
            ]
        ).response { [weak self] result in
            guard let data = result.data else {
                self?.interactorOutput.didFailFetching(with: .noData)
                return
            }
            
            guard let pagedArticles = try? JSONDecoder().decode(PagedArticles.self, from: data) else {
                self?.interactorOutput.didFailFetching(with: .decodeFailed)
                return
            }
            
            self?.currentPage += 1
            self?.interactorOutput.didFinishFetching(with: pagedArticles.articles)
            self?.isFetching = false
        }
    }
}
