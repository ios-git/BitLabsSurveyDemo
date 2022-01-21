//
//  ViewController.swift
//  BitLabs-Survey-Demo
//
//  Created by developer on 20/01/22.
//

import UIKit
import BitLabsSurvey

class ViewController: UIViewController {

    @IBOutlet weak var lblSurvey: UILabel!
    
    var bitLab: BitLabsSurvey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bitLab = BitLabsSurvey(apiKey: "a8ef5ffc-f8eb-4186-8652-637f08920ddc", uid: "1")
    }
    
    @IBAction func btnCheckSurvey(_ sender: Any) {
        
        bitLab?.checkForSurveys { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .error(let err):
                    if let error = err {
                        self?.lblSurvey.text = error.localizedDescription
                    }
                case .success(let result):
                    if let err = result.error {
                        self?.lblSurvey.text = err.details?.msg
                    } else if (result.hasSurveys) {
                        self?.lblSurvey.text = "Surveys available!"
                        print("Surveys available!")
                    } else {
                        self?.lblSurvey.text = "No surveys available!"
                        print("No surveys available!")
                    }
                }
            }
        }
    }
    
    @IBAction func btnShowSurvey(_ sender: Any) {
        bitLab?.showSurvey(viewController: self)
    }
}

