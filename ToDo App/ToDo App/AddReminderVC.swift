//
//  AddReminderVC.swift
//  ToDo App
//
//  Created by Shubham.Bhalerao on 19/07/23.
//

import UIKit

class AddReminderVC: UIViewController {

    @IBOutlet weak var statusS: UISegmentedControl!
    @IBOutlet weak var categoryS: UISegmentedControl!
    @IBOutlet weak var isNotified: UISwitch!
    @IBOutlet weak var datetime: UIDatePicker!
    @IBOutlet weak var descT: UITextView!
    @IBOutlet weak var titleT: UITextField!
    
    var category:String = "Personal"
    var status: String = "Done"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Add Task"
        if category == "Personal"{
            categoryS.selectedSegmentIndex = 0
        }else{
            categoryS.selectedSegmentIndex = 1
        }
        
        if status == "Done"{
            statusS.selectedSegmentIndex = 0
        }else{
            statusS.selectedSegmentIndex = 1
        }
    }
    

    @IBAction func onAdd(_ sender: Any) {
        let title = titleT.text ?? ""
        let desc = descT.text ?? ""
        let category = category
        let date = datetime.date
        let notify = isNotified.isOn
        let status = status
        let id = UUID()
        
        do{
            try taskUtility.instance.addTask(id: id, title: title, category: category, status: status, isNotified: notify, datetime: date, desc: desc)
            showAlert(title: "Success!", msg: "Task Added!") {
                self.dismiss(animated: true)
            }
            
//            print("this is selected category: \()")
        }catch{
            showAlert(title: "Some Error", msg: "Cannot insert data!", handler: nil)
        }
    }
    @IBAction func onCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func categorySegment(_ sender: UISegmentedControl) {
        let selectionIdx = sender.selectedSegmentIndex
        
        category = sender.titleForSegment(at: selectionIdx)!
    }
    
    @IBAction func statusSegment(_ sender: UISegmentedControl) {
        let selectionIdx = sender.selectedSegmentIndex
        
        status = sender.titleForSegment(at: selectionIdx)!
    }
}
