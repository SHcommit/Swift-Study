//
//  MyTableViewController.swift
//  MovieChart_webView
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit

// 기본적인 영화 테이블 뷰 설명은 Ch8, ch9, ch10참고!!
// 이번에는 좀더 색다르고 간결한 코드를 구현했고,

// 이번 ch11 목적은
// 영화 클릭시 세부정보를 Second Scene를 통해 웹 브라우저를 호출하는 것이 목표!!
class MyTableViewController : UITableViewController{
    lazy var list : [MovieVO] = { [MovieVO]() }()
    
    override func viewDidLoad() {
        
        self.tableView.rowHeight = 120
        _dataParsing(restAPIData: _call_RESTAPI())
        
    }
    
    
    private func _call_RESTAPI() -> Data{
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        //http 사용할때.. ATS설정해줘야지..
        return try! Data(contentsOf: URL(string: url)!)
        NSLog("RESTAPI 호출 완료")
    }
    
    private func _dataParsing(restAPIData data :Data){
        do{
            let apiNSDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            let hoppin = apiNSDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie   = movies["movie"] as! NSArray
            NSLog("데이터 파싱 완료")
            _updateList(MovieValueObj: movie)
            NSLog("list 갱신 완료")
        } catch{ NSLog("api 파싱 과정에서 에러 발생")}
    }
    
    private func _updateList(MovieValueObj movie : NSArray){
        movie.forEach{
            let r = $0 as! NSDictionary
            let mVO = MovieVO()
            
            mVO.thumbnail   = r["thumbnailImage"] as! String
            mVO.rating      = (r["ratingAverage"] as! NSString).doubleValue
            mVO.description = r["genreNames"] as! String
            mVO.title       = r["title"] as! String
            
            //이번 Ch11에서는 영화에 대한 자세한 정보를 웹킷등으로 불러올 것!
            mVO.detail      = r["linkUrl"] as! String
            
            list.append(mVO)
        }
    }
}
//MARK: - 테이블 뷰 관련 처리
extension MyTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let temp = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! CustomTabieViewCell
        
        cell.rating?.text = "\(temp.rating!)"
        cell.title?.text  = temp.title
        cell.desc.text    = temp.description
        
        DispatchQueue.main.async {
            cell.thumbnail.image = self._memoizationImg(index: indexPath.row)
        }
        
        return cell
    }
    private func _memoizationImg(index : Int) -> UIImage{
        let temp = list[index]
        if let image = temp.thumbnaliImage{
            return image
        }else{
            return try! UIImage(data: Data(contentsOf: URL(string: temp.thumbnail!)!))!
        }
    }
}

// MARK: - 화면 전환시 값 넘겨주기 위한 세그웨이 관련
extension MyTableViewController {
    /**
     * 프로토타입 셀을 다음 Scene과  segue 로 연결했을 때
     * 몇번째의 프로토 타입 셀인지 식별하기 위해
     * self.tableView.indexPath(for: sender as! CustomTableViewCell) 을 통해 사용자가 클릭한 행을 찾아낸다.
     * 그후 segue.destination (도착지)를 두번째 Scene VC로 연결한다.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_detail"{
            let path = self.tableView.indexPath(for: sender as! CustomTabieViewCell
            )
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }
}
