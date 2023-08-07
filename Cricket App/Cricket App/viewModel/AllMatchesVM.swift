//
//  AllMatchesVM.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import Foundation
import Network

class AllMatchesVM {
    private let utility = AllMatchesUtility.instance
    
    var isConnected = false
    
    init() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            switch path.status {
            case .satisfied:
                self.isConnected = true
            default:
                self.isConnected = false
            }
        }
        monitor.start(queue: DispatchQueue(label: "myQueue"))
    }
    
    func getAllMatches() async throws -> [LiveMatch]{
            let matches = try await utility.getAllMatches()
            return matches
           
    }
}
