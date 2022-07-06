import UIKit
import MapKit
/**
 * mapAlert관련 클래스입니다~
 * 추후 Controller에서 버튼에 addTarget이랑 이벤트 헨들러 추가 구현하면 됩니다.
 */
class CustomMapAlertVO
{
    var mapAlert : callAlertButtonVO
    init()
    {
        mapAlert = callAlertButtonVO()
    }
}

//MARK: - setAlertUI
extension CustomMapAlertVO
{
    //본격적인 커스터마이징
    func customMapAlertUI(_ alert : inout UIAlertController)
    {
        let centerVC      = UIViewController()
        let mapKitView    = MKMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        centerVC.view     = mapKitView
        //여기 대전대 국밥 맛집임 ㅋㅅㅋ 먹다가 살 너무쪄서;;
        let coord         = CLLocationCoordinate2D(latitude: 36.333885, longitude: 127.455518)
        //확대 비율
        let span          = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let flagEffect    = MKCoordinateRegion(center: coord, span: span)
        mapKitView.region = flagEffect
        mapKitView.regionThatFits(flagEffect)
        
        let point         = MKPointAnnotation()
        point.coordinate  = coord
        mapKitView.addAnnotation(point)
        centerVC.preferredContentSize.height = 180
        
        alert.setValue(centerVC, forKey: "contentViewController")
    }
}
