//
//  NetworkManager.swift
//  NewsFeedApp
//
//  Created by Muneer KK on 06/10/18.
//  Copyright © 2018 Muneer KK. All rights reserved.
//

import Foundation
class NetworkManager: NSObject {
    let session: URLSession
    internal typealias ApiCompletionBlock = (_ responseObject : NewsResponse?, _ error: NewsConstants.DataResponseError?) -> ()
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /* Get Request */
    func getRequestPath(request:URLRequest, parameters:[String:AnyObject]?, completionBlock:@escaping ApiCompletionBlock) {
        
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completionBlock(nil,NewsConstants.DataResponseError.network)
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(NewsResponse.self, from: data) else {
            completionBlock(nil,NewsConstants.DataResponseError.decoding)
                return
            }
            
           completionBlock(decodedResponse,nil)
        }).resume()
    }
}
extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
