//
//  MemoFormVC.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
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
    /**
     * 저장 버튼 클릭시 호출 메서드
     * TODO :
     *  1. 데이터 저장할 memoList 객체 생성.
     *  2. Appdelegate에 저장되어있는 배열에 append data
     *  3. Navigation을 이용해 이전 화면으로 되돌아간다.
     */
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil , message: "내용 입력해주세요", preferredStyle:.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title    = self.subject
        data.contents = self.contents.text
        data.image    = self.preview.image
        data.regdate  = Date()
        
        (UIApplication.shared.delegate as! AppDelegate).memoList.append(data)
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * 카메라 버튼 클릭시 호출 메서드
     * TODO :
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
    
    //이미지 선택시 호출되는 콜백 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey: Any]){
        self.preview.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false)
    }
    
    /**
     * TODO: 사용자가 입력시 이 메서드 호출됨. 이 때 네비게이션 바 제목에 즉각적으로 표시
     * @param contents : 텍스트 string
     * @param length     : 15이전엔 글자 길이 else 15  return
     */
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length   = ( (contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location:0, length:15))
        self.navigationItem.title = self.subject
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.contents.delegate = self
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
