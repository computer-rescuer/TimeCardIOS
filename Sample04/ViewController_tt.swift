//
//  ViewController_tt.swift
//  Sample04
//
//  Created by CRK on 2020/10/23.
//
import UIKit

class ViewController_tt: UIViewController {
    
    //URL to our web service
  //  let URL_SAVE_BOY = "http://153.156.43.33/Android/pass_check.php"
    let URL_SAVE_BOY = "http://www.ymori.com/itest/test.txt"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
    //Button　action Method
    
    //@IBAction func saveBtn(_ sender: UIButton) {
        
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_BOY)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //テキストフィールドから値の取得
      //  let teamName = NameFeild.text
    //    let memberCount = NumberFeild.text
        
        //テキストフィールドからキーと値を連結してpostパラメータを生成する
        let postParameters = "word=sakamoto"
        
        //ボディをリクエストするためのパラメータを追加する
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //投稿要求を送信するタスクを作成する
        let task =  URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error is \(error)")
                return;
            }
            
            //返ってきたJsonの解析
            do {
                //NSDictionaryに変換する
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //jsonデータの解析
                if let parseJSON = myJSON {
                    
                    //stringの生成
                    var msg : String!
                    
                    //jsonからのレスポンスを取得
                    msg = parseJSON["message"] as! String?
                    
                    //返ってきたものを表示
                    print(msg)
                }
                
            }catch{
                print(error)
            }
        }
       
        task.resume()
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
