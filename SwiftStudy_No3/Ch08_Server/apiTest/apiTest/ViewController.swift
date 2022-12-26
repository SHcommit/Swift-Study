//
//  ViewController.swift
//  apiTest
//
//  Created by 양승현 on 2022/08/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let urlPath = "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime"
    
    @IBOutlet weak var currentTime: UILabel!
    @IBAction func callCurrentTime(_ sender: Any)
    {
        do
        {
            guard let url = URL(string: urlPath) else {return}
            let response = try String(contentsOf: url)
            self.currentTime.text = response
            self.currentTime.sizeToFit()
        }
        catch let err as NSError
        {
            NSLog(err.localizedDescription)
        }
    }

    @IBAction func json(_ sender: Any)
    {
        guard let userID = self.userId?.text, let name = self.name.text else {return}
        let param     = ["userID": userID, "name":name]
        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])
        guard let url       = URL(string:"http://swiftapi.rubypaper.co.kr:2029/practice/echoJSON") else {return}
        
        var request   = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody   = paramData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData.count), forHTTPHeaderField: "Content-Langth")
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (_,_,_) in
        
        }
        task.resume()
    }
    
    @IBOutlet weak var responseView: UITextView!
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func post(_ sender: Any)
    {
        //post value
        guard let _Id = self.userId.text, let _name = self.name.text else {return}
        let param = "userID=\(_Id)&name=\(_name)"
        //Swift에서는 Data로 변환하면 URLEncoding 적용이 자연스래 된다.
        let paramData = param.data(using: .utf8)
        
        ///API 호출과정
        guard let url = URL(string:"http://swiftapi.rubypaper.co.kr:2029/practice/echo") else {return}
        
        //url 객체에 요청 내용 담는다.
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //요청 값
        request.httpBody   = paramData
        //Content-Type
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Length")
        let task = URLSession.shared.dataTask(with: request)
        {
            (data,urlResponse,e) in
            
            //에러는 없으면 nil타입, 그럼 let e 인스턴스 안됨
            if let e = e
            {
                NSLog("\(e.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async()
            {
                do
                {
                    let obj = try JSONSerialization.jsonObject(with : data!, options: []) as? NSDictionary
                    guard let jsonObj = obj else { return }
                    
                    let res       = jsonObj["result"] as? String
                    let timestamp = jsonObj["timestamp"] as? String
                    let userId    = jsonObj["userID"] as? String
                    let name      = jsonObj["name"] as? String
                    
                    if res == "SUCCESS"
                    {
                        self.responseView.text = """
                        아이디 : \(userId!)
                        응답결과 : \(res!)
                        응답시간 : \(timestamp!)
                        요청방식 : x-www-form-urlencoded
                        """
                    }
                }
                catch let e as NSError
                {
                    NSLog("An error has occured while parsing JSObject : \(e.localizedDescription)")
                }
            }
        }
        
        //요 resume으로 URLSessing의 dataTask에 담긴 request 보낼 수 있다.
        task.resume()
        
    }
}

