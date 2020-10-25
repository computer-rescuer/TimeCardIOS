//
//  ViewController_HanMenu.swift
//  Sample04
//
//  Created by CRK on 2020/10/23.
//

import UIKit

class ViewController_HanMenu: UIViewController {
    @IBOutlet weak var Ans1: UITextField!
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var V1: UIView!
    var Ans2: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        if str != ""{
            B1.setTitle(arr[4], for: UIControl.State.normal)
            B2.setTitle(arr[5], for: UIControl.State.normal)
            B3.setTitle(arr[6], for: UIControl.State.normal)
        }
    }
    @IBAction func B1_Click(_ sender: Any) {
        Ans1.text="4"
    }
    @IBAction func B2_Click(_ sender: Any) {
        Ans1.text="5"
    }
    @IBAction func B3_Click(_ sender: Any) {
        Ans1.text="6"
    }
    func readFromFile() -> String {
        /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
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
             else {
            fatalError("ファイル読み込みエラー")
        }
        return fileContents
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // メニュー画面の位置
        let menuPosition = self.V1.layer.position
        // 初期位置設定
        self.V1.layer.position.x = -self.V1.frame.width
        // 表示アニメーション
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.V1.layer.position.x = menuPosition.x
        },
            completion: { bool in
        })

    }

    // メニュー外をタップした場合に非表示にする
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                //Start
          

                    
                UserDefaults.standard.set(Ans1.text, forKey: "keyOne")
     

   
                
            //    nextView.T2.text? = "aa"
//                print(nextView.nowTimeLabel!)
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.V1.layer.position.x = -self.V1.frame.width
                },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                }
                )
 
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   

}
