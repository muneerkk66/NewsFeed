//
//  NewsAPIHandler.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation
class NewsAPIHandler: NSObject {
    internal typealias ApiCompletionBlock = (_ responseObject : NewsResponse?, _ error: NewsConstants.DataResponseError?) -> ()
    internal var networkManager : NetworkManager = NetworkManager()
    /* get All news feed API */
    func fetchAllNews(searchValue:String?,page: Int,pageSize:Int,sort: String, onCompletion:@escaping ApiCompletionBlock) {
        var components = URLComponents(string:NewsConstants.baseURL + NewsConstants.APIUrl.getAllNews.rawValue)!
        let searchQuery = URLQueryItem(name: NewsConstants.APIQuery.search.rawValue, value: searchValue)
        let pageQuery = URLQueryItem(name: NewsConstants.APIQuery.pageNumber.rawValue, value: "\(page)")
        let sizeQuery = URLQueryItem(name: NewsConstants.APIQuery.pageSize.rawValue, value: "\(pageSize)")
         let sortQuery = URLQueryItem(name: NewsConstants.APIQuery.sort.rawValue, value:sort)
        let apiQuery = URLQueryItem(name: NewsConstants.APIQuery.key.rawValue, value:NewsConstants.apiKey)
        components.queryItems = [searchQuery,pageQuery,sizeQuery,sortQuery,apiQuery]
        let request = URLRequest(url: components.url!)
        
        networkManager.getRequestPath(request: request, parameters: nil) { (responseObject, errorObject) -> () in
            onCompletion(responseObject, errorObject)
        }
    }
}

