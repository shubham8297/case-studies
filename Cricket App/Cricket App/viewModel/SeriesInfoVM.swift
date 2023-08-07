//
//  SeriesInfoVM.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import Foundation
import Network

class SeriesInfoVM {
    private let S_InfoUtility = SeriesInfoUtility.instance
    
    private var isConnected = false
    
    init() {
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
    
    func getSeriesMatches() async -> [LiveMatch] {
        return await S_InfoUtility.getAllSeriesInfo()
    }
    
}
