//
//  EditVC.swift
//  ToDo App
//
//  Created by Shubham.Bhalerao on 24/07/23.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var categoryS: UISegmentedControl!
    @IBOutlet weak var statusS: UISegmentedControl!
    
    @IBOutlet weak var datetimeD: UIDatePicker!
    @IBOutlet weak var isNotify: UISwitch!
    
    @IBOutlet weak var descL: UITextView!
    @IBOutlet weak var titleL: UITextField!
    
    var id:UUID?
    var category:String = ""
    var status:String = ""
    
    var taskToEdit : Task?
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Task to edit received as: \(taskToEdit!)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        if let task = taskToEdit{
            
            category = task.category!
            status = task.status!
            isNotify.isOn = task.isNotified
            titleL.text = task.title
            descL.text = task.desc
            id = task.id
            
//            datetimeD.date = task.datetime!
            if let date = task.datetime{
                datetimeD.date = date
            }
            if let category = task.category{
                if category == "Personal"{
                    categoryS.selectedSegmentIndex = 0
                }else{
                    categoryS.selectedSegmentIndex = 1
                }
            }
            if let status = task.status{
                if status == "Done"{
                    statusS.selectedSegmentIndex = 0
                }else{
                    statusS.selectedSegmentIndex = 1
                }
            }
            
        }
    }
    
    @IBAction func onEdit(_ sender: Any) {
        let title = titleL.text ?? ""
        let desc = descL.text ?? ""
        let category = category
        let date = datetimeD.date
        let notify = isNotify.isOn
        let status = status
//        let id = id
        do{
            try taskUtility.instance.updateTask(id: id!, title: title, category: category, status:status, isNotified: notify, datetime: date, desc: desc)
            
            showAlert(title: "Success!", msg: "Task Updated!") {
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }catch{
            showAlert(title: "Error", msg: "Update task failed!", handler: nil)
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onStatusChange(_ sender: UISegmentedControl) {
        let selectionIdx = sender.selectedSegmentIndex
        
        status = sender.titleForSegment(at: selectionIdx)!
        
    }
    
    @IBAction func onCategoryChange(_ sender: UISegmentedControl) {
        let selectionIdx = sender.selectedSegmentIndex
        
            category = sender.titleForSegment(at: selectionIdx)!
        
    }
    /*
    // MARK: - Navigation

     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
