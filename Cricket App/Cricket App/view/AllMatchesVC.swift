//
//  AllMatchesVC.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import UIKit

class AllMatchesVC: UIViewController {

    var matchesList:[LiveMatch] = []
    
    var allMatchesVM = AllMatchesVM()
    let imageVM = CurrMatchVM()
    @IBOutlet weak var allMatchesTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allMatchesTbl.dataSource = self
        allMatchesTbl.delegate = self
        Task{
            matchesList = try await allMatchesVM.getAllMatches()
//            print("Data receieved as: \(matchesList[0])")
            allMatchesTbl.reloadData()
        }
    }
}

extension AllMatchesVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Matches"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allMatches", for: indexPath) as! MatchCell
        
        let match = matchesList[indexPath.row]
        
        
        let team1 = match.teamInfo?[0].name ?? "TBC"
        let team2 = match.teamInfo?[1].name ?? "TBC"
        
        cell.name.text = match.name
        cell.t1.text = team1
        cell.t2.text = team2
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

extension AllMatchesVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CurrMatchDetails") as! CurrMatchDetailsVC
        
        let selectedMatch = matchesList[indexPath.row]
        
        vc.selectedMatchDetails = selectedMatch
        
        show(vc, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
