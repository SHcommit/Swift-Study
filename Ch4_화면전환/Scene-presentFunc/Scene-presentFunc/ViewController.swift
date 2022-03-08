//
//  ViewController.swift
//  Scene-presentFunc
//
//  Created by 양승현 on 2022/03/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func nextBtn(_ sender: Any) {
        //SecondVC를 인스턴스화
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        //화면 전환 효과
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(uvc, animated: true)
    }
}

