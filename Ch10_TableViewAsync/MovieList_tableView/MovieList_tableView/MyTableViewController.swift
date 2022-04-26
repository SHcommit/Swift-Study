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
 
 */
class MyTableViewController : UITableViewController {
    
    public lazy var list : [MovieVO] = {
        return [MovieVO]()
    }()
    
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
