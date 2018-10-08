//
//  NewsConstants.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation

class NewsConstants: NSObject {
    // Enum to change the base URL. We can add different end points. Currenly i kept dev and production server.
    
    enum BaseURL:String {
        case dev = "https://newsapi.org"
        
       // case prod = "https://newsapi.org"
    }
    static let baseURL        = BaseURL.dev.rawValue
    static let apiKey         = "3363a374df9f4660a260a187915f0937"
    static let defaultSearch  = "apple"
    static let defaultSortKey = "popularity"
    static let authorTitle    = "Author"
    static let readMore       = "Read More"
    enum APIUrl:String {
       case getAllNews = "/v2/everything"
    }
    enum APIQuery:String {
        case search     = "q"
        case pageSize   = "pageSize"
        case pageNumber = "page"
        case sort       = "sortBy"
        case key        = "apiKey"
    }
    // MARK: TableViewCellIdentifier -
    enum TableViewCellIdentifier:String {
        case NewsCell                        = "newsCellID"
    }
    // MARK: Nib Name -
    enum NibNames:String {
        case NewsNib                         = "NewsTableViewCell"
    }
    
    enum DataResponseError: Error {
        case network
        case decoding
        
        var reason: String {
            switch self {
            case .network:
                return "An error occurred while fetching data "
            case .decoding:
                return "An error occurred while decoding data"
            }
        }
    }
}
