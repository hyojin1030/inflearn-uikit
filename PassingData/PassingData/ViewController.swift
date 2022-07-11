// PassingData
// 1. instance property
// 2. segue
// 3. instance
// 4. delegate(delegation) pattern

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.present(detailVC, animated: true, completion: nil)
    }
    
    


}

extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String) {
        self.dataLable.text = string
    }
}
