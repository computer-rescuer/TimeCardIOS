//
//  ViewController.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var T1: UITextView!
    @IBOutlet weak var nowTimeLabel: UILabel!
    @IBOutlet weak var nowTimeLabel2: UILabel!
    @IBOutlet weak var T2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 現在時刻を取得し、表示する
        nowTimeLabel.text = Utility.nowTimeGet()
        nowTimeLabel2.text = Utility.nowTimeGet2()
        Download_crk(stUrl: "http://153.156.43.33/Android/pass_list.csv",
            fn: { data in
                DispatchQueue.main.async {
//                    取得した文字列データをUITextViewに収納
                    self.T1.text = data
                }
        })
    }
    @IBAction func Push(_ sender: Any) {
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        let tw = "10" + "," + arr[2] + "," + Utility.nowTimeGet3() + "," + Utility.nowTimeGet4() + "," + arr[4] + "," + Utility.nowTimeGet5()
 //HanMenuで書き換えた出勤場所を上書きする
        T1.text=UserDefaults.standard.string( forKey: "HanMenu1")
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
            print("Error: \(error)")
        }
        //出勤報告をサーバーに追加書する
        crk_upload();
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
