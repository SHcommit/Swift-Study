//
//  ViewController.swift
//  custom_Alert
//
//  Created by 양승현 on 2022/07/03.
//

import UIKit

class ViewController: UIViewController {
    lazy var underAlertBtn : UIButton =
    {
        let alertBtn   = UIButton()
        alertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        alertBtn.setTitle("맵 불러오기", for: .normal)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.center.y = self.view.frame.width / 2
        
        alertBtn.layer.cornerRadius = 3
        alertBtn.layer.backgroundColor = UIColor(red: 0.4556, green: 0.749, blue: 0.549, alpha: 1).cgColor
        alertBtn.layer.borderColor = UIColor(red: 0.2, green: 0.3, blue: 0.2, alpha: 0.9).cgColor
        alertBtn.setTitleColor(UIColor(red: 0, green: 0.498, blue: 0.7749, alpha: 1), for: .normal)
        
        // shadow
        let contactShadowSize = 15
        alertBtn.layer.shadowColor = UIColor.red.cgColor
        
        alertBtn.layer.shadowRadius = 15
        alertBtn.layer.shadowOpacity = 0.4
        alertBtn.layer.shadowPath    = CGPath(ellipseIn: CGRect(x: 0, y: 5, width: Int(alertBtn.frame.width), height: Int(alertBtn.frame.height)), transform: nil)
        return alertBtn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let centerAlertBtn = UIButton(frame:CGRect(x:0 ,y:100, width:100, height: 30))
        centerAlertBtn.center.x = self.view.frame.width / 2
        centerAlertBtn.layer.cornerRadius = 3
        centerAlertBtn.layer.borderColor  = UIColor(red: 0.5, green: 0.6, blue: 0.7, alpha: 1.0).cgColor
        centerAlertBtn.layer.backgroundColor = UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 0.2).cgColor
        centerAlertBtn.setTitleColor(UIColor(red: 0.5, green: 0.6, blue: 0.3, alpha: 1), for: .normal)
        centerAlertBtn.setTitle("기본 알림창", for: .normal)
        centerAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(centerAlertBtn)
        self.view.addSubview(underAlertBtn)
        
    }
}
//MARK: - event Handler
extension ViewController
{
    @objc func defaultAlert(_ sender : Any)
    {
        var alert  = UIAlertController(title: nil, message: nil, preferredStyle :.alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let ok     = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancel)
        alert.addAction(ok)
        customAlert(&alert)
        self.present(alert, animated: false)
    }
}

//MARK: - setUI
extension ViewController
{
    func customAlert(_ alert : inout UIAlertController)
    {
        let alertCenterView = UIViewController()
        
        alertCenterView.view.backgroundColor = .red
        alert.setValue(alertCenterView, forKey: "contentViewController")
    }
}
