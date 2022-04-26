//
//  MovieVO.swift
//  MovieChart-REST_API
//
//  Created by 양승현 on 2022/04/26.
//

import Foundation

class MovieVO {
    /**
     * 섬네일 이미지 주소
     * 제목
     * 설명
     * 상세정보
     * 개봉일
     * 평점*
     */
    var thumbnail :String?
    var title: String?
    var description: String?
    var detail : String?
    var opendate : String?
    var rating : Double?
}
