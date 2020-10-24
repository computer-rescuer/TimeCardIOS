//
//  Upload_crk.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//
import Foundation
//var semaphore:DispatchSemaphore!
func crk_upload() {
    let URL_SAVE_BOY = "http://153.156.43.33/Android/pass_check.php"
    
    //start
    print("Start")
    //created NSURL
    
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
    let postParameters = "word=sakamoto FUNC33"
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
    print("End")
}


