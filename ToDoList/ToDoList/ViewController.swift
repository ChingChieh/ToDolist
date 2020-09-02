//
//  ViewController.swift
//  ToDoList
//
//  Created by ChingChieh on 2020/8/29.
//  Copyright © 2020 ChingChieh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var uid:String = ""
    var uEmail:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func registerAction(_ sender: Any) {
        if (emailTF.text != nil) && (passwordTF.text != nil) {
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!){ (result, error) in
                if error != nil{
                    print("Register Error")
                } else {
                    self.uid = (result?.user.uid)!  // The long code for each user
                    let ref = Database.database().reference(withPath: "users").child(self.uid)
                    ref.setValue(["email":self.emailTF.text!, "password":self.passwordTF.text!])
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        if (emailTF.text != nil) && (passwordTF.text != nil) {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!){ (result, error) in
                if error != nil{
                    print("Signin Error")
                } else {
                    self.uid = (result?.user.uid)!
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        let todoVC = navigation.topViewController as! TodoView
        todoVC.userID = uid
    }
}

