//
//  CurrentMatchesVC.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 30/07/23.
//

import UIKit

class CurrentMatchesVC: UIViewController {

    let currMatchesVM = CurrMatchesVM()
    let imageVM = CurrMatchVM()
    var currMatches:[LiveMatch] = []
    

    @IBOutlet weak var c_MatchesTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        c_MatchesTbl.dataSource = self
        c_MatchesTbl.delegate = self
        Task{
            currMatches = await currMatchesVM.getAllCurrentMatches()
            c_MatchesTbl.reloadData()
//          print("Data: \(currMatches[0])")
           

        }
    }
    
    

}

extension CurrentMatchesVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Current Matches"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currMatches", for: indexPath) as! MatchCell
        let match = currMatches[indexPath.row]
        
    
        
        let team1 = match.teamInfo?[0].shortname ?? "TBC"
        let team2 = match.teamInfo?[1].shortname ?? "TBC"



        let count = match.score?.count
        
        
        
        if count! > 1{
            cell.t2Runs.text = "\(match.score?[1].r ?? 0)"
            cell.t2W.text = "\(match.score?[1].w ?? 0)"
            cell.t2O.text = "(\(match.score?[1].o ?? 0))"
            }else{
                cell.t2Runs.text = "N/A"
                cell.t2W.text = "N/A"
                cell.t2O.text = "N/A"
            }
        
        
//        print("\(team1) VS \(team2)")
        
        cell.name.text = match.name
        cell.t1.text = team1
        cell.t2.text = team2
        cell.t1Runs.text = "\(match.score?[0].r ?? 0)"
        cell.t1W.text = "\(match.score?[0].w ?? 0)"
        cell.t1O.text = "(\(match.score?[0].o ?? 0))"
        cell.status.text = match.status

        Task{
            let image1 = await imageVM.getTeamImage(teamName:(match.teamInfo?[0].name!)!,image:(match.teamInfo?[0].img!)!)
            let image2 = await imageVM.getTeamImage(teamName:(match.teamInfo?[1].name!)!,image:(match.teamInfo?[1].img!)!)
            
            cell.t1Img.image = image1
            cell.t2Img.image = image2
        }
        
        return cell
    }
}

extension CurrentMatchesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CurrMatchDetails") as! CurrMatchDetailsVC
        
        let selectedMatch = currMatches[indexPath.row]

        vc.selectedMatchDetails = selectedMatch
        
        show(vc, sender: self)
        
       
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
}
