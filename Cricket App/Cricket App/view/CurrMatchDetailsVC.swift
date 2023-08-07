//
//  CurrMatchDetailsVC.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import UIKit

class CurrMatchDetailsVC: UIViewController {

    let imageVM = CurrMatchVM()
    
    @IBOutlet weak var t2Name: UILabel!
    @IBOutlet weak var t2Img: UIImageView!
    @IBOutlet weak var t1Name: UILabel!
    @IBOutlet weak var t1Img: UIImageView!
    @IBOutlet weak var t2Overs: UILabel!
    @IBOutlet weak var t2Wickets: UILabel!
    @IBOutlet weak var t2Runs: UILabel!
    @IBOutlet weak var t2Innings: UILabel!
    @IBOutlet weak var t1Overs: UILabel!
    @IBOutlet weak var t1Wickets: UILabel!
    @IBOutlet weak var t1Runs: UILabel!
    @IBOutlet weak var t1Innings: UILabel!
    @IBOutlet weak var venueL: UILabel!
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var afterTossL: UILabel!
    @IBOutlet weak var matchTypeL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    
    var selectedMatchDetails : LiveMatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameL.text = selectedMatchDetails?.name
        matchTypeL.text = "Match Type: \(selectedMatchDetails?.matchType?.uppercased() ?? "N/A")"
        afterTossL.text = "Toss: N/A"
        statusL.text = "Match Stutus: \(selectedMatchDetails?.status ?? "N/A")"
        dateL.text = "Date: \(selectedMatchDetails?.date ?? "N/A")"
        venueL.text = selectedMatchDetails?.venue
        
        t1Innings.text = "\(selectedMatchDetails?.score?[0].inning ?? "\(selectedMatchDetails?.teamInfo?[0].shortname ?? "") Innings")"
        
        t1Runs.text = "Runs: \(selectedMatchDetails?.score?[0].r ?? 0)"
        t1Wickets.text = "Wickets: \(selectedMatchDetails?.score?[0].w ?? 0)"
        t1Overs.text = "Overs: \(selectedMatchDetails?.score?[0].o ?? 0)"
        
        t2Innings.text = "\(selectedMatchDetails?.score?[1].inning ?? "\(selectedMatchDetails?.teamInfo?[1].shortname ?? "") Innings")"
        
        t2Runs.text = "Runs: \(selectedMatchDetails?.score?[1].r ?? 0)"
        t2Wickets.text = "Wickets: \(selectedMatchDetails?.score?[1].w ?? 0)"
        t2Overs.text = "Overs: \(selectedMatchDetails?.score?[1].o ?? 0)"
        
        let team1Name = selectedMatchDetails?.teamInfo?[0].name
        let team1Image = (selectedMatchDetails?.teamInfo?[0].img)!
        let team2Name = selectedMatchDetails?.teamInfo?[1].name
        let team2Image = (selectedMatchDetails?.teamInfo?[1].img)!
        
        t1Name.text = team1Name
        t2Name.text = team2Name
        
        t1Img.layer.cornerRadius = 30
        t2Img.layer.cornerRadius = 30
        
        
        
        Task{
            let image1 = await imageVM.getTeamImage(teamName: team1Name!, image:team1Image )
            
            let image2 = await imageVM.getTeamImage(teamName: team2Name!, image:team2Image )
            
            t1Img.image = image1
            t2Img.image = image2
        }

    }

}
