//
//  DetailViewController.swift
//  MovieChart_webView
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit
import WebKit


class DetailViewController : UIViewController{
    
    @IBOutlet var wv: WKWebView!
    //영화 목록에서 특정 셀 클릭시
    //segue.identifier == "segue_detail" 세그( 이 화면으로 전환될 세그웨이 연결)이면
    //mvo에 어느 행에서 클릭됬는지
    // self.tableView.indexPath(for: sender as! CustomTabieViewCell)
    //를 통해 알아내서 특정 indexPath.row를 index로하는
    //list 의 MovieVO 값을 이 VC로 전송한다.
    var mvo: MovieVO!
    
    override func viewDidLoad() {
        //네비게이션 인스턴스 얻어옴
        setNavTitle()
        openWeb()
        
    }
    
    private func setNavTitle(){
        let naviBar = self.navigationItem
        naviBar.title = self.mvo.title
    }
    private func openWeb(){
        if let url = self.mvo.detail{
            if let urlObj = URL(string: url) {
        
                let req = URLRequest(url: urlObj)
                self.wv.load(req)
            }else{
                let alert = UIAlertController(title: "오류 알림", message: "잘못된 URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel){
                    (_) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                self.present(alert,animated: false)
            }
        }else{
            let alert = UIAlertController(title: "오류 안내", message: "mvo.detail 데이터 누락", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel){ _ in
                _ = self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true)
        }
    }
}
