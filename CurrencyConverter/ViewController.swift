//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Utku Kaan Gülsoy on 23.04.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getRatesClicked(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=c3da0d80655c8908a817dfcf13240bdf")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true , completion: nil)
            }
            else
            {
                if data != nil
                {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]
                            {
                                if let cad = rates["CAD"] as? Double
                                {
                                    self.cadLabel.text = "CAD: " + String(cad)
                                }
                                if let chf = rates["CHF"] as? Double
                                {
                                    self.chfLabel.text = "CHF: " + String(chf)
                                }
                                if let gbp = rates["GBP"] as? Double
                                {
                                    self.gbpLabel.text = "GBP: " + String(gbp)
                                }
                                if let jpy = rates["JPY"] as? Double
                                {
                                    self.jpyLabel.text = "JPY: " + String(jpy)
                                }
                                if let usd = rates["USD"] as? Double
                                {
                                    self.usdLabel.text = "USD: " + String(usd)
                                }
                                if let tury = rates["TRY"] as? Double
                                {
                                    self.tryLabel.text = "TRY: " + String(tury)
                                }
                            }
                        }
                    }
                    catch
                    {
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
    }
    
}

