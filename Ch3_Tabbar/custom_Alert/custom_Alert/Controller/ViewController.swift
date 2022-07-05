//
//  ViewController.swift
//  custom_Alert
//
//  Created by 양승현 on 2022/07/03.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    var tableAlertVO = CustomTableAlertVO()
    var mapAlertVO   = CustomMapAlertVO()
    
    lazy var underAlertBtn : UIButton =
    {
        let alertBtn   = UIButton()
        alertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        alertBtn.setTitle("맵 불러오기", for: .normal)
        alertBtn.center.x = self.view.frame.width / 2
        alertBtn.center.y = self.view.frame.width / 2
        
        alertBtn.layer.cornerRadius    = 3
        alertBtn.layer.backgroundColor = UIColor(red: 0.4556, green: 0.749, blue: 0.549, alpha: 1).cgColor
        alertBtn.layer.borderColor     = UIColor(red: 0.2, green: 0.3, blue: 0.2, alpha: 0.9).cgColor
        alertBtn.setTitleColor(UIColor(red: 0, green: 0.498, blue: 0.7749, alpha: 1), for: .normal)
        
        // shadow
        let contactShadowSize = 15
        alertBtn.layer.shadowColor = UIColor.red.cgColor
        
        alertBtn.layer.shadowRadius  = 15
        alertBtn.layer.shadowOpacity = 0.4
        alertBtn.layer.shadowPath    = CGPath(ellipseIn: CGRect(x: 0, y: 5, width: Int(alertBtn.frame.width), height: Int(alertBtn.frame.height)), transform: nil)
        return alertBtn
    }()
    
    lazy var imageAlertBtn : UIButton =
    {
        let imageBtn   = UIButton(type: .system)
        imageBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        imageBtn.center.x = self.view.frame.width / 2
        imageBtn.center.y = self.view.frame.height / 2 - 60
        
        imageBtn.layer.cornerRadius = 2
        imageBtn.setTitle("이미지 alert", for: .normal)
        return imageBtn
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
        underAlertBtn.addTarget(self, action: #selector(customAlertShowMap(_:)), for: .touchUpInside)
        imageAlertBtn.addTarget(self, action: #selector(customAlertShowImage(_:)), for: .touchUpInside)
        self.view.addSubview(centerAlertBtn)
        self.view.addSubview(underAlertBtn)
        self.view.addSubview(imageAlertBtn)
        

        mapAlertVO.mapAlert.addButtonObject(&self.view, &mapAlertVO.mapAlert.callAlertButton, "mapAlert", UIColor.gray, 4)
        mapAlertVO.mapAlert.alert =  mapAlertVO.mapAlert.defaultAlert("여기 국밥 꿀 맛집", nil, .alert)
        mapAlertVO.mapAlert.callAlertButton.addTarget(self, action: #selector(customMapAlert(_:)), for: .touchUpInside)
        
        tableAlertVO.tableAlert.addButtonObject(&view, &tableAlertVO.tableAlert.callAlertButton, "table버튼", UIColor.blue, 5)
        tableAlertVO.addTableAlert("5개의 옵션이 있어요", message: nil, .alert)
        tableAlertVO.tableAlert.callAlertButton.addTarget(self, action: #selector(customTableAlert(_:)), for: .touchUpInside)
    }
}

//MARK: - event Handler
/**
 * 여기서 alert의 UI + present작업을 수행합니다.
 */
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
    @objc func customAlertShowMap(_ sender : Any)
    {
        var alert = UIAlertController(title: "여기 맞나요?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        customAlertShowMapState(&alert)
        
        self.present(alert, animated: true)
    }
    
    @objc func customAlertShowImage(_ sender : Any)
    {
        var alert = UIAlertController(title : nil,message: "평점은?!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        customAlertShowImageUI(&alert)
        self.present(alert, animated: true)
    }
    
    @objc func customMapAlert(_ sender : Any)
    {
        mapAlertVO.customMapAlert(&mapAlertVO.mapAlert.alert)
        self.present(mapAlertVO.mapAlert.alert, animated: true)
    }
    
    @objc func customTableAlert(_ sender : Any)
    {
        tableAlertVO.customTableAlertUI(&tableAlertVO.tableAlert.alert)
        self.present(tableAlertVO.tableAlert.alert, animated: true)
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
    
    func customAlertShowMapState(_ alert : inout UIAlertController)
    {
        let contentVC     = UIViewController()
        let mapkitView    = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        contentVC.view    = mapkitView
        let pos           = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
        let span          = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region        = MKCoordinateRegion(center: pos, span: span)
        mapkitView.region = region
        mapkitView.regionThatFits(region)
        
        let point = MKPointAnnotation()
        point.coordinate = pos
        mapkitView.addAnnotation(point)
        contentVC.preferredContentSize.height = 180
        alert.setValue(contentVC, forKey: "contentViewController")
    }
    
    func customAlertShowImageUI(_ alert : inout UIAlertController)
    {
        let VC = UIViewController()
        let image = UIImage(named: "rating5")
        let imgObject = UIImageView(image: image)
        imgObject.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
        imgObject.layoutMargins.bottom = 10.0
        //마진주고싶은데 이건 안 되네 VC를 바꿔줘야함
        //imgObject.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        VC.view.addSubview(imgObject)
        
        VC.preferredContentSize = CGSize(width: (image?.size.width)!, height: (image?.size.height)! + 10)
        

        alert.setValue(VC, forKey: "contentViewController")
    }
}
