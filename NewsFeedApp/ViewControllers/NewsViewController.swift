//
//  ViewController.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 05/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import UIKit
import SDWebImage
private typealias TableViewMethods        = NewsViewController
private typealias SearchBarDelegates      = NewsViewController

class NewsViewController: UIViewController,AlertView {
@IBOutlet var newsTableView: UITableView!
@IBOutlet var searchController: UISearchBar!
    fileprivate var searchText = "apple"
    fileprivate var sortKey = "popularity"
    fileprivate var pageSize:Int = 10
    fileprivate var pageNumber:Int = 1
    fileprivate var isFetchInProgress = false
    var newsVM = NewsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseTableView()
        
        // Load all news
        loadAllNews()
    }
    
    //MARK: - Helper
    fileprivate func initialiseTableView() {
        
        newsTableView.separatorInset = UIEdgeInsets(top: 0, left: self.view.bounds.size.width, bottom: 0, right: 0)
        newsTableView.register(UINib(nibName: NewsConstants.NibNames.NewsNib.rawValue, bundle: Bundle.main), forCellReuseIdentifier: NewsConstants.TableViewCellIdentifier.NewsCell.rawValue)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func loadAllNews() {
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        newsVM.loadAllNewsFeed(search: searchText, pageNumber: pageNumber, size: pageSize, sortKey: sortKey) {[weak self] (response, error) in
            
            guard let `self` = self else {
                return
            }
            DispatchQueue.main.async { [weak self]() -> Void in
                self?.isFetchInProgress = false
                if let _ = error {
                 
                    self?.onFetchFailed(with: (error?.reason)!)
                    
                }
                else {
                    self?.newsVM.currentPage += 1
                    self?.isFetchInProgress = false

                    self?.newsVM.totalNews = (response?.articles.count)!
                    self?.newsVM.newsList.append(contentsOf: response?.articles as! [News])

                    if (self?.pageNumber)! > 1 {
                        let indexPathsToReload = self?.newsVM.dataHandler.calculateIndexPathsToReload(from: (response?.articles)!)
                        self?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self?.onFetchCompleted(with: .none)
                    }
                }
                
            }

        }
    }
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            newsTableView.isHidden = false
            newsTableView.reloadData()
            return
        }
        // 2
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        newsTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {

        
        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }


}
//MARK: - TableView DataSource and Deelegate
extension TableViewMethods: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsConstants.TableViewCellIdentifier.NewsCell.rawValue,
                                                 for: indexPath) as! NewsTableViewCell
        let news = newsVM.newsList[indexPath.row]
        cell.titleLabel.text = news.title
        cell.authorLabel.text = "Author: \(news.author)"
        cell.descriptionLabel.text = news.description
        cell.timeLabel.text = news.publishedAt.getDateFromString().getElapsedInterval()
        
        cell.newsImageView?.sd_setImage(with: URL(string:news.urlToImage), placeholderImage:#imageLiteral(resourceName: "placeholder"))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsVM.newsList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
//MARK: -
/* Methods to handle search */
extension SearchBarDelegates:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        searchText = searchBar.text!
        if text == "" {
            searchText = String(searchText.dropLast())
        }
        else {
            searchText.append(text)
        }
        return true
    }
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Update News by search value
        loadAllNews()
        
        searchBar.resignFirstResponder()
    }
    

}
private extension NewsViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= newsVM.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = newsTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

