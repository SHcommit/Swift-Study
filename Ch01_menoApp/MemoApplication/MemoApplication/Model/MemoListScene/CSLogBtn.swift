import UIKit
import CloudKit

/**
 - Param basic : 기본 로그
 - Param title    : 버튼 타이틀 출력
 - Param tag     : 버튼 태그 값 출력
 */
public enum CSLogType : Int
{
    case basic
    case title
    case tag
}

/**
 TODO : 사용자의 클릭시 로그 출력
 
 - Param logType : 로그 기록 타입
 
 # Notes: #
 1. <#Notes if any#>
 
 */
public class CSLogBtn : UIButton
{
    public var logType : CSLogType = .basic
    
    public required init?(coder aDecoder : NSCoder)
    {
        super.init(coder: aDecoder)
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = .white
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
        
        
    }
        
    @objc func logging(_ sender: UIButton)
    {
        switch self.logType
        {
        case .basic :
            NSLog("버튼이 클릭되었습니다.")
        case .title :
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
        case .tag :
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
            
        }
    }
}
