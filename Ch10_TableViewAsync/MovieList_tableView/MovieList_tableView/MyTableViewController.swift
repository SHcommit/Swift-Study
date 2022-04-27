//
//  MyTableViewController.swift
//  MovieList_tableView
//
//  Created by 양승현 on 2022/04/26.
//

import UIKit
/*
 
 * ** 주의 사항 **
 
 * TableView 및 REST Api 설명은 chapter9, chapter10 main 코드에 설명되어있습니다.
 * 복습을 위해
 * 코드 리뷰 작성 Date : 22/4/27
 */


/**
 * TODO :
 *  RESTAPI를 통해 JSON 형식의 데이터를 받아온다.
 *  데이터를 배열로하는 MovieVO 타입에 받아온 데이터를 저장한다.
 *  해당 list 의 숫자만큼 tableView(_:numberOfRowsInSection:) 을 반환 후
 *  tableView(_:cellForRowAt:) 메서드를 통해 특정 데이터를 연결된
 *  prototype Cell의 @IBOutlet 변수.text에 값을 대입 후 출력한다.
 *  이때 imageView의 경우 따로 url을 객체화 해서 Data로 변환 한 후
 *  @IBOutlet 변수.image에 값을 저장한다.
 *  -------
 *  추가로 비동기 방식을 구현하는데,
 *  비동기 방식에있어 imageView의 경우 특정 tableView(_:cellForRowAt:) 가 호출 될때마다
 *  image가 url 을 통해 값이 다운로드 될 수 있다. 이 경우 메모리 관리에 상당히 비효율적, + 이미지 다운 이 느리기에, 비동기 방식을 구현한다.
 *  따라서 DispatchQueue.main.async { 클로저 } 에 image 객체 생성 후 @IBOutlet 변수.image에 값을 넣는 방식을 클로저로 할당하면된다.
 *  근데 최초의 이미지 url 객체 생성 시에는 그냥 클래스의 변수 list에 저장하고, 그것이 아닐 경우 해당 image를 list에서 꺼내서 호출하는 방식을 사용한다.
 */
class MyTableViewController : UITableViewController {
    
    
    /**
     * MovieVO 클래스 타입의 배열 생성.
     * 추후 REST API 에서 JSON 형식의 데이터 받은 후에
     * movie  키값에 대한 딕셔너리를 MovieVO에 저장
     */
    public lazy var list : [MovieVO] = {
        return [MovieVO]()
    }()
    
    
    /**
     * custom type의 tableView Cell은 height 설정이 잘 안됨,,
     * 명시적으로 Height 설정
     * callRESTAPI() 를 통해 RESTAPI를 Data 형식으로 받아옴
     * dataParsing(apiData:)을 통해 받아온 JSON dictionary의 데이터의 키값을 호출함으로써
     * MovieVO값에 각 movie 관련 정보를 저장한다.
     */
    override func viewDidLoad() {
        self.tableView.rowHeight = 121
        let apiData = callRESTAPI()
        dataParsing(apiData: apiData)
        
    }
    
    private func getThumbnailImage(_ index: Int) -> UIImage{
        
        let mvo = self.list[index]
        
        if let savedImage = mvo.thumbnaliImage {
            return savedImage
        }else{
            mvo.thumbnaliImage = UIImage(data: try! Data(contentsOf: URL(string: mvo.thumbnail!)!))
        
            return mvo.thumbnaliImage!
        }
    }
    private func callRESTAPI() -> Data {
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        let apiURL = URL(string: url)!
        
        //아하 여기서 에러나는데 Info.plist에서 설정해줘야함
        let apiData = try! Data(contentsOf: apiURL)
        
        NSLog("RESTAPI 호출 완료")
        return apiData
    }
    
    private func dataParsing(apiData data :Data){
        
        do{
            let apiNSDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            let hoppin : NSDictionary = apiNSDictionary["hoppin"] as! NSDictionary
            let movies : NSDictionary = hoppin["movies"] as! NSDictionary
            let movie : NSArray = movies["movie"] as! NSArray
            
            appendList(apiMovieData: movie)
            NSLog("데이터 파싱 완료")
        } catch{ NSLog("데이터 파싱 안 됨..") }
        
    }
    
    private func appendList(apiMovieData movie : NSArray) {
        for row in movie{
            let r = row as! NSDictionary
            let mVO : MovieVO = MovieVO()
            mVO.thumbnail   = r["thumbnailImage"] as! String
            mVO.rating      = (r["ratingAverage"] as! NSString).doubleValue
            mVO.description = r["genreNames"] as! String
            mVO.title       = r["title"] as! String
            mVO.detail      = r["linkUrl"] as! String
            
            
            
            list.append(mVO)
        }
    }
}

extension MyTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieInfo = list[indexPath.row]
        
        // tableView.재사용큐를 통해 cell 인스턴스 받아오기 or 생성
        let customCell = tableView.dequeueReusableCell(withIdentifier: "movieTableCell") as! MovieTableViewCell
        
        customCell.title?.text      = movieInfo.title
        customCell.rating?.text     = "\(movieInfo.rating!)"
        customCell.desc?.text = movieInfo.description
        
        customCell.thumbnail.image = getThumbnailImage(indexPath.row)
        //비동기 방식 처리~~
        DispatchQueue.main.async{
            customCell.thumbnail.image = movieInfo.thumbnaliImage
        }
        
        return customCell
        
    }
}
