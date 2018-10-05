//
//  NewsAPIHandler.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation
class NewsAPIHandler: NSObject {
    internal typealias ApiCompletionBlock = (_ responseObject : Any?, _ error: NewsConstants.DataResponseError?) -> ()
    internal var networkManager : NetworkManager = NetworkManager()
    /* get All news feed API */
    func fetchAllNews(searchValue:String?,page: Int,pageSize:Int,sort: String, onCompletion:@escaping ApiCompletionBlock) {
        var components = URLComponents(string:NewsConstants.baseURL + NewsConstants.APIUrl.getAllNews.rawValue)!
        let searchQuery = URLQueryItem(name: NewsConstants.APIQuery.search.rawValue, value: searchValue)
        let pageQuery = URLQueryItem(name: NewsConstants.APIQuery.pageNumber.rawValue, value: "\(page)")
        let sizeQuery = URLQueryItem(name: NewsConstants.APIQuery.pageSize.rawValue, value: "\(pageSize)")
         let sortQuery = URLQueryItem(name: NewsConstants.APIQuery.sort.rawValue, value:sort)
        components.queryItems = [searchQuery,pageQuery,sizeQuery,sortQuery]
        let request = URLRequest(url: URL(string:encodedURL(components))!)
        
        networkManager.getRequestPath(request: request, parameters: nil, decodableType: News) { (responseObject, errorObject) -> () in
            onCompletion(responseObject as AnyObject, errorObject)
        }
    }
}
func encodedURL(_ url:URLComponents) -> String {
    var urlToEncode = url
    let characterSet = CharacterSet(charactersIn: "!#$&'()*+,/:;?@[] ").inverted
    let encoding =  url.percentEncodedQuery?.addingPercentEncoding(withAllowedCharacters: characterSet)
    urlToEncode.percentEncodedQuery = encoding
    return urlToEncode.string!
}
