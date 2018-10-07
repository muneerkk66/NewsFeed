//
//  NewsDataHandler.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation
class NewsDataHandler: NSObject {
    func calculateIndexPathsToReload(from newNewsList: [News]) -> [IndexPath] {
        let startIndex = newNewsList.count - newNewsList.count
        let endIndex = startIndex + newNewsList.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0)}
    }
    func sortNewsByDate(newsArray:[News],orderedBy:ComparisonResult) -> [News]{
       
        let newsList = newsArray.sorted(by:{
            $0.publishedAt.getDateFromString().compare($1.publishedAt.getDateFromString()) == orderedBy
        })
        return newsList
        
    }
}
