//
//  TodoView.swift
//  ToDoList
//
//  Created by ChingChieh on 2020/8/29.
//  Copyright © 2020 ChingChieh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        
        loadTodos()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let todoAlert = UIAlertController(title: "New Task", message: "Add a todo", preferredStyle: .alert)
        
        todoAlert.addTextField()
        
        let addTodoAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let todoText = todoAlert.textFields![0].text
            self.todos.append(Todo(todoName: todoText!, isChecked: false))
            
            let ref = Database.database().reference(withPath: "users").child(self.userID!).child("todos")
            ref.child(todoText!).setValue(["isChecked" : false])
            
            self.todoTV.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        todoAlert.addAction(addTodoAction)
        todoAlert.addAction(cancelAction)
        
        present(todoAlert, animated: true, completion: nil)
    }
    
    func loadTodos(){
        let ref = Database.database().reference(withPath: "users").child(userID!).child("todos")
        ref.observeSingleEvent(of: .value){ (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let todoName = child.key
                let todoRef = ref.child(todoName)
                
                todoRef.observeSingleEvent(of: .value, with: {(todoSnapshot) in
                    let value = todoSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    self.todos.append(Todo(todoName: todoName, isChecked: isChecked!)) //former is from todo struct and latter is from firebase
                    self.todoTV.reloadData()
                })
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        // display todo list
        cell.todoLabel.text = todos[indexPath.row].todoName
        if todos[indexPath.row].isChecked {
            cell.checkmarkImage.image = UIImage(named: "checkmark.png")
        }
        else {
            cell.checkmarkImage.image = nil
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: "users").child(userID!).child("todos").child(todos[indexPath.row].todoName)
        
        if todos[indexPath.row].isChecked{
            todos[indexPath.row].isChecked = false
            ref.updateChildValues(["isChecked" : false])
        } else {
            todos[indexPath.row].isChecked = true
            ref.updateChildValues(["isChecked" : true])
        }
        todoTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let ref = Database.database().reference(withPath: "users").child(userID!).child("todos").child(todos[indexPath.row].todoName)
            ref.removeValue()
            todos.remove(at: indexPath.row)
            todoTV.reloadData()
        }
    }

}
