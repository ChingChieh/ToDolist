//
//  TodoView.swift
//  ToDoList
//
//  Created by ChingChieh on 2020/8/29.
//  Copyright © 2020 ChingChieh. All rights reserved.
//

import UIKit

class TodoView: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    var userID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let uid = userID{
            welcomeLabel.text = uid
        }
        // Do any additional setup after loading the view.
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
