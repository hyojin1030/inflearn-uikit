//
//  ViewController.swift
//  TodoList
//
//  Created by 주효진 on 2022/09/20.
//

import UIKit
import CoreData

enum PriorityLevel: Int64 {
    case level1
    case level2
    case level3
}

extension PriorityLevel {
    var color: UIColor {
        switch self {
        case .level1 :
            return .green
        case .level2 :
            return .orange
        case .level3 :
            return .red
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var todoList = [TodoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeNavigationBar()
        
        todoTableView.delegate = self
        todoTableView.dataSource = self
     
        fetchData()
        todoTableView.reloadData()
        
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        let context = appdelegate.persistentContainer.viewContext
        
        do {
            self.todoList = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }
    
    func makeNavigationBar() {
        self.title = "To Do List"
        
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        item.tintColor = .black
        self.navigationItem.rightBarButtonItem = item

        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue.withAlphaComponent(0.2)
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
    }
    
    @objc func addNewTodo() {
        let detailVC = TodoDetailViewController.init(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        self.present(detailVC, animated: true)
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        
        cell.topTitleLabel.text = todoList[indexPath.row].title
        
        if let hasDate = todoList[indexPath.row].date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd hh:mm:ss"
            let dateString = formatter.string(from: hasDate)
            
            cell.dataLabel.text = dateString
        } else {
            cell.dataLabel.text = ""
        }
         
        let priority = todoList[indexPath.row].priorityLevel
        let priorityColor = PriorityLevel(rawValue: priority)?.color
        cell.priorityView.backgroundColor = priorityColor
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TodoDetailViewController.init(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        detailVC.selectedTodoList = todoList[indexPath.row]
        self.present(detailVC, animated: true)
    }
    
}

extension ViewController: TodoDetailViewControllerDelegate {
    func didFinishSaveData() {
        self.fetchData()
        self.todoTableView.reloadData()
    }
    
    
}
