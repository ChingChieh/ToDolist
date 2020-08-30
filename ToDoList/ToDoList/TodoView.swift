//
//  TodoView.swift
//  ToDoList
//
//  Created by ChingChieh on 2020/8/29.
//  Copyright © 2020 ChingChieh. All rights reserved.
//

import UIKit

struct Todo{
    var todoName: String
    var isChecked: Bool
}

class TodoView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var todoTV: UITableView!
    
    
    var userID: String?
    var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // *******************
        //let controller = UIViewController()
        //controller.isModalInPresentation = true
        //controller.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        // *******************
        todoTV.delegate = self
        todoTV.dataSource = self
        todoTV.rowHeight = 80
        
        if let uid = userID{
            welcomeLabel.text = uid
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        return cell
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
