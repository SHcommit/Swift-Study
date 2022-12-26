//
//  ViewController.swift
//  myProject
//
//  Created by 양승현 on 2022/01/08.
//  divide two branch
//  
//  2022.01.08
//  첫번째 화면과 hello 버튼을 통해 두번째 화면으로 이동할 화면 전환을 시도할 것이다.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var uiTitle: UILabel!
    
    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text  = """
하하 앱 만드는데
 첫 문자 입력을 하네~^^
"""
    }
    
    
    override func viewDidLoad() {
        // 뷰 로딩 완료되었을 때 시스템에 의해 호출됨.
        // 따라서 아래의 코드 한번 작성해서 리소스 초기화, 초기화면 구성 등을 함.( 생성자 메서드 처럼)
        //처음 한번만 실행해야할 초기화 코드를 이곳에 작성.
        super.viewDidLoad()
            //부모 viewDidLoad 호출하고 자식꺼 내용도 실행됨.
        // Do any additional setup after loading the view.
    }
/*
                중간 정리(22.01.09)
    - View Controller에서 클라이언트 영역에 컨트롤들을 배치한다.
    - 위에서 배치한 컨트롤에 대한 View Controller 클래스에
        해당 레이블 ,버튼 등을 드래그 한다.
    -이에 대한 정보는 우측 Triggered Segues에
        화면과 클래스 간 멤버 변수화, 현재 연결된 정보, 화면에는 없지만
        클래스에만 존재하는 잘못 연결된 정보들을 알 수 있다.
 */

}

