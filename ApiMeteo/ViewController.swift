//
//  ViewController.swift
//  ApiMeteo
//
//  Created by Fabio Ziviello on 08/11/17.
//  Copyright © 2017 Fabio Ziviello. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

    class ViewController: UIViewController , GMSAutocompleteViewControllerDelegate {
        
    var txtCitta = ""
    var nomeCitta = String();
        
    @IBOutlet weak var spinner: UIActivityIndicatorView!
        
        override var prefersStatusBarHidden: Bool {
            return true
        }

        func cerca() {
            
            let autoCompleteController = GMSAutocompleteViewController()
            autoCompleteController.delegate = self
            let filter = GMSAutocompleteFilter()
            filter.type = .city  //suitable filter type
            filter.country = "it"  //appropriate country code
            autoCompleteController.autocompleteFilter = filter
            self.present(autoCompleteController, animated: true, completion: nil)
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if txtCitta == "" {
        cerca()
        }
    }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            txtCitta = place.name
            self.dismiss(animated: false, completion: {self.performSegue(withIdentifier: "segueMeteo", sender: nil)}) // dismiss after select place
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("ERROR AUTO COMPLETE \(error)")
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMeteo" {
            nomeCitta=txtCitta;
            let openView = segue.destination as! MeteoViewController
            openView.citta = nomeCitta
        }
    }
}
