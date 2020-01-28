import Foundation

final class PagedArticles: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
