//
//  ViewController.swift
//  customNavigationBar
//
//  Created by 양승현 on 2022/07/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if var navigation = self.navigationController
        {
            
            var customNavi = CustomNavi(&navigation)
            // 네비게이션 컨트롤러에 네비게이션 아이템 제목으로 타이틀 설정하면 적용 안되
            //self.navigationController?.navigationItem.titleView = customNavi.containerView
            //이렇게 해야함
            //self.navigationItem.titleView = customNavi.containerView
            likeChromeSearchNavi()
        }else
        {
            NSLog("커스텀 네비 적용 안됨")
        }
        
    }
    

}
extension ViewController
{
    func setSwiftLogoInNaviBar()
    {
        let image  = UIImage(named:"swift_logo")
        let imageV = UIImageView(image: image)
        
        self.navigationItem.titleView = imageV
    }
    func setSearchTextFieldInNaviBar()
    {
        let tf             = UITextField()
        tf.frame           = CGRect(x:0  ,y:0, width:300, height : 35)
        tf.backgroundColor = .white
        tf.font            = UIFont.systemFont(ofSize: 13)
        
        tf.autocapitalizationType = .none
        tf.autocorrectionType     = .no
        tf.spellCheckingType      = .no
        tf.keyboardType           = .URL
        tf.keyboardAppearance     = .dark
        tf.layer.borderWidth      = 0.3
        tf.layer.borderColor      = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        self.navigationItem.titleView = tf
    }
    func divideLRCenterSection()
    {
        let lv             = UIView()
        lv.frame           = CGRect(x: 0, y : 0, width :150, height : 37)
        lv.backgroundColor = .brown
        let rv             = UIView()
        rv.frame           = CGRect(x:0, y:0, width:100, height: 37)
        rv.backgroundColor = .red
        let rightItem      = UIBarButtonItem(customView: rv)
        let leftItem       = UIBarButtonItem(customView: lv)
        self.navigationItem.leftBarButtonItem  = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
    }
    func likeChromeSearchNavi()
    {
        let back     = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(image: back, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let centerTf             = UITextField()
        centerTf.frame           = CGRect(x: 0, y: 0, width: 300, height: 35)
        centerTf.backgroundColor = .white
        centerTf.font            = UIFont.systemFont(ofSize: 13)
        
        centerTf.autocorrectionType     = .no
        centerTf.autocapitalizationType = .none
        centerTf.spellCheckingType      = .no
        centerTf.keyboardType           = .URL
        centerTf.keyboardAppearance     = .dark
        centerTf.layer.borderWidth      = 0.3
        centerTf.layer.borderColor      = UIColor(red: 0.60, green: 0.6, blue: 0.8, alpha: 1.0).cgColor
        self.navigationItem.titleView = centerTf
        
        let  rv = UILabel()
        rv.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        let rItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rItem
        
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font  = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
        cnt.text = "12"
        cnt.textAlignment = .center
        cnt.layer.cornerRadius = 3
        cnt.layer.borderWidth = 2
        cnt.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1).cgColor
        
        rv.addSubview(cnt)
        
        let more   = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        
        rv.addSubview(more)
    }
}
