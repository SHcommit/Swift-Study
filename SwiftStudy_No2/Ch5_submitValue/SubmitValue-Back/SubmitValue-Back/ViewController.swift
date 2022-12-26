//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by 양승현 on 2022/03/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var resultEmail: UILabel!
    
    @IBOutlet var resultUpdate: UILabel!
    
    @IBOutlet var resultInterval: UILabel!
    
    
    var paramEmail : String?
    var paramUpdate : Bool?
    var paramInterval : Int?
    
    override func viewWillAppear(_ animated: Bool) {
        if let email = paramEmail{
            resultEmail.text = email
        }
        if let update = paramUpdate {
            resultUpdate.text = update ? "자동 갱신" : "갱신 안함"
        }
        if let interval = paramInterval {
            resultInterval.text = "\(interval) 초 마다 갱신함"
        }
    }
   
    @IBAction func onRegist(_ sender: Any) {
        let SecondVC = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC")
        
        SecondVC.modalTransitionStyle = .coverVertical
        
        present(SecondVC,animated: true)
    }
    
}
