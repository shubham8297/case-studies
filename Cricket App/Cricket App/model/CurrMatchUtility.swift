//
//  MatchUtility.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 26/07/23.
//

import Foundation
import Alamofire

struct CurrMatchUtility {
//    private static var API_KEY = "e389e1a5-fd21-4b85-b49a-20428abc5f5d"
    
    private init(){}
    
    static var instance = CurrMatchUtility()
    
    var urlString = "https://api.cricapi.com/v1/match_info?apikey=e389e1a5-fd21-4b85-b49a-20428abc5f5d&offset=0&id=820cfd88-3b56-4a6e-9dd8-1203051140da"
    
    func getCurrMatch() async throws -> CurrMatch{
        
        let task = AF.request(URL(string: urlString)!).serializingDecodable(Match.self)
        
        
        let matInfo = try await task.value
        
//        print("Some data from utility: \(matInfo.data)")
        return matInfo.data
    }

    
    func getTeamsImages(teamName: String, imageURLString: String) async throws -> URL? {
        guard let url = URL(string: imageURLString) else{
            return nil
        }
        
        
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileUrl = docUrl.appendingPathComponent(teamName)
        if FileManager.default.fileExists(atPath: fileUrl.relativePath){
            return fileUrl
        }
        
        
        let dUrl = try await AF.download(url).serializingDownloadedFileURL().value
        
        try FileManager.default.moveItem(at: dUrl, to: fileUrl)
        
        return fileUrl
    }

}


