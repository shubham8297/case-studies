//
//  CurrMatchesVM.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 30/07/23.
//

import Foundation
import Network



class CurrMatchesVM {
    
    
    private var isConnected = false
    
    private let currMatchesUtility = CurrMatchesUtility.instance
    
    init(){
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            switch path.status{
            case .satisfied:
                self.isConnected = true
            default:
                self.isConnected = false
            }
        }
        monitor.start(queue: DispatchQueue(label: "myQueue"))
    }
    
    
    
    func getAllCurrentMatches() async -> [LiveMatch]{
       let currMatches = await currMatchesUtility.getCurrentMatches()
        return currMatches
    }
}
