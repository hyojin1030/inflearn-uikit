//
//  TodoDetailViewController.swift
//  TodoList
//
//  Created by 주효진 on 2022/09/20.
//

import UIKit
import CoreData

protocol TodoDetailViewControllerDelegate: AnyObject {
    func didFinishSaveData()
}

class TodoDetailViewController: UIViewController {
    weak var delegate: TodoDetailViewControllerDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var selectedTodoList: TodoList?
    
    var priority: PriorityLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let hasData = selectedTodoList {
            titleTextField.text = hasData.title
            priority = PriorityLevel(rawValue: hasData.priorityLevel)
            makePriorityButtonDesign()
            
            saveButton.setTitle("Update", for: .normal)
            deleteButton.isHidden = false
        } else {
            saveButton.setTitle("Save", for: .normal)
            deleteButton.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highButton.layer.cornerRadius = highButton.bounds.height / 2
    }
    
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default :
            break
        }
        
        makePriorityButtonDesign()

    }
    
    func makePriorityButtonDesign() {
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch self.priority {
        case .level1 :
            lowButton.backgroundColor = priority?.color
        case .level2 :
            normalButton.backgroundColor = priority?.color
        case .level3 :
            highButton.backgroundColor = priority?.color
        default : break
                    
        }
        
    }
    
    @IBAction func saveTodo(_ sender: Any) {
        if selectedTodoList != nil {
            updateTodo()
        } else {
            saveTodo()
        }
        
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
    func saveTodo() {
        guard let entityDesription = NSEntityDescription.entity(forEntityName: "TodoList", in: context) else { return }
        
        guard let object = NSManagedObject(entity: entityDesription, insertInto: context) as? TodoList else {
            return
        }
        
        object.title = titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        object.priorityLevel = priority?.rawValue ?? PriorityLevel.level1.rawValue
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
        
    }
    
    func updateTodo() {
        guard let hasData = selectedTodoList else { return }
        
        guard let hasUuid = hasData.uuid else { return }
    
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUuid as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            loadedData.first?.title = titleTextField.text
            loadedData.first?.date = Date()
            loadedData.first?.priorityLevel = self.priority?.rawValue ?? PriorityLevel.level1.rawValue
            
            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            appDelegate.saveContext()
        } catch {
            print(error)
        }
        
    }
 
    @IBAction func deleteTodo(_ sender: Any) {
        guard let hasData = selectedTodoList else { return }
        
        guard let hasUuid = hasData.uuid else { return }
    
        let fetchRequest: NSFetchRequest<TodoList> = TodoList.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid = %@", hasUuid as CVarArg)
        
        do {
            let loadedData = try context.fetch(fetchRequest)
            
            if let loadData = loadedData.first {
                context.delete(loadData)
                
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.saveContext()
            }
            
        } catch {
            print(error)
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true)
    }
    
}
