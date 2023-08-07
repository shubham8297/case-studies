//
//  SeriesInfoUtility.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import Foundation
import Alamofire

struct SeriesInfoUtility{
    
    private init(){}
    
    var urlString = "https://api.cricapi.com/v1/series_info?apikey=e389e1a5-fd21-4b85-b49a-20428abc5f5d&offset=0&id=47b54677-34de-4378-9019-154e82b9cc1a"
    
    static var instance  = SeriesInfoUtility()
    
    
    func getAllSeriesInfo() async -> [LiveMatch]{
        do{
            let task = AF.request(URL(string: urlString)!).serializingDecodable(SeriesData.self)
            let matches = try await task.value
            return matches.data.matchList
        }catch{
            print("ERROR: \(error)")
            return []
        }
    }
}
