//
//  ViewController.swift
//  Delegate-ImagePicker
//
//  Created by 양승현 on 2022/04/22.
//

import UIKit

class ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    //Outlet
    
    @IBOutlet var imgView: UIImageView!
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        myPicker(picker);
        
        //콜백메서드 사용하기위한 델리게이트 설정
        picker.delegate = self
        
        self.present(picker, animated: false)
    }
    
    private func myPicker(_ picker : UIImagePickerController){
        /**
         * 이미지 sourceType == 사진 라이브러리
         * 이미지 편집 true
         */
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
    }
}

//델리게이트 상속받고, 특정 콜백 메서드 재정의하기? 구현하기!
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //이미지 피커에서 이미지 선택하지 않고 취소한 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        /**
         * 이전 화면으로 돌아가기
         * present 메서드를 통해 이미지 피커 컨트롤러로 화면 전환 했기에
         * dismiss로 할당 해제해야함
         */
        picker.presentingViewController?.dismiss(animated: false){
            self.cancelAlert()
        }
    }

    
    //이미지 피커에서 이미지 선택했을 때 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false){
            /**
             * UIImagePickerController.InfoKey.editedImage
             * 이미지 관련 키!
             * .editedImage == 편집된 이미지
             * Any  타입을 as? 연산자를 통해 UIImage로 다운캐스팅 하기
             */
            let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imgView.image = image
        }
    }
    
    private func cancelAlert(){
        // 알림창
        let alert = UIAlertController(title: "안내", message: "이미지 선택 취소 되었습니다", preferredStyle: .alert)
        alert.addAction({
            UIAlertAction(title: "확인", style: .cancel)
        }())
        self.present(alert,animated: false)
    }
}
