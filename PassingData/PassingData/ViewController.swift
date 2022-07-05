// PassingData
// 1. instance property
// 2. segue

import UIKit

class ViewController: UIViewController {

    @IBAction func moveToDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        

        detailVC.someString = "test"
        
        self.present(detailVC, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

