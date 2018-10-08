//
//  NewsVM.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation
protocol TableViewPaginationDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

class NewsVM: NSObject {
    internal typealias VMDataCompletionBlock = (_ responseObject : NewsResponse?, _ errorObject : NewsConstants.DataResponseError?) -> ()
    var newsList :[News] = []
    var apiHandler = NewsAPIHandler()
    var dataHandler = NewsDataHandler()
    var totalNews = 0
    
    /* Load all news */
    func loadAllNewsFeed(search:String?,pageNumber: Int,size:Int,sortKey: String, onCompletion:@escaping VMDataCompletionBlock) {
        
        apiHandler.fetchAllNews(searchValue: search, page: pageNumber, pageSize: size, sort: sortKey) { (response, error) in
            onCompletion(response,error)
        }
    }
    
    /* total news count from server */
    var totalNewsCount: Int {
        return totalNews
    }
    
    /* current news count which is showing right now*/
    var currentNewsCount: Int {
        return newsList.count
    }
    
    /* local news sorting by date */
    func fetchAllNewsBySortDate(newsList:[News],order:ComparisonResult)->[News]{
        return dataHandler.sortNewsByDate(newsArray: newsList,orderedBy:order)
    }
}
