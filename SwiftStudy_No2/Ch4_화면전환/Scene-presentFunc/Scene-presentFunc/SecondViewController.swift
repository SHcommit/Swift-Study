//
//  SecondViewController.swift
//  Scene-presentFunc
//
//  Created by 양승현 on 2022/03/08.
//

import UIKit

class SecondViewController : UIViewController {
    
    @IBAction func backBtn(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
