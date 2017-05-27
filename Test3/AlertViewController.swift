import UIKit

class AlertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    

    @IBOutlet weak var musicPickerView: UIPickerView!
    @IBOutlet var distancePickerView: UIPickerView!
    
    @IBAction func setAlarmButton(_ sender: Any) {
    }
    @IBAction func alertBackButton(_ sender: Any) {
        
    }
    
    
    
    var sound = ["Chimes","Classic","Magic"]
    var distance = ["2km","5km"]
    
   
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = sound.count
        if pickerView == distancePickerView {
            
            countrows = self.distance.count
        }
        
        return countrows
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == musicPickerView {
            
            let titleRow = sound[row]
            return titleRow
            
        }
            
            else if pickerView == distancePickerView{
            let titleRow = distance[row]
            return titleRow
        }
        
        return ""
    }
    

    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        }
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(StationManager.shared.chosenStation?.name)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    }
