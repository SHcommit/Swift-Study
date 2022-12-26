//
//  SecondVC.swift
//  Scene-NavigationTrans
//
//  Created by 양승현 on 2022/03/08.
//

import UIKit

class SecondViewController : UIViewController{
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

