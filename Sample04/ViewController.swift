//
//  ViewController.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//git

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var L1: UILabel!
    
    @IBOutlet weak var L2: UILabel!
    @IBOutlet weak var T1: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        crk_upload();
       // let crk_lable_ins = crk_label();
        L2.text="2"
        L1.text = "Befor2"
        Download_crk(stUrl: "https://minkara.carview.co.jp",
            fn: { data in
                DispatchQueue.main.async {
                    //取得した文字列データをUITextViewに収納
                    self.T1.text = data
                }
        })

        
    }
    @IBAction func Push(_ sender: Any) {
        L1.text = "yyy"
        let line_text  = "201807001\n小堀 昌夫"
        /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        
        /// ②対象のファイルURL取得
        let fileURL = dirURL.appendingPathComponent("output1.txt")

        /// ③ファイルの書き込み
        do {
            try line_text.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error: \(error)")
        }
    }

    

}
    



