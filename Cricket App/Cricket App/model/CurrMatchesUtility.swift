//
//  CurrMatchesUtility.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 30/07/23.
//

import Foundation
import Alamofire

struct CurrMatchesUtility{
    
    var urlString = "https://api.cricapi.com/v1/currentMatches?apikey=e389e1a5-fd21-4b85-b49a-20428abc5f5d&offset=0"
    
    private init(){
        
    }
    
    static var instance = CurrMatchesUtility()
    
    
    func getCurrentMatches() async -> [LiveMatch] {
        do {
            let task = AF.request(URL(string: urlString)!).serializingDecodable(CurrentMatches.self)
            let matches = try await task.value
            
            return matches.data
            
//            let matches = try await task.value
//            return matches.data
            
        } catch {
            // Handle any errors that occurred during the network request or serialization
            print("Error: \(error)")
            return []
        }
    }
    
    
    
}

