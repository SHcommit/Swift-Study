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
 *
 * Date : 22.07.12 왜 nil이 담길까?
 * 그 이유는 type이 ! 로 되어있기 때문이다 후훗..
 * 이게 컨텐츠가 불러와지면 그 해당 컨텐츠를 사용하는데 아닐경우 nil처리가 된다. 후훗...
 */
class MemoCell: UITableViewCell {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents : UILabel!
    @IBOutlet weak var regdate  : UILabel!
    @IBOutlet weak var img: UIImageView!
    
}
