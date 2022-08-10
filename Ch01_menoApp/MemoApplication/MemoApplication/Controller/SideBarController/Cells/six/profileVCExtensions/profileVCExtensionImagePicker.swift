import UIKit

/**
 TODO : 이미지 설정 기능 in ProfileVC
 
 - Param <#ParamNames#> : <#Discription#>
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. <#Notes if any#>
 
 */
extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            //이건 UserDefaults.standard에 저장하는거
            self.userInfo.profile   = img
            //이건 profileVC에 저장하는거
            self.profileImage.image = img
        }
        picker.dismiss(animated: true)
    }
    //사용자의 선택에 맞는 UIImagePicker가 실행되도록 하는 함수
    func imgPicker(_ source: UIImagePickerController.SourceType)
    {
        let picker = UIImagePickerController()
        picker.sourceType    = source
        picker.delegate      = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    //프로필 사진 소스 타입 선택
    @objc func profile(_ sender : UIButton)
    {
        guard self.userInfo.account != nil else
        {
            self.doLogin(self.tableView)
            return
        }
        
        let alertVO = customAlertVO(title: nil, message: "사진을 가졍로 곳을 선택해 주세요", style: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            alertVO.addBtn(title: "카메라", style: .default)
            {
                (_) in
                self.imgPicker(.camera)
            }
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            alertVO.addBtn(title: "저장된 앨범", style: .default)
            {
                (_) in
                self.imgPicker(.savedPhotosAlbum)
            }
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            alertVO.addBtn(title: "포토 라이브러리", style: .default)
            {
                (_) in
                self.imgPicker(.photoLibrary)
            }
        }
        alertVO.addBtn(title: "취소", style: .cancel, completion: nil)
        self.present(alertVO.alert,animated: true)
    }
    func addTapGestrueInProfileImage()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        //user와 상호반응 true처리
        self.profileImage.isUserInteractionEnabled = true
    }
}
