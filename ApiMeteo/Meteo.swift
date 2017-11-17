//
//  Meteo.swift
//  ApiMeteo
//
//  Created by Andrea Ceroli on 14/11/17.
//  Copyright © 2017 Fabio Ziviello. All rights reserved.
//

import Foundation

class Meteo {
    var selezione = " "
    var lang="it";
    let par_citta="q"
    let par_APPID="APPID";
    let ID="f20f4d3bfb39ba9dc5b29d4e4c7c3fdb";
    let par_basePath="https://api.openweathermap.org/data/2.5/weather";
    let units="units"
    let metric="metric"
    //    &units=metric
    
    
    var objMeteo: [String:String] {
        return [
            "lang":","+self.lang,
            "citta": self.par_citta,
            "APPID":self.par_APPID,
            "basePath":self.par_basePath,
            "units":self.units
        ]
    }
    
    func getPrevisione(_ DicResponse:NSDictionary) -> NSDictionary {
        
        return [
            "nome" :(DicResponse.object(forKey: "name") as? String) ?? "",
            "lat":((DicResponse.object(forKey: "coord") as! NSDictionary)).object(forKey: "lat") as! Double,
            "long":(DicResponse.object(forKey: "coord") as! NSDictionary).object(forKey: "lon") as! Double,
            "temp":(DicResponse.object(forKey: "main") as! NSDictionary).object(forKey: "temp") as! Double,
            "temp_max":(DicResponse.object(forKey: "main") as! NSDictionary).object(forKey: "temp_max") as! Double,
            "temp_min":(DicResponse.object(forKey: "main") as! NSDictionary).object(forKey: "temp_min") as! Double,
            "umidita":(DicResponse.object(forKey: "main") as! NSDictionary).object(forKey: "humidity") as! Double,
            "pressione":(DicResponse.object(forKey: "main") as! NSDictionary).object(forKey: "pressure") as! Double,
            "vel_vento":(DicResponse.object(forKey: "wind") as! NSDictionary).object(forKey: "speed") as! Double,
            "previsione":((DicResponse.object(forKey: "weather") as! NSArray)[0] as AnyObject).object(forKey: "main") as! String,
            "previsione_desc":((DicResponse.object(forKey: "weather") as! NSArray)[0] as AnyObject).object(forKey: "description") as! String,
            "icona":((DicResponse.object(forKey: "weather") as! NSArray)[0] as AnyObject).object(forKey: "icon") as! String
        ]
    }
}
