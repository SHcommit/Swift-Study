//
//  MemoReadVC.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

class MemoReadVC: UIViewController {
    //MARK: - variable
    var data : MemoDataViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        initialNavigationBarTitle()
    }
}


//MARK: - Setup subviews
extension MemoReadVC {
    
    func setupSubview() {
        let subject = UILabel()
        let contents = UILabel()
        let image = UIImageView()
        
        initialSubject(label: subject)
        initialContents(label: contents)
        initialImage(imageView: image)
        
        setupSubjectConstriants(label: subject)
        setupContentsConstraints(label: contents, target: subject)
        setupImageContraints(image: image, target: contents)
    }
    
    func initialNavigationBarTitle(){
        let formatter        = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString       = formatter.string(from: (data?.regdate)!)
        navigationItem.title = dateString
    }
    
    func initialSubject(label: UILabel) {
        view.addSubview(label)
        guard let text = data?.title else {
            return
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    func initialContents(label: UILabel) {
        guard let text = data?.contents else {
            return
        }
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
    }
    
    func initialImage(imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = data?.image
    }
    
}

//MARK: - setupSubviewConstraints
extension MemoReadVC {
    
    func setupSubjectConstriants(label: UILabel) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)])
    }
    
    func setupContentsConstraints(label: UILabel, target subview: UILabel) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: subview.bottomAnchor, constant: 32),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16)])
    }
    
    func setupImageContraints(image: UIImageView, target subview: UILabel) {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: subview.bottomAnchor, constant: 100),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)])
    }
}
