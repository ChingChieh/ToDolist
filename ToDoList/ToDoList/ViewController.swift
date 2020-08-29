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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerAction(_ sender: Any) {
        if (emailTF.text != nil) && (passwordTF.text != nil) {
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!){ (result, error) in
                if error != nil{
                    print("Register Error")
                } else {
                    let uid = result?.user.uid
                    let ref = Database.database().reference(withPath: "users").child(uid!)
                    ref.setValue(["email":self.emailTF.text!, "password":self.passwordTF.text!])
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
                    //let uid = result?.user.uid
                
                }
            }
        }
    }
    
}

