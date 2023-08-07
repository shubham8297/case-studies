//
//  File.swift
//  ToDo App
//
//  Created by Shubham.Bhalerao on 23/07/23.
//

import Foundation
import UIKit

struct taskUtility{
    static var instance = taskUtility()
    
    private let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){
        print("\(NSHomeDirectory())")
    }
    
    func addTask(id:UUID,title:String, category:String, status:String,isNotified:Bool,datetime:Date, desc:String) throws {
        
       //asf
        let task = Task(context: dbContext)
        task.id = id
        task.title = title
        task.category = category
        task.desc = desc
        task.datetime = datetime
        task.isNotified = isNotified
        task.status = status
        
        try dbContext.save()
    }
    
    func updateTask(id:UUID,title:String, category:String, status:String,isNotified:Bool,datetime:Date, desc:String) throws{
        let req = Task.fetchRequest()


        let pred = NSPredicate( format: "id == %@", argumentArray: [id])
        req.predicate = pred
        
        let task = try dbContext.fetch(req)
        let taskToUpdate = task[0]
        
        
     
        taskToUpdate.id = id
        taskToUpdate.title = title
        taskToUpdate.category = category
        taskToUpdate.status = status
        taskToUpdate.isNotified = isNotified
        taskToUpdate.datetime = datetime
        taskToUpdate.desc = desc
        
        try dbContext.save()
        
    }
    
    func deleteTask(task:Task) throws {
        dbContext.delete(task)
        
        try dbContext.save()
    }
    
    func getAllTasks() throws -> [Task]{
        
        let req = Task.fetchRequest()
        return try dbContext.fetch(req)
    }
    
    
    func getPersonalTasks(category: String) throws -> [Task]{
        
        let req = Task.fetchRequest()


        let pred = NSPredicate(format: "category == %@", argumentArray: [category])
        req.predicate = pred
        
        return try dbContext.fetch(req)
        
        
    }
    
    func getOfficialTasks(category: String) throws -> [Task]{
        
        let req = Task.fetchRequest()


        let pred = NSPredicate(format: "category == %@", argumentArray: [category])
        req.predicate = pred
        
        return try dbContext.fetch(req)
        
        
    }

}




extension UIViewController{
    func showAlert(title:String, msg:String, handler:(()->Void)?){
       let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
     
        
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
