//
//  ViewController.swift
//  ToDo App
//
//  Created by Shubham.Bhalerao on 19/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var personalTask:[Task] = []
    var officialTask:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
        todoTableView.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            personalTask = try taskUtility.instance.getPersonalTasks(category: "Personal")
            todoTableView.reloadData()
        }
        catch{
            showAlert(title: "Failed to load personal tasks!", msg: "Fetch Error!", handler: nil)
        }
        
        do{
            officialTask = try taskUtility.instance.getOfficialTasks(category: "Official")
            todoTableView.reloadData()
        }
        catch{
            showAlert(title: "Failed to load Official tasks!", msg: "Fetch Error!", handler: nil)
        }
        
//        todoTableView.reloadData()
    }


    
    @IBAction func addTask(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddReminderVC") as! AddReminderVC
        

        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ViewController : UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return personalTask.count
        case 1:
            return officialTask.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        
        switch indexPath.section{
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "personal", for: indexPath)
            
            let task = personalTask[indexPath.row]
            
            cell?.textLabel?.text = task.title
            cell?.detailTextLabel?.text = task.status
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "official", for: indexPath)
            
            let task = officialTask[indexPath.row]
            
            cell?.textLabel?.text = task.title
            cell?.detailTextLabel?.text = task.status
        default:
            break
        }
        return cell!
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Personal"
        case 1:
            return "Official"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedTask: Task?
        
        if indexPath.section == 0 {
            guard indexPath.row < personalTask.count else {
                return
            }
            selectedTask = personalTask[indexPath.row]
        } else {
            guard indexPath.row < officialTask.count else {
                return
            }
            selectedTask = officialTask[indexPath.row]
        }
        print("This is the selected task: \(selectedTask!)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "EditVC") as! EditVC
        vc.taskToEdit = selectedTask
        
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var taskToDel:Task?
        
        if indexPath.section == 0 {
                guard indexPath.row < personalTask.count else {
                    return nil
                }
                taskToDel = personalTask[indexPath.row]
            } else {
                guard indexPath.row < officialTask.count else {
                    return nil
                }
                taskToDel = officialTask[indexPath.row]
            }

            guard let task = taskToDel else {
                return nil
            }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            do {
                try taskUtility.instance.deleteTask(task: task)
                if indexPath.section == 0 {
                    self.personalTask.remove(at: indexPath.row)
                } else {
                    self.officialTask.remove(at: indexPath.row)
                }
                self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.showAlert(title: "Task deleted", msg: "Task Deleted successfully!",handler: nil)
            }catch {
                self.showAlert(title: "Task not deleted", msg: "Error: \(error.localizedDescription)",handler: nil)
            }
        }
       return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}



