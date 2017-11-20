//
//  MeteoViewController.swift
//  ApiMeteo
//
//  Copyright © 2017 Fabio Ziviello. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {
    
    @IBOutlet var meteoView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lblNomeCitta: UILabel!
    @IBOutlet weak var lblPrevDesc: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblTempMax: UILabel!
    @IBOutlet weak var lblTempMin: UILabel!
    @IBOutlet weak var imgIcona: UIImageView!
    
    let oMeteo=Meteo();
    let oRequest=requestHttp();
    var x = Array<Any>()
    var citta = String()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func srcMeteoNow(_ sender: Any) {
        
        oRequest.url = oMeteo.objMeteo["basePath"];
        oRequest.objParam=[oMeteo.objMeteo["citta"]!:citta+oMeteo.objMeteo["lang"]!,oMeteo.objMeteo["units"]!:oMeteo.metric,oMeteo.objMeteo["APPID"]!:oMeteo.ID];
        
        oRequest.get {mystatus,myDict in
            
            if(mystatus==200)
            {
                self.meteoView.isHidden = false
                DispatchQueue.main.async {
                    
                    
                    self.lblNomeCitta.text = self.oMeteo.getPrevisione(myDict).object(forKey: "nome") as? String
                    self.lblTemp.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "temp") as! Double)
                    self.lblTempMax.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "temp_max") as! Double)
                    self.lblTempMin.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "temp_min") as! Double)
                    self.lblPrevDesc.text = self.oMeteo.getPrevisione(myDict).object(forKey: "previsione_desc") as? String
                    let icona = "http://openweathermap.org/img/w/" + (self.oMeteo.getPrevisione(myDict).object(forKey: "icona") as? String)! + ".png"
                    let imageUrl:URL = URL(string: icona)!
                    let data = try? Data(contentsOf: imageUrl)
                    let image: UIImage = UIImage(data: data!)!
                    self.imgIcona.image = image
                }
                
            }
            else
            {
                
                let alert = UIAlertController(title: "Errore", message: "Città non trovata.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Indietro", comment: "Default action"), style: .`default`, handler: self.indietro))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        srcMeteoNow(citta)
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indietro(alertAction: UIAlertAction!) {
        self.backButton.sendActions(for: UIControlEvents.touchUpInside)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
