//
//  ViewController.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var TextHN: UITextView!
    @IBOutlet weak var nowTimeLabel: UILabel!
    @IBOutlet weak var nowTimeLabel2: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var UserIDLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var Syain_cdLabel: UILabel!
    @IBOutlet weak var AreaLabel: UILabel!
    @IBOutlet weak var T2: UITextField!
    var arr = [String]()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///setting.txtが存在しない場合はスマホのメモリを見にいかない
            guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else {
                fatalError("フォルダURL取得エラー")
            }
            var     WK_file:String = "NG"
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            if let pathComponent = url.appendingPathComponent("setting.txt"){
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: filePath) {
                    WK_file = "OK"
                }
            }
            if (WK_file == "OK" ){
                // 携帯のメモリから取得し、IPを生成する
                let WK_IP: String  = UserDefaults.standard.string( forKey: "Setting1")!
                let WK_URL_NAME = "http://IP/Android/pass_list.csv"
//              let WK_URL_NAME = "http://IP/Android/pass_check.csv"
   
                let WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
        
                Download_crk(stUrl: WK_URL_NAME_R,
                fn: { data in
                    DispatchQueue.main.async {
                          //取得した文字列データをUITextViewに収納
                        self.TextHN.text = data
                    }
                })
                //HanMenuが呼び出される前にクリア
                UserDefaults.standard.set("", forKey: "HanMenu1")
                //端末内テキストから名前を取得し、表示する
                let  str:String = self.readFromFile()
                let arr2:[String] = str.components(separatedBy: ",")
                arr.append(contentsOf: arr2)
                UserIDLabel.text = arr[0]
                PasswordLabel.text = arr[1]
                
                NameLabel.text = arr[2]
                Syain_cdLabel.text = arr[3]
                print (arr[3])
                print (arr[4])
            }
        
            //3秒ごとに繰り返す、repeat every 1 minutes
            timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                timer.fire()
            }
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(true)
                timer.invalidate()
            }
            @objc func update(tm: Timer) {
            //この関数を繰り返す、repeat this function        
            // 現在時刻を取得し、表示する
            nowTimeLabel.text = Utility.nowTimeGet()
            nowTimeLabel2.text = Utility.nowTimeGet2()
        }
    
    @IBAction func Push(_ sender: Any) {
        var WK_PLACE = ""
        //HanMenuで書き換えた出勤場所を上書きする
               T2.text=UserDefaults.standard.string( forKey: "HanMenu1")
               
               if T2.text != "" {
                   let WK_T2_NUM = Int(T2.text!)!
                   WK_PLACE = arr[WK_T2_NUM]
           }else{
            WK_PLACE = arr[4]
           }
        
        //隠し出勤場所ラベル内を上書き
        AreaLabel.text = WK_PLACE
        
        //書き込み用の文字列の作成
        let tw = "10" + "," + arr[2] + "," + Utility.nowTimeGet3() + "," + Utility.nowTimeGet4() + "," + WK_PLACE + "," + Utility.nowTimeGet5()

        /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        
        /// ②対象のファイルURL取得
        let fileURL = dirURL.appendingPathComponent("main.txt")

        /// ③ファイルの書き込み
        do {
            try tw.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            /// ④失敗メッセージの表示
            //アラートのタイトル
            let dialog = UIAlertController(title: "出勤情報の登録に失敗しました。", message: "", preferredStyle: .alert)
            //ボタンのタイトル
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //実際に表示させる
            self.present(dialog, animated: true, completion: nil)
        }
        /// ④完了メッセージの表示
        //アラートのタイトル
        let dialog = UIAlertController(title: "出勤情報を登録しました。", message: "", preferredStyle: .alert)
        //ボタンのタイトル
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //実際に表示させる
        self.present(dialog, animated: true, completion: nil)
        //出勤報告をサーバーに追加書する
        crk_upload();

        //画面のリロード
        loadView()
        viewDidLoad()

    }
    
    func readFromFile() -> String {
                /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {fatalError("フォルダURL取得エラー")
        }
        /// ②対象のファイルURL取得
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("setting.txt"){
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
        let fileURL = dirURL.appendingPathComponent("setting.txt")
        guard let fileContents = try? String(contentsOf: fileURL)
        else {fatalError("ファイル読み込みエラー")
        }
        return fileContents
    }
}
