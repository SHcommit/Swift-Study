//  MovieCell.swift
//  Created by 양승현 on 2022/04/24.

import Foundation
import UIKit
/**
 * 커스텀 클래스로 UITableViewCell 셀 객체 제어하기.
 * 이때 주의할 점은 UITableViewCell이다!
 * UITableView에서 Cell안에있는 객체들을 아울렛 변수화 시키면 에러가 난다.
 */
class MovieCell: UITableViewCell{
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var decs: UILabel!
    
    @IBOutlet var opendate: UILabel!
    
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var thumbnail: UIImageView!
    
}
