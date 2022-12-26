//
//  FirstViewContents.swift
//  customTabBar
//
//  Created by 양승현 on 2022/06/25.
//

import UIKit

class FirstViewcontents
{
    var title : UILabel?
    init(view : inout UIView)
    {
        title = UILabel()
        addTitleObject(&title,view: &view)
        
    }
}

//MARK: - setContent

extension FirstViewcontents
{
    func addTitleObject(_ title : inout UILabel?, view : inout UIView)
    {
        if var tempTitle = title
        {
            tempTitle = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
            tempTitle.text = "첫번째 탭 화면"
            tempTitle.textColor = .red
            tempTitle.textAlignment = .center
            tempTitle.font = UIFont.boldSystemFont(ofSize: 14 )
            tempTitle.sizeToFit()
            tempTitle.center.x = view.frame.width / 2
            
            title = tempTitle
            view.addSubview(tempTitle)
        }else
        {
            NSLog("title 인스턴스 생성 안됬습니다.")
        }
        
    }
}
