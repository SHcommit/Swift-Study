import UIKit
/**
 * 알람에 이미지 추가해보쟝~
 * 주의할 거는 이미지는 raw의 가로 세로 비율이 있다는것
 * 이거를 contents에 추가할 때도 비율을 정해줘야 함 안그럼 이상하게 변함
 * 주의할 점은 이렇게 정한 컨텐츠를 alert에 setValue(_:forkey:)해줘야 한다는 거~
 */
class CustomImageAlertVO
{
    var imageAlert : callAlertButtonVO
    init() { imageAlert = callAlertButtonVO() }
}

//MARK: - customImageALertUI
extension CustomImageAlertVO
{
    
    func customIamgeAlertUI(_ alert : inout UIAlertController)
    {
        let rawImage = UIImage(named: "rating5")
        let imageObj = UIImageView(image: rawImage)
        imageObj.frame = CGRect(x: 0, y: 0, width: Int((rawImage?.size.width)!), height: Int((rawImage?.size.height)!))
        let contents = UIViewController()
        //contents.view.layoutMargins.top = 30
        //contents.preferredContentSize.height = CGFloat(Int((rawImage?.size.height)!) + 15)
        contents.preferredContentSize = CGSize(width: (rawImage?.size.width)!, height: (rawImage?.size.height)! + 10)
        
        contents.view.addSubview(imageObj)
        alert.setValue(contents, forKey: "contentViewController")
    }
}

