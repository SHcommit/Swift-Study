//
//  MovieTableViewCell.swift
//  MovieList_tableView
//
//  Created by 양승현 on 2022/04/26.
//

import UIKit

class MovieTableViewCell : UITableViewCell{
    
    @IBOutlet var thumbnail: UIImageView!
    
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var title: UILabel!
    
    //영화 상세 묘사
    @IBOutlet var desc: UILabel!
    
}

