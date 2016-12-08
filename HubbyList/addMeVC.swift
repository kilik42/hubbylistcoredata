//
//  addMeVC.swift
//  HubbyList
//
//  Created by marvin evins on 12/7/16.
//  Copyright © 2016 marvin evins. All rights reserved.
//

import UIKit

class addMeVC: UIViewController {

    @IBOutlet var today: UISwitch!
    @IBOutlet var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func sendToHubby(_ sender: Any) {
        
        let guest = UIApplication.shared.delegate as! AppDelegate
        
        let context = guest.persistentContainer.viewContext
        
        let task = Task(context: context)
        
        if let name = textField.text {
            task.name = name
            
        }
        
        task.today = today.isOn
        
        // save the data to core data
        
        guest.saveContext()
        
        navigationController?.popToRootViewController(animated: true)
        
        
        
    }
    
}
