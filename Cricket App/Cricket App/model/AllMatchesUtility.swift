//
//  AllMatchesUtility.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import Foundation
import Alamofire

struct AllMatchesUtility{
  
    private init() {}
    var urlString = "https://api.cricapi.com/v1/matches?apikey=e389e1a5-fd21-4b85-b49a-20428abc5f5d"

    static var instance = AllMatchesUtility()
    
    
    func getAllMatches() async throws -> [LiveMatch]{
        let task = AF.request(URL(string: urlString)!).serializingDecodable(CurrentMatches.self)
        
        let matches = try await task.value
        
        return matches.data
    }
    
}
