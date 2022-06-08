//
//  MemoCell.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit
/**
 * TODO :
 *   인터페이스에서 두 가지의 추가 기능이 있다.
 *   첫번째는 image 사용하지 않은 버전, 두번째는 사용한 버전.
 *   이에 따라서 image를 input 하지 않을 경우 nil 을 활용한다.
 *   Cell 인스턴스가 담긴 클래스다.
 */
class MemoCell: UITableViewCell {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents : UILabel!
    @IBOutlet weak var regdate  : UILabel!
    @IBOutlet weak var img: UIImageView!
    
}
