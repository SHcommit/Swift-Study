//
//  ViewController.swift
//  Scene-NavigationTrans
//
//  Created by 양승현 on 2022/03/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func MoveByNavy(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
}

