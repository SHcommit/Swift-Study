//
//  TheaterViewController.swift
//  MovieChart-tabBar
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit
import MapKit

class TheaterViewController: UIViewController{
    //REST API를 통해 받은 JSON형식 데이터 저장할 변수
    var param : NSDictionary!
    
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        self.navigationItem.title = self.param["상영관명"] as? String
        
        setCoord()
    }
    
   
    private func setCoord(){
        //NSString은 String에 없는 doubleValue 사용가능해서!
        let lag = (param?["위도"] as! NSString).doubleValue
        let lng = (param?["경도"] as! NSString).doubleValue
        
        // 위도 경도를 인수로하는 2D 위치 정보 객체 ( 위치 저장)
        // 맵의 중심좌표가 됨
        let location = CLLocationCoordinate2DMake(lag, lng)
        // 지도에 표현될 거리 ( 단위 m) - 축척값,,
        let regionRadius: CLLocationDistance = 100
        
        //거리 반영한 지역 정보 조합한 지도 데이터 생성
        //가로, 세로 거리 == regionRadius로 동일하게 설정
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        //setRegion()을 통해 MKCoordinateRegionMakeWithDistance 객체가 맵 뷰에 전달 된다.
        self.map.setRegion(coordinateRegion, animated: true)
        
        // 맵에서 위치 표시해줄!! 객체 생성하고, 앞에서 작성한 위치값 location 할당!!
        // 인앱의 지도 내 기본적으로 사용되는 여러 아이콘?을 통해 위치를 표시 할 수 있음
        let point = MKPointAnnotation()
        point.coordinate = location
        self.map.addAnnotation(point)
    }
}
