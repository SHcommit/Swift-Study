//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by 양승현 on 2022/03/10.
//

import UIKit

class FormViewController : UIViewController{
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var isUpdate: UISwitch!
    
    @IBOutlet var interval: UIStepper!
    
    @IBAction func onSubmit(_ sender: Any) {
        
        //presentingViewController반환타입은 UIViewController .
        //다운캐스팅 필요함.
        let prevVC = self.presentingViewController
        guard let vc = prevVC as? ViewController else {
            return
        }
        
        vc.paramEmail = self.email.text
        
        vc.paramUpdate = self.isUpdate.isOn
        
        vc.paramInterval = Int(self.interval.value)
        
        self.presentingViewController?.dismiss(animated: true)
        
    }
}
