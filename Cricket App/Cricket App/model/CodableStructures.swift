//
//  CodableStructures.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 30/07/23.
//

import Foundation


struct CurrMatch : Codable{
    var id:String
    var name:String
    var matchType:String?
    var status:String
    var venue:String
    var date:String
    var teams:[String]
    var teamInfo:[TeamInfo]
    var score:[ScoreInfo]
    var tossWinner: String
    var tossChoice: String
    var matchWinner:String
}

struct LiveMatch : Codable{
    var id:String
    var name:String
    var matchType:String?
    var status:String
    var venue:String
    var date:String
    var teams:[String]
    var teamInfo:[TeamInfo]?
    var score:[ScoreInfo]?
}

struct TeamInfo: Codable {
    var name: String?
    var shortname: String?
    var img: String?
}

struct ScoreInfo: Codable {
    var r: Int?
    var w: Int?
    var o: Double?
    var inning: String?
}


//only one match details
struct Match :Codable{
    var data:CurrMatch
}

//data of all current matches and all matches which are of type current match array
struct CurrentMatches :Codable{
    var data:[LiveMatch]
}

//data of series info having matchlist of type current match array
struct SeriesInfo :Codable{
    var matchList:[LiveMatch]
}


// for series matches data 
struct SeriesData: Codable{
    var data:SeriesInfo
}

