//
//  ViewController.swift
//  apiTest
//
//  Created by 양승현 on 2022/08/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let urlPath = "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime"
    
    @IBOutlet weak var currentTime: UILabel!
    @IBAction func callCurrentTime(_ sender: Any)
    {
        do
        {
            guard let url = URL(string: urlPath) else {return}
            let response = try String(contentsOf: url)
            self.currentTime.text = response
            self.currentTime.sizeToFit()
        }
        catch let err as NSError
        {
            NSLog(err.localizedDescription)
        }
    }
    
}

