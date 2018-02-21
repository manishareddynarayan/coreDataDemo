//
//  ViewController.swift
//  coreDataDemo
//
//  Created by N Manisha Reddy on 2/12/18.
//  Copyright © 2018 N Manisha Reddy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var passwordTextFeild: UITextField!
    @IBOutlet weak var usernameTextFeild: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBAction func loginButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        
        let newEntry = NSEntityDescription.insertNewObject(forEntityName: "Users" ,into: context)
        newEntry.setValue(usernameTextFeild.text,forKey: "username")
        newEntry.setValue(passwordTextFeild.text,forKey: "password")
        do {
            try context.save()
            usernameTextFeild.alpha = 0
            passwordTextFeild.alpha = 0
            label.alpha = 1
            label.text = "hey" + usernameTextFeild.text + "your password is" + passwordTextFeild.text + "!"
        } catch  {
            print("entry failed")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "username") as? String {
                    if let password = result.value(forKey: "password") as? String {
                        usernameTextFeild.alpha = 0
                        passwordTextFeild.alpha = 0
                        label.alpha = 1
                        label.text = "hey" + username + "your password is" + password + "!"
                    }
                }
            }
        }catch {
            print("no result")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

