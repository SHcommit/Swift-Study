//
//  ListViewController.swift
//  MovieChart-RESTAPI
//
//  Created by 양승현 on 2022/04/26.
//

import UIKit

class ListViewController : UITableViewController{
    
    lazy var list :[MovieVO] = { [MovieVO]() }()
    var page = 1
    @IBAction func buttonMore(_ sender: Any) {
        self.page += 1
        let apiData = callRESTAPI()
        dataParsing(RESTAPI: apiData)
        //테이블 뷰 다시 읽어오기
        self.tableView.reloadData()
    }
    
    
    
    
    override func viewDidLoad() {
        /**
         * Todo:
         *   URL 객체 생성
         *   Data(contentsOf:)로 RESTAPI호출
         *   .jsonObject(with:options:)를 통해 데이터 파싱
         *   원하는 값을 list에 저장
         *   테이블 뷰 셀에 추가 등록
         */
        let apiData = callRESTAPI()
        dataParsing(RESTAPI: apiData)
        tableView.rowHeight = 130
        
    }
    
    private func callRESTAPI() -> Data{
        /**
         * **REST API 데이터 가져오기**
         * URL 객체 생성
         * Data(contentsOf:)를 통한 REST  API 호출
         */
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        let apiURL = URL(string: url)!
        let apiData = try! Data(contentsOf: apiURL)
        
        //데이터 전송 결과 로그로 출력
        // ?? 연산자를 통해 nil값이면 "" 반환
        let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API RESULT=\(log)")
        
        return apiData
    }
    
    private func dataParsing(RESTAPI apiData : Data){
        /**
         * REST API를 통해 받아온 데이터는 딕셔너리 형식이지만,
         * Swift에서 Dictionary는 value 타입이 동일해야한다.
         * 따라서, NSDictioinary를 사용한다.
         * ------------------------------------------
         * jsonObject(with:options:) 메서드를 통해 데이터를 파싱한다.
         * JSONSerialization 객체 안에 있다.
         * jsonObject( )는 데이터 파싱 과정에서 오류 발생 시 catch를 던진다. 따라서 do ~ try catch로 감싸준다.
         * p633
         * ------------------------------------------
         * hoppin == JSON객체 ( 최상위) - dictionary형식
         *      totalCount == 정보의 데이터 전체 개수
         *      movies == 영화 목록 정보 JSON객체  - dictionary 형식
         *          movie == 영화 정보 (안에 배열 형태로 - index 마다 딕셔너리로 되어있는데, 안에 영화 정보 있음)
         *              movieID
         *              title
         *              genreIds 등등 키값 존재.
         *
         * 호출 방법은 딕셔너리 key 호출방법과 동일
         * ------------------------------------------
         */
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
            
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            for row in movie{
                let r = row as! NSDictionary
                
                let mvo = MovieVO()
                
                mvo.title       = r["title"] as! String
                mvo.description = r["genreNames"] as! String
                mvo.thumbnail   = r["thumbnailImage"] as? String
                mvo.detail      = r["linkUrl"] as? String
                mvo.rating      = ((r["ratingAverage"] as! NSString).doubleValue)
                let totalCount = (hoppin["totalCount"]as? NSStrong)!.integerValue
                if self.list.count >= totalCount{
                    self.buttonMore.isHidden = true
                }
                self.list.append(mvo)
            }
        } catch{ NSLog("parse error") }
    }
}
extension ListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text  = row.title
        cell.decs?.text   = row.description
        cell.rating?.text = "\(row.rating!)"
        
        let url = URL(string: row.thumbnail!)
        let imageData = try! Data(contentsOf: url!)
        cell.thumbnail.image = UIImage(data: imageData)

        return cell
    }
}
