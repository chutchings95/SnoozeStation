import UIKit

class StartViewController: UIViewController {

   
    @IBAction func favouritesButton(_ sender: Any) {
    }
    @IBAction func selectStationButton(_ sender: Any) {
        
    }
    
    @IBOutlet var StnBtn: BounceButton!
    
    
    @IBOutlet var favBtn: BounceButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StnBtn.center.x = self.view.frame.width + 30
        favBtn.center.x = self.view.frame.height + 30
        
        UIView.animate(withDuration: 4.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            
            self.StnBtn.center.y = self.view.frame.width / 2
            self.favBtn.center.y = self.view.frame.height / 2
        
            }, completion: nil)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
