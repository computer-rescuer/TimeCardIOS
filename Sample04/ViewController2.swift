//
//  ViewController2.swift
//  Sample04
//
//  Created by CRK on 2020/10/22.
//

import UIKit

class ViewController2: UIViewController {
  
    
    
    @IBOutlet weak var B1: UIButton!
    @IBOutlet var menuView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let  str:String = readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        B1.setTitle(arr[4],for:UIControl.State.normal)
   //     L2.text=arr[5]
     //   L3.text=arr[6]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func B1_Click(_ sender: Any) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // メニューの位置を取得する
        let menuPos = self.menuView.layer.position
        // 初期位置を画面の外側にするため、メニューの幅の分だけマイナスする
        self.menuView.layer.position.x = -self.menuView.frame.width
        // 表示時のアニメーションを作成する
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = menuPos.x
        },
            completion: { bool in
        })
        
    }

    // メニューエリア以外タップ時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            if touch.view?.tag == 1 {
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        self.menuView.layer.position.x = -self.menuView.frame.width
                    },
                    completion: { bool in
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            }
        }
    }
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
        return fileContents
    }

}
