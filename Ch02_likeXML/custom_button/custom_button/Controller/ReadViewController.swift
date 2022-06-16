//
//  ReadViewController.swift
//  custom_button
//
//  Created by 양승현 on 2022/06/16.
//

import UIKit

class ReadViewController : UIViewController
{
    var pEmail    : String?
    var pUpdate   : Bool?
    var pInterval : Double?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let email    = UILabel()
        let update   = UILabel()
        let interval = UILabel()
    }
}
