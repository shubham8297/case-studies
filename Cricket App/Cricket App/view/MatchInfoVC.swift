//
//  ViewController.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 26/07/23.
//

// My API key = e389e1a5-fd21-4b85-b49a-20428abc5f5d


import UIKit

class MatchInfoVC: UIViewController {
    var currMatVM = CurrMatchVM()

    @IBOutlet weak var afterTossDecision: UILabel!
    @IBOutlet weak var t2NameL: UILabel!
    @IBOutlet weak var t1NameL: UILabel!
    @IBOutlet weak var t2Image: UIImageView!
    @IBOutlet weak var t1Image: UIImageView!
    @IBOutlet weak var t2OversL: UILabel!
    @IBOutlet weak var t2WicketsL: UILabel!
    @IBOutlet weak var t2RunsL: UILabel!
    @IBOutlet weak var t2InningL: UILabel!
    @IBOutlet weak var t1OversL: UILabel!
    @IBOutlet weak var t1WicketsL: UILabel!
    @IBOutlet weak var t1RunsL: UILabel!
    @IBOutlet weak var t1InningL: UILabel!
    @IBOutlet weak var venueL: UILabel!
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var typeL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    
    
    //reference to viewModel, no reference to Model
    var currMatch: CurrMatch?
//    var afterWinnigToss = ""
    var tossWinner = ""
    var tossChoice = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        t1Image.layer.cornerRadius = 50
        t2Image.layer.cornerRadius = 50
        
        
        
        Task{
            
            currMatch = await currMatVM.getCurMatchDetails()
            if currMatch != nil{
                let imageUrl1 = currMatch?.teamInfo[0].img
                let teamName1 = currMatch?.teamInfo[0].name
                let imageUrl2 = currMatch?.teamInfo[1].img
                let teamName2 = currMatch?.teamInfo[1].name
                nameL.text = currMatch?.name
                typeL.text = "Match format: \(currMatch?.matchType?.uppercased() ?? "N/A")"
                tossWinner = currMatch?.tossWinner ?? ""
                tossChoice = currMatch?.tossChoice ?? ""
                afterTossDecision.text = "\(tossWinner) won the toss and chose to \(tossChoice)"
                dateL.text = "Date: \(currMatch?.date ?? "N/A")"
                statusL.text = currMatch?.status
                venueL.text = currMatch?.venue
                t1InningL.text = currMatch?.score[0].inning
                t1WicketsL.text = "Wickets: \(currMatch?.score[0].w ?? 0)"
                t1RunsL.text = "Runs: \(currMatch?.score[0].r ?? 0)"
                t1OversL.text = "Overs: \(currMatch?.score[0].o ?? 0)"
                t2InningL.text = currMatch?.score[1].inning
                t2WicketsL.text = "Wickets: \(currMatch?.score[1].w ?? 0)"
                t2RunsL.text = "Runs: \(currMatch?.score[1].r ?? 0)"
                t2OversL.text = "Overs: \(currMatch?.score[1].o ?? 0)"
                t1NameL.text = currMatch?.teamInfo[0].name
                t2NameL.text = currMatch?.teamInfo[1].name

//                print("Data got: \(currMatch!)")
                
                let image1 = await currMatVM.getTeamImage(teamName: teamName1!, image: imageUrl1!)
                t1Image.image = image1
                
                
                
                let image2 = await currMatVM.getTeamImage(teamName: teamName2!, image: imageUrl2!)
                t2Image.image = image2
            }
            else{
                showAlert(title: "ERROR", msg: "Check Internet Connection!")
            }
        }
        
    }
    
    
  


}




extension UIViewController {
    func showAlert(title:String, msg:String){
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default)
        
        alertVC.addAction(alertAction)
        
        present(alertVC, animated: true)
    }
}
