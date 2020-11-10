//
//  ViewController.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var TextHN: UITextView!
    @IBOutlet weak var nowTimeLabel: UILabel!
    @IBOutlet weak var nowTimeLabel2: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var UserIDLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var Syain_cdLabel: UILabel!
    @IBOutlet weak var AreaLabel: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var T2: UITextField!
    @IBOutlet weak var ScrollHN: UIScrollView!
    @IBOutlet weak var LabelHN: UILabel!
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    
    
    var arr = [String]()
    var timer: Timer!
    var WK_URL_NAME_R: String=""
    var area:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンの連続押下の禁止
        UIButton.appearance().isExclusiveTouch = true
        
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
                let WK_URL_NAME = "http://IP/syain/file_dir/pass_list.csv"
//              let WK_URL_NAME = "http://IP/syain/file_dir/pass_check.csv"
   
                WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
        
                Download_crk(stUrl: WK_URL_NAME_R,
                fn: { data in
                    DispatchQueue.main.async {
                          //取得した文字列データをUITextViewに収納
                        self.LabelHN.text = data
        
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
                AreaLabel.text = arr[4]
                B1.setTitle(arr[4], for: UIControl.State.normal)
                B2.setTitle(arr[5], for: UIControl.State.normal)
                B3.setTitle(arr[6], for: UIControl.State.normal)
                print (arr[3])
                print (arr[4])
            }
        
            //60秒ごとに繰り返す、repeat every 1 minutes
            timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                timer.fire()
        
        areaView.isHidden = true
        
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
        //HanMenuを使う際の実装
//        var WK_PLACE = ""
//        //HanMenuで書き換えた出勤場所を上書きする
//               T2.text=UserDefaults.standard.string( forKey: "HanMenu1")
//
//               if T2.text != "" {
//                    let WK_T2_NUM = Int(T2.text!)!
//                    WK_PLACE = arr[WK_T2_NUM]
//
//                AreaLabel.text = arr[WK_T2_NUM]
//           }else{
//            WK_PLACE = arr[4]
//
//           }
//        let tw = "10" + "," + arr[3] + "," + Utility.nowTimeGet3() + "," + Utility.nowTimeGet4() + "," + WK_PLACE + "," + Utility.nowTimeGet5()
        
        //書き込み用の文字列の作成
        let tw = "10" + "," + arr[3] + "," + Utility.nowTimeGet3() + "," + Utility.nowTimeGet4() + "," + area + "," + Utility.nowTimeGet5()

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

        //出勤状況エリアに格納
        Download_crk(stUrl: WK_URL_NAME_R,
        fn: { data in
            DispatchQueue.main.async {
                  //取得した文字列データをUITextViewに収納
                self.LabelHN.text = data
            }
        })
    }

        
    @IBAction func Reload(_ sender: Any) {
    Download_crk(stUrl: WK_URL_NAME_R,
        fn: { data in
            DispatchQueue.main.async {
                  //取得した文字列データをUITextViewに収納
                self.LabelHN.text = data
            }
        })
        //HanMenuを使う際の実装
//        var WK_PLACE = ""
//        //HanMenuで書き換えた出勤場所を上書きする
//        T2.text=UserDefaults.standard.string( forKey: "HanMenu1")
//
//        if T2.text != "" {
//        let WK_T2_NUM = Int(T2.text!)!
//        WK_PLACE = arr[WK_T2_NUM]
//
//        AreaLabel.text = arr[WK_T2_NUM]
//        }else{
//        WK_PLACE = arr[4]
//        }
    }
    
    @IBAction func FOCUS(_ sender: Any) {
        areaView.isHidden = false
    }
    
    @IBAction func B1_Click(_ sender: Any) {
        AreaLabel.text = arr[4]
        area = arr[4]
        areaView.isHidden = true
    }
    
    @IBAction func B2_Click(_ sender: Any) {
        AreaLabel.text = arr[5]
        area = arr[5]
        areaView.isHidden = true
    }
    
    @IBAction func B3_Click(_ sender: Any) {
        AreaLabel.text = arr[6]
        area = arr[6]
        areaView.isHidden = true
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
