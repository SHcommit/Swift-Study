//
//  MovieVO.swift
//  MovieChart-tabBar
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit

/**
 * 섬네일 이미지 주소
 * 제목
 * 설명
 * 상세정보
 * 평점
 * 섬네일 객체
        async 처리를 위한 객체.
        네트워크를 통해 내려받은 이미지 정보 또한
        이 객체를 저장하는 MyTableViewController.list에 추가함으로
        반복적으로 매번 이미지를 내려받아 객체로 저장하는 방식을 회피할 수 있다.
 */
class MovieVO {
    var thumbnail :String?
    var title: String?
    var description: String?
    var detail : String?
    var rating : Double?
    var thumbnailImage : UIImage?
}
