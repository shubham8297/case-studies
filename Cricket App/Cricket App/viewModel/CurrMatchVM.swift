//
//  CurrMatchVM.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 27/07/23.
//

import Foundation
import Network
import UIKit

class CurrMatchVM {
    
    // reference to model, no ref to view
    private let currMatUtility = CurrMatchUtility.instance
    
    var isConnected = false
    
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
//        print(NSHomeDirectory())
    }
    
    
    func getCurMatchDetails() async -> CurrMatch?{
        if isConnected{
            if let match = try? await currMatUtility.getCurrMatch(){
                return match
            }else{
                return nil
            }
            
        }else{
            //fetch from core data if available
        }
        return nil
    }
    
    
    func getTeamImage(teamName:String,image:String) async -> UIImage?{
        if isConnected{
            let imageUrl = (try? await currMatUtility.getTeamsImages(teamName: teamName, imageURLString: image)) ?? URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphoto%2Fsingle-cricket-ball-on-white-background-gm95616764-9168819&psig=AOvVaw3f2GDgrAs1i62HTniH0BfO&ust=1691416167799000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJCr0LCWyIADFQAAAAAdAAAAABAE")
            let imgData = try! Data(contentsOf: ((imageUrl ?? URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphoto%2Fsingle-cricket-ball-on-white-background-gm95616764-9168819&psig=AOvVaw3f2GDgrAs1i62HTniH0BfO&ust=1691416167799000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJCr0LCWyIADFQAAAAAdAAAAABAE"))!))
            
            return UIImage(data: imgData)
        }else{
            return nil
        }
    }
}
