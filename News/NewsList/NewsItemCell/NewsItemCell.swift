import UIKit
import Kingfisher

class NewsItemCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var sourceLabel: UILabel!

    /// Sets up the cell.
    /// - Parameter article: Article to be displayed on the cell.
    func setup(with article: Article) {
        titleLabel.text = article.title
        contentLabel.text = article.description
        authorLabel.text = article.author
        dateLabel.text = timeSinceNow(from: article.publishedAt)
        sourceLabel.text = article.source.name
        thumbnailImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""),
                                       placeholder: #imageLiteral(resourceName: "120"))
        
    }
    
    
    /// Returns a date string formatted as 'd MMM', example: 20 May.
    /// - Parameter dateString: Date as a String; returns "Some time ago" if not parseable.
    private func timeSinceNow(from dateString: String) -> String {
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            return "Some time ago"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
}
