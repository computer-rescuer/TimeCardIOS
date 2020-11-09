//
//  Upload_crk.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//
import Foundation
//var semaphore:DispatchSemaphore!
func crk_upload() {
    // 携帯のメモリから取得し、IPを生成する
    let WK_IP: String  = UserDefaults.standard.string( forKey: "Setting1")!
    let WK_URL_NAME = "http://IP/syain/file_dir/pass_check.php"
    let WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
    let Read_str:String = readFromFile()
    //start
    print("Start")
    //created NSURL
    
    //created NSURL
    let requestURL = NSURL(string: WK_URL_NAME_R)
    
    //creating NSMutableURLRequest
    let request = NSMutableURLRequest(url: requestURL! as URL)
    print(requestURL)
    //setting the method to post
    request.httpMethod = "POST"
    //テキストフィールドからキーと値を連結してpostパラメータを生成する
    let postParameters = "word="+Read_str
    print(postParameters)
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
func readFromFile() -> String {
            /// ①DocumentsフォルダURL取得
    guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    else {fatalError("フォルダURL取得エラー")
    }
    /// ②対象のファイルURL取得
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    if let pathComponent = url.appendingPathComponent("main.txt"){
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
        } else {
            return ""
        }
    } else {
        return ""
    }

    /// ③ファイルの読み込み
    let fileURL = dirURL.appendingPathComponent("main.txt")
    guard let fileContents = try? String(contentsOf: fileURL)
    else {fatalError("ファイル読み込みエラー")
    }
    return fileContents
}
