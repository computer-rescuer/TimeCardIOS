import Foundation
func crk_upload() {
    let WK_URL_NAME = "http://IP/Android/pass_check.php"
    let WK_FILE_NAME = "main.txt"
    /// ①DocumentsフォルダURL取得
    guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    else {fatalError("フォルダURL取得エラー")
    }
    /// ②対象のファイルURL取得
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    if let pathComponent = url.appendingPathComponent(WK_FILE_NAME){
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            print("FILE AVAILABLE")
        }
        /// ③ファイルの読み込み
        let fileURL = dirURL.appendingPathComponent(WK_FILE_NAME)
        guard let fileContents = try? String(contentsOf: fileURL)
    else
        {fatalError("ファイル読み込みエラー")
    }
    let Send_msg = "word="+fileContents
//    let arr:[String] = fileContents.components(separatedBy: ",")
//start
    print("Start Host Interface")
    let WK_IP: String  = UserDefaults.standard.string( forKey: "Setting1")!
    //start
    let WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
    print(WK_URL_NAME_R)
    //created NSURL
    let requestURL = NSURL(string: WK_URL_NAME_R)
    //creating NSMutableURLRequest
    let request = NSMutableURLRequest(url: requestURL! as URL)
    //setting the method to post
    request.httpMethod = "POST"
    //テキストフィールドからキーと値を連結してpostパラメータを生成する
    let postParameters = Send_msg
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
}
