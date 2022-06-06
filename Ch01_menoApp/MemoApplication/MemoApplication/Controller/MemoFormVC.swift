//
//  MemoFormVC.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - variable
    /**
     * @param subjecet : 제목 저장
     * @Outlet contents : 사용자 글 작성 tevtView 객체
     * @Outlet preview  : 이미지 미리보기
     */
    var subject : String!
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    // MARK: - eventHandler
    
    // 저장 버튼 클릭시 호출 메서드
    @IBAction func save(_ sender: Any) {
    }
    
    /**
     * 카메라 버튼 클릭시 호출 메서드
     * Todo :
     *  1. 이미지 피커 인스턴스 생성
     *  2. 인스턴스의 delegate를 현재 VC로 설정
     *  3. .allowsEditing 이미지 편집 허용
     *  4. 화면 전환
     */
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker,animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
