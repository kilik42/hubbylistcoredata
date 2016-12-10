//
//  ViewController.swift
//  HubbyList
//
//  Created by marvin evins on 12/7/16.
//  Copyright © 2016 marvin evins. All rights reserved.
//

import UIKit

class TableVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    
    var tasks : [Task] = []
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        grabData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        grabData()
        tableView.reloadData()
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        
        
        if task.today {
            
            cell.textLabel?.text = "Today:- \(task.name!)"
            
            
        }else{
            
             cell.textLabel?.text = "\(task.name)"
        }
       
        
        
        
        return cell
    }

    
    func grabData() {
        let guest = UIApplication.shared.delegate as! AppDelegate
        
        let context = guest.persistentContainer.viewContext
        
        do {
           tasks =  try context.fetch(Task.fetchRequest())
        } catch{
            
            print("failed to fetch results from database")
        }
        
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let guest = UIApplication.shared.delegate as! AppDelegate
        
        let context = guest.persistentContainer.viewContext
        
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            guest.saveContext()
            
            
            
            do {
                tasks = try context.fetch(Task.fetchRequest())
                
            } catch {
                print("deleting failed")
            }
            
            tableView.reloadData()
        }
    }
    
    
    
    
}








