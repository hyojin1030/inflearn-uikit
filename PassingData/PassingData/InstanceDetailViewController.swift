import UIKit

class InstanceDetailViewController: UIViewController {
    
    var mainVC: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func sendDataMainVc(_ sender: Any) {
        mainVC?.dataLable.text = "some data"
        self.dismiss(animated: true, completion: nil)
    }
    
}
