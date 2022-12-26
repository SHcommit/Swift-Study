//
//  ThirdViewContents.swift
//  customTabBar
//
//  Created by 양승현 on 2022/06/25.
//

import UIKit

class ThirdViewContents
{
    var title : UILabel
    init(view : inout UIView)
    {
        title =
        {
            let tempTitle           = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
            tempTitle.text          = "세번째 탭 화면"
            tempTitle.textColor     = .cyan
            tempTitle.textAlignment = .center
            tempTitle.font          = UIFont.boldSystemFont(ofSize: 14)
            tempTitle.sizeToFit()
            tempTitle.center.x      = view.frame.width / 2
            
            return tempTitle
        }()
        view.addSubview(title)
    }
}
