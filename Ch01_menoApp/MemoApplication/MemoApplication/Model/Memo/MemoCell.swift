//
//  MemoCell.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

class MemoCell: UITableViewCell {
    
    static let cellId = "memoCell"
    var memoData: MemoData?
    var subject: UILabel?
    var contents: UILabel?
    var regdate: UILabel?
    var img: UIImageView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
}

extension MemoCell {
    
    func setupSubviews(memoData: MemoData) {
        self.memoData = memoData
        initialImageView()
        initialSubject()
        initialContents()
        initialRegdate()
        setupImageViewConstraints()
        setupSubjectConstraints()
        setupContentsConstraints()
        setupRegdateConstraints()
        
    }
    
}

//MARK: - initial subviews
extension MemoCell {
    
    func initialImageView() {
        guard let image = memoData?.image else {
            print("Failure title is nil")
            return
        }
        img = UIImageView()
        guard let img = img else {
            return
        }
        img.image = image
        img.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(img)
    }
    
    func initialSubject() {
        guard let text = memoData?.title else {
            print("Failure title is nil")
            return
        }
        subject = UILabel()
        
        guard let subject = subject else {
            print("Failure binding subject instance")
            return
        }
        subject.text = text
        subject.font = UIFont.systemFont(ofSize: 20)
        subject.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subject)
    }
    
    func initialContents() {
        guard let text = memoData?.contents else {
            print("Failure contents is nil")
            return
        }
        contents = UILabel()
        guard let contents = contents else {
            print("Failure bind contents instance")
            return
        }
        contents.text = text
        contents.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contents)
    }
    
    func initialRegdate() {
        guard let date = memoData?.regdate else {
            print("Failure regdate is nil")
            return
        }
        regdate = UILabel()
        guard let regdate = regdate else {
            print("Failure bind regdate instance")
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        regdate.text = formatter.string(from: date)
        regdate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(regdate)
    }
}

//MARK: - setupSubview's constraint
extension MemoCell {
    func setupImageViewConstraints() {
        guard let img = img else {
            print("Failure bind img instacne")
            return
        }
        NSLayoutConstraint.activate([
            img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            img.widthAnchor.constraint(equalToConstant: 80),
            img.heightAnchor.constraint(equalToConstant: 104)])
    }
    
    func setupSubjectConstraints() {
        guard let subject = subject else {
            print("Failure bind subject instance")
            return
        }
        
        guard let target = img else {
            NSLayoutConstraint.activate([
                subject.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                subject.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)])
            return
        }
        NSLayoutConstraint.activate([
            subject.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            subject.leadingAnchor.constraint(equalTo: target.trailingAnchor, constant: 8)])
    }
    
    func setupContentsConstraints() {
        guard let contents = contents else {
            print("Failure bind contents instance")
            return
        }
        guard let subject = subject else {
            return
        }
        contents.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        guard let target = img else {
            NSLayoutConstraint.activate([
                contents.topAnchor.constraint(equalTo: subject.topAnchor, constant: 8),
                contents.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                contents.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
            return
        }
        NSLayoutConstraint.activate([
            contents.topAnchor.constraint(equalTo: subject.bottomAnchor, constant: 8),
            contents.leadingAnchor.constraint(equalTo: target.trailingAnchor, constant: 8),
            contents.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
        
    }
    
    func setupRegdateConstraints() {
        guard let regdate = regdate else {
            print("Failure bind regdate instance")
            return
        }
        
        guard let contents = contents else {
            print("Failure bind contents instance")
            return
        }
        regdate.setContentHuggingPriority(UILayoutPriority(998), for: .horizontal)
        NSLayoutConstraint.activate([
            regdate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            regdate.leadingAnchor.constraint(equalTo: contents.trailingAnchor,constant: 8),
            regdate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -8)])
    }
    
}
