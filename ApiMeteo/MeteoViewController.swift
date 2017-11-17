//
//  MeteoViewController.swift
//  ApiMeteo
//
//  Created by Andrea Ceroli on 14/11/17.
//  Copyright © 2017 Fabio Ziviello. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {
    
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
            
            
            DispatchQueue.main.async {
                
                
                //var a = self.oMeteo.getPrevisioneNow(myDict)
                self.lblNomeCitta.text = self.oMeteo.getPrevisione(myDict).object(forKey: "nome") as? String
//                self.lblLat.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "lat") as! Double)
//                self.lblLong.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "long") as! Double)
                self.lblTemp.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "temp") as! Double)
                self.lblTempMax.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "temp_max") as! Double)
                self.lblTempMin.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "temp_min") as! Double)
//                self.lblUmidita.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "umidita") as! Double)
                self.lblPrevDesc.text = self.oMeteo.getPrevisione(myDict).object(forKey: "previsione_desc") as? String
//                self.lblVelVento.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "vel_vento") as! Double)
//                self.lblPressione.text = String(describing: self.oMeteo.getPrevisione(myDict).object(forKey: "pressione") as! Double)
                
                let icona = "http://openweathermap.org/img/w/" + (self.oMeteo.getPrevisione(myDict).object(forKey: "icona") as? String)! + ".png"
                let imageUrl:URL = URL(string: icona)!
                
                //let data: Data = try! Data(contentsOf: imageUrl)
                let data = try? Data(contentsOf: imageUrl)
                let image: UIImage = UIImage(data: data!)!
                
                self.imgIcona.image = image
                
                
                
//                let icona = "http://openweathermap.org/img/w/" + (self.oMeteo.getPrevisione(myDict).object(forKey: "icona") as? String)! + ".png"
//                let imageUrl:URL = URL(string: icona)!
//                
//                
//                let data = try? Data(contentsOf: imageUrl)
//                let image: UIImage = UIImage(data: data!)!
//                
//                self.imgIcona.image = image
                
                //print(self.oRequest)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        srcMeteoNow(citta)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
