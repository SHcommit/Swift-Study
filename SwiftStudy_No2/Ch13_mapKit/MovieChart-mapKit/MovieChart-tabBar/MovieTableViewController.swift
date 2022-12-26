//
//  MovieTableViewController.swift
//  MovieChart-tabBar
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit

/**
 * TODO :
 *       1. MovieVO 타입의 배열에 RESTAPI 에서 JSON 형식의 데이터 파싱을 통한 영화 정보 append
 *       2. tableView 프로토타입 셀 구현
 *
 * 코드 리뷰는 ch11, ch10, ch9와 중복된 코드가 많아 따로 작성하진 않았습니다.
 */
class MovieTableViewController : UITableViewController{
    lazy var list : [MovieVO] = {
        [MovieVO]()
    }()
    
    override func viewDidLoad() {
        self.tableView.rowHeight = 130
        let restApiData = _callRESTAPIData()
        _dataParsing(RESTAPIObj: restApiData)
    }
}

//MARK: - RESTAPI를 통한 JSON데이터 NSDictionary로 변환
extension MovieTableViewController{
    //list에 영화 추가
    private func _appnedMovie(MovieData movieList: NSArray){
        movieList.forEach{
            let movie = $0 as! NSDictionary
            let mVO = MovieVO()
            
            mVO.detail         = movie["linkUrl"] as! String
            mVO.thumbnail      = movie["thumbnailImage"] as! String
            mVO.rating         = (movie["ratingAverage"] as! NSString).doubleValue
            mVO.title          = movie["title"] as! String
            mVO.description    = movie["genreNames"] as! String
            // 썸넬 이미지는 나중에 Cell 초기화 할 때 비동기로 구현할거..
            self.list.append(mVO)
        }
    }
    
    //RESTAPI 호출
    private func _callRESTAPIData() -> Data{
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        let urlObj = URL(string: url)
        return try! Data(contentsOf: urlObj!)
    }
    
    //RESTAPI 파싱
    private func _dataParsing(RESTAPIObj data : Data){
        do{
            let apiNSDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            let hoppin : NSDictionary = apiNSDictionary["hoppin"] as! NSDictionary
            let movies : NSDictionary = hoppin["movies"] as! NSDictionary
            let movie : NSArray = movies["movie"] as! NSArray
            
            self._appnedMovie(MovieData: movie)
            
        }catch{ NSLog("데이터 파싱 과정에서 오류 발생됬습니다.") }
    }
    
}

//MARK: - 테이블 뷰 처리 관련
extension MovieTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let MovieInfo = list[index]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        cell.title?.text = MovieInfo.title
        cell.discrip?.text = MovieInfo.description
        cell.rating?.text = "\(MovieInfo.rating!)"
        
        //새롭고 간단하게 클로저로 추가해봄
        DispatchQueue.main.async{
            cell.thumbnail?.image = {
                if let image = MovieInfo.thumbnailImage {
                    return MovieInfo.thumbnailImage
                }else{
                    return try! UIImage(data: Data(contentsOf: URL(string: MovieInfo.thumbnail!)!))
                }
            }()
        }
        return cell
    }
}
//MARK: - segue 관련 처리
extension MovieTableViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_detail"{
            let cell = sender as! MovieTableViewCell
            
            //사용자가 클릭한 특정 cell 찾음
            let eventedCell = self.tableView.indexPath(for: cell)
            
            
            
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[eventedCell!.row]
        }
    }
}
