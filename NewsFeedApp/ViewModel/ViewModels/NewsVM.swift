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
    var currentPage = 1
    var totalNews = 0
    func loadAllNewsFeed(search:String?,pageNumber: Int,size:Int,sortKey: String, onCompletion:@escaping VMDataCompletionBlock) {
        
        apiHandler.fetchAllNews(searchValue: search, page: pageNumber, pageSize: size, sort: sortKey) { (response, error) in
            onCompletion(response,error)
        }
    }
    var currentCount: Int {
        return newsList.count
    }
    
}
