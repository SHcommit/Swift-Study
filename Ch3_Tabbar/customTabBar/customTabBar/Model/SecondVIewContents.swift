//
//  SecondVIewContents.swift
//  customTabBar
//
//  Created by 양승현 on 2022/06/25.
//

import UIKit

class SecondViewContents
{
    var title : UILabel
    init(view : inout UIView)
    {
        title = UILabel()
        addTitleObject(title: &title, view: &view)
    }
}
//MARK: - setContents
extension SecondViewContents
{
    func addTitleObject(title : inout UILabel, view : inout UIView)
    {
        title = UILabel(frame:CGRect(x: 0, y: 100, width: 100, height: 30))
        title.text = "두번째 탭 화면"
        title.textColor = .blue
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit()
        title.center.x = view.frame.width / 2
        
        view.addSubview(title)
    }
}
