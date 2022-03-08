//
//  NewSegue.swift
//  Scene-CustomSegue
//
//  Created by 양승현 on 2022/03/08.
//

import UIKit

class NewSegue : UIStoryboardSegue {
    
    //prepare(for : sender:) 메서드는 Segue가 실행되기 전에 실행되는 메서드이다.
    
    override func perform(){
        
        //세그웨이 출발지 뷰 컨트롤러
        let srcUVC = self.source
        
        //세그웨이 도착지 VC
        let destUVC = self.destination
        
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 2, options: .transitionCurlDown)
    }
}
