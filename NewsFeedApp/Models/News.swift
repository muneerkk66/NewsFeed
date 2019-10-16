//
//  News.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//
// SAMPLE
import Foundation

public struct News : Codable {
    let title:String
    let urlToImage:String
    let author:String
    let description:String
    let publishedAt:String
    let url:String
}
public struct NewsResponse: Decodable {
    let articles: [News]
    let totalResults: Int
}
