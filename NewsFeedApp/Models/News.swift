//
//  News.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation

public struct News : Codable {
    let name:String
    public init?(from: Decodable) {
        //decoding here
        return nil
    }
}
