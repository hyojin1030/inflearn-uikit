import UIKit

class SegueDetailViewController: UIViewController {
    var dataString = ""
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataLabel.text = dataString
    }
    

}
