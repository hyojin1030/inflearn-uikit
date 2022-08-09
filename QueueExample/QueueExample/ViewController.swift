// dispatch queue
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var finishLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.timerLable.text = Date().timeIntervalSince1970.description
        }
    }

    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            DispatchQueue.main.async {
                self.finishLable.text = "끝"
            }
        }
    }
    
    func simpleClosure(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            completion()
        }
        
    }
    
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
    
        queue1.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue2.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
        
    }
    
    @IBAction func action3(_ sender: Any) {
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
    
        
        // sync - 작업이 끝나기 전까지 다른 스레드를 멈춤
        queue1.sync {
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            // deadlock - 상대 작업이 끝날 때 까지 서로 기다리는 상태
            queue1.sync {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
            }
        }
        queue2.sync {
            for index in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
    
        
        
    }
    
    
}

