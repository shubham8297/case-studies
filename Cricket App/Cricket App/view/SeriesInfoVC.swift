//
//  SeriesInfoVC.swift
//  Cricket App
//
//  Created by Shubham.Bhalerao on 02/08/23.
//

import UIKit

class SeriesInfoVC: UIViewController {
    var seriesInfoVM = SeriesInfoVM()
    let imageVM = CurrMatchVM()
    var seriesMatches:[LiveMatch] = []
    
    @IBOutlet weak var SeriesTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        SeriesTbl.dataSource = self
        SeriesTbl.delegate = self
        
        Task{
            seriesMatches = await seriesInfoVM.getSeriesMatches()
            SeriesTbl.reloadData()
        }
    }
}

extension SeriesInfoVC: UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Indian Premier League"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seriesMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seriesMatch", for: indexPath) as! MatchCell
        
        let match = seriesMatches[indexPath.row]
        
        
        
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

extension SeriesInfoVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CurrMatchDetails") as! CurrMatchDetailsVC
        let selectedMatch = seriesMatches[indexPath.row]
        
        vc.selectedMatchDetails = selectedMatch
        
        show(vc, sender: self)
        

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
