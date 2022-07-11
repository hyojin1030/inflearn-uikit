// PassingData
// 1. instance property
// 2. segue
// 3. instance
// 4. delegate(delegation) pattern
// 5. closure
// 6. notification

import UIKit

class ViewController: UIViewController {
    // notification
    @IBAction func moveToNoti(_ sender: Any) {
        let detailVC = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        self.present(detailVC, animated: true, completion: nil)
    }
    
    @objc func showSomeString(notification: Notification){
        if let str = notification.userInfo?["str"] as? String {
            self.dataLable.text = str
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //notification
        let notificationName = Notification.Name("sendSomeString")
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    @objc func keyboardWillShow(){
        print("will show")
    }
    @objc func keyboardDidShow(){
        print("did show")
    }

    // property
    @IBAction func moveToDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.someString = "test instance"
        self.present(detailVC, animated: true, completion: nil)
    
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if let detailVC = segue.destination as? SegueDetailViewController {
                detailVC.dataString = "test segue"
            }
        }
    }
    
    // instance
    @IBOutlet weak var dataLable: UILabel!
    @IBAction func moveToInstance(_ sender: Any) {
        let detailVC = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        detailVC.mainVC = self
        self.present(detailVC, animated: true, completion: nil)
    }
    
    // delegate
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        detailVC.delegate = self
        self.present(detailVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToClosure(_ sender: Any) {
        let detailVC = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        detailVC.myClosure = { str in
            self.dataLable.text = str
        }
        self.present(detailVC, animated: true, completion: nil)
    }
}

// delegate
extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String) {
        self.dataLable.text = string
    }
}
