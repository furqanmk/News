import UIKit

final class NewsListViewController: UIViewController {
    // MARK: Properties
    let viewOutput: NewsListViewOutput
    private let newsItemCellReuseId = "NewsItemCell"
    private let rowHeight: CGFloat = 240
    
    @IBOutlet private var tableView: UITableView!

    // MARK: Initalizers
    init(viewOutput: NewsListViewOutput) {
    	self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tableView dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register ReviewCell nib on the tableView
        tableView.register(UINib(nibName: newsItemCellReuseId, bundle: nil),
                           forCellReuseIdentifier: newsItemCellReuseId)
        
        // Set accessibility identifier for UI tests
        tableView.accessibilityIdentifier = "accessibility_news_list_table_view"
        
        viewOutput.viewIsReady()
    }
    
    /// Sets the status bar text to white color.
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}

// MARK: Presenter To View Protocol
extension NewsListViewController: NewsListViewInput {
    func showError(_ error: Error) {
        present(UIAlertController(title: nil,
                                  message: error.localizedDescription,
                                  preferredStyle: .alert),
                animated: true)
        tableView.tableFooterView = nil
    }
    
    func showLoading() {
        let activityIndicatorFrame = CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 44))
        let indicatorFooter = UIActivityIndicatorView(frame: activityIndicatorFrame)
        indicatorFooter.color = .gray
        indicatorFooter.startAnimating()
        tableView.tableFooterView = indicatorFooter
    }
    
    func refreshNewsItems() {
        tableView.reloadData()
        tableView.tableFooterView = nil
    }
}

// MARK: - Table view data source
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewOutput.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: newsItemCellReuseId, for: indexPath) as? NewsItemCell else {
            return UITableViewCell()
        }
        cell.setup(with: viewOutput.articles[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewOutput.didSelectNewsItem(at: indexPath.row)
    }
    
    // Detects when user scrolls to the bottom of the table view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            viewOutput.didReachPageEnd()
        }
    }
}
