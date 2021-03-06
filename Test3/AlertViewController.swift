import UIKit

class AlertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var musicPickerView: UIPickerView!
    @IBOutlet var distancePickerView: UIPickerView!
    
    var sound = ["Chimes","Classic","Magic"]
    var distance: [Double] = [2,5,10]
    var selectedStation: Station!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startAlarm" {
            let controller = segue.destination as! MapViewController
            controller.alarm = sound[musicPickerView.selectedRow(inComponent: 0)]
            controller.destination = selectedStation!.coordinates
            controller.distanceFrom = distance[distancePickerView.selectedRow(inComponent: 0)]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = sound.count
        if pickerView == distancePickerView {
            
            countrows = self.distance.count
        }
        
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel { label = view }
        else { label = UILabel() }
        
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: UIFontWeightLight)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        if pickerView == musicPickerView {
            let titleRow = sound[row]
            label.text = titleRow
        } else if pickerView == distancePickerView {
            let titleRow = distance[row]
            label.text = "\(titleRow) km"
        }
        
        return label
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == musicPickerView {
            let titleRow = sound[row]
            return titleRow
        } else if pickerView == distancePickerView {
            let titleRow = distance[row]
            return "\(titleRow) km"
        }
        
        return ""
    }
    

    @IBAction func setAlarm(_ sender: Any) {
        
        let x = sound[musicPickerView.selectedRow(inComponent: 0)]
        let y = distance[distancePickerView.selectedRow(inComponent: 0)]
    
        AlarmManager.shared.setAlarm(for: selectedStation, withSound: x, atDistance: y)
       }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        }
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    }
