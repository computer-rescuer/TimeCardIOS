//
//  File.swift
//  Sample04
//
//  Created by CRK on 2020/10/23.
//
import UIKit
import Foundation

class ViewController_rest:UIViewController{
    @IBOutlet weak var Result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        let rst:String
        if str != ""{
            rst = "社員番号：" + arr[3] + "　氏名：" + arr[2]
            Result.text=rst
        
            
        }
    }
    /// ファイル読み込みサンプル
    func readFromFile() -> String {
                /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        /// ②対象のファイルURL取得
        let fileURL = dirURL.appendingPathComponent("setting.txt")
 
        /// ③ファイルの読み込み
        guard let fileContents = try? String(contentsOf: fileURL)
        else {
            fatalError("ファイル読み込みエラー")
        }
      //④読み込んだ内容を戻り値として返す
        return fileContents
    }
}
