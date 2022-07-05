//
//  ViewController.swift
//  custom_Alert
//
//  Created by 양승현 on 2022/07/03.
//

import UIKit
import MapKit
/**
 * 초기 구현 in main ViewController
 * 그냥 lazy로 button에 속성과 쉐도우 등을 구현했다.
 * viewDidLoad안에도 버튼 한개 구현했다
 * 그후 extension으로 AlertUI설정과 button이벤트 헨들러를 구현했다.
 * 동영상으로 찍은 화면은 버튼 2개만 구현했을 뿐인데 화면이 너무 길어졌다.
 * 또한 alert를 설정할 때도 매번 같은 문구가 많이 들어갔다 코드 리펙토링이 시급했다.
 *
 * 그래서 중첩되는 alert의 디폴트 클래스를 만들었고 버튼 또한 중첩되는 속성이 많았다.
 * CallAlertButtonVO에 alert와 button의 default 속성을 정의해 주었다 ( 위치에 따른 self.veiw.subView(버튼 추가) 등..
 *
 * 이후 구현하고 싶은 alert 속성에 따라서 특정한 CustomAlert 클래스를 통해 UI 개선 작업만 해주도록 Model을 구현했다.
 */
class ViewController: UIViewController {
    var midAlertVO   = CustomCenterAlertVO()
    var imageAlertVO = CustomImageAlertVO()
    var tableAlertVO = CustomTableAlertVO()
    var mapAlertVO   = CustomMapAlertVO()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //간단한 center 알림 구현
        midAlertVO.centerAlert.alert = midAlertVO.centerAlert.defaultAlert(nil, nil, .actionSheet)
        midAlertVO.centerAlert.addButtonObject(&self.view, &midAlertVO.centerAlert.callAlertButton, "centerAlert", UIColor.lightGray, 1)
        midAlertVO.centerAlert.callAlertButton.addTarget(self, action: #selector(customCenterAlert(_:)), for: .touchUpInside)
        
        //이미지 알림 구현
        imageAlertVO.imageAlert.alert = imageAlertVO.imageAlert.defaultAlert(nil, nil, .alert)
        imageAlertVO.imageAlert.addButtonObject(&self.view, &imageAlertVO.imageAlert.callAlertButton, "imageAlert", UIColor.gray, 2)
        imageAlertVO.imageAlert.callAlertButton.addTarget(self, action: #selector(customImageAlert(_:)), for: .touchUpInside)
        
        //맵 알림 구현
        mapAlertVO.mapAlert.addButtonObject(&self.view, &mapAlertVO.mapAlert.callAlertButton, "mapAlert", UIColor.gray, 3)
        mapAlertVO.mapAlert.alert =  mapAlertVO.mapAlert.defaultAlert("여기 국밥 꿀 맛집", nil, .alert)
        mapAlertVO.mapAlert.callAlertButton.addTarget(self, action: #selector(customMapAlert(_:)), for: .touchUpInside)
        
        //목록 알림 구현
        tableAlertVO.tableAlert.addButtonObject(&view, &tableAlertVO.tableAlert.callAlertButton, "table버튼", UIColor.blue, 4)
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
        
    @objc func customCenterAlert(_ sender : Any)
    {
        midAlertVO.customCenterAlertUI(&midAlertVO.centerAlert.alert)
        self.present(midAlertVO.centerAlert.alert, animated: true)
    }
    
    @objc func customImageAlert(_ sender: Any)
    {
        imageAlertVO.customIamgeAlertUI(&imageAlertVO.imageAlert.alert)
        self.present(imageAlertVO.imageAlert.alert, animated: true)
    }
    
    @objc func customMapAlert(_ sender : Any)
    {
        mapAlertVO.customMapAlertUI(&mapAlertVO.mapAlert.alert)
        self.present(mapAlertVO.mapAlert.alert, animated: true)
    }
    
    @objc func customTableAlert(_ sender : Any)
    {
        tableAlertVO.customTableAlertUI(&tableAlertVO.tableAlert.alert)
        self.present(tableAlertVO.tableAlert.alert, animated: true)
    }
    
}

//MARK: - setUI
// Model을 통해 구현함 더 이상 안쓰임.
//extension ViewController
//{
//    func customAlert(_ alert : inout UIAlertController)
//    {
//        let alertCenterView = UIViewController()
//
//        alertCenterView.view.backgroundColor = .red
//        alert.setValue(alertCenterView, forKey: "contentViewController")
//    }
//
//    func customAlertShowMapState(_ alert : inout UIAlertController)
//    {
//        let contentVC     = UIViewController()
//        let mapkitView    = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        contentVC.view    = mapkitView
//        let pos           = CLLocationCoordinate2D(latitude: 37.514322, longitude: 126.894623)
//        let span          = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        let region        = MKCoordinateRegion(center: pos, span: span)
//        mapkitView.region = region
//        mapkitView.regionThatFits(region)
//
//        let point = MKPointAnnotation()
//        point.coordinate = pos
//        mapkitView.addAnnotation(point)
//        contentVC.preferredContentSize.height = 180
//        alert.setValue(contentVC, forKey: "contentViewController")
//    }
//
//    func customAlertShowImageUI(_ alert : inout UIAlertController)
//    {
//        let VC = UIViewController()
//        let image = UIImage(named: "rating5")
//        let imgObject = UIImageView(image: image)
//        imgObject.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
//        imgObject.layoutMargins.bottom = 10.0
//        //마진주고싶은데 이건 안 되네 VC를 바꿔줘야함
//        //imgObject.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
//
//        VC.view.addSubview(imgObject)
//
//        VC.preferredContentSize = CGSize(width: (image?.size.width)!, height: (image?.size.height)! + 10)
//
//
//        alert.setValue(VC, forKey: "contentViewController")
//    }
//}
