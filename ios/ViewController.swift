//
//  ViewController.swift
//  TimeCard
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
    @IBOutlet weak var Result: UILabel!
    
    
    var arr = [String]()
    var timer: Timer!
    var WK_URL_NAME_R: String=""
    var area:String = ""
// 画面に表示された直後に呼ばれます。
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
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
                WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
                print(WK_URL_NAME_R)
                Download_crk(stUrl: WK_URL_NAME_R,
                fn: { data in
                    DispatchQueue.main.async {
                          //取得した文字列データをUITextViewに収納
                        self.LabelHN.text = data
                        self.LabelHN.sizeToFit()
                        self.ScrollHN.contentSize = CGSize(width: self.LabelHN.frame.width, height: self.LabelHN.frame.height)
                        print(data)

                    }
                })
                //HanMenuが呼び出される前にクリア
                UserDefaults.standard.set("", forKey: "HanMenu1")
                //端末内テキストから名前を取得し、表示する
                let  str:String = ReadFromFile(file_nm: "setting.txt")
                let arr:[String] = str.components(separatedBy: ",")
                let rst:String
 //              arr.append(contentsOf: arr2)
                rst = arr[3] + "\n" + arr[2]
                Result.text=rst
                UserIDLabel.text = arr[0]
                PasswordLabel.text = arr[1]
                NameLabel.text = arr[2]
                Syain_cdLabel.text = arr[3]
                area = arr[4]
                AreaLabel.text = arr[4]
                B1.setTitle(arr[4], for: UIControl.State.normal)
                B2.setTitle(arr[5], for: UIControl.State.normal)
                B3.setTitle(arr[6], for: UIControl.State.normal)
                UserDefaults.standard.set(arr[0], forKey: "Uid0")
                UserDefaults.standard.set(arr[1], forKey: "Pwd1")
                UserDefaults.standard.set(arr[2], forKey: "Name2")
                UserDefaults.standard.set(arr[3], forKey: "Scode3")
                UserDefaults.standard.set(arr[4], forKey: "Area4")
                UserDefaults.standard.set(arr[5], forKey: "Area5")
                UserDefaults.standard.set(arr[6], forKey: "Area6")
                
            }
        
            //60秒ごとに繰り返す、repeat every 1 minutes
            timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                timer.fire()
        
        areaView.isHidden = true
        
    }
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(true)
//                timer.invalidate()
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
        let wk3 = UserDefaults.standard.string( forKey: "Scode3") ?? ""
        let tw = "10" + "," + wk3 + "," + Utility.nowTimeGet3() + "," + Utility.nowTimeGet4() + "," + area + "," + Utility.nowTimeGet5()
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
        let WK_IP: String  = UserDefaults.standard.string( forKey: "Setting1")!
        let WK_URL_NAME = "http://IP/syain/file_dir/pass_list.csv"
        WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
        Download_crk(stUrl: WK_URL_NAME_R,
        fn: { data in
            DispatchQueue.main.async {
                  //取得した文字列データをUITextViewに収納
                self.LabelHN.text = data
                self.LabelHN.sizeToFit()
                self.ScrollHN.contentSize = CGSize(width: self.LabelHN.frame.width, height: self.LabelHN.frame.height)
            }
        })
    }

        
    @IBAction func Reload(_ sender: Any) {
        let WK_IP: String  = UserDefaults.standard.string( forKey: "Setting1")!
        let WK_URL_NAME = "http://IP/syain/file_dir/pass_list.csv"
        WK_URL_NAME_R = WK_URL_NAME.replacingOccurrences(of: "IP", with: WK_IP)
    Download_crk(stUrl: WK_URL_NAME_R,
        fn: { data in
            DispatchQueue.main.async {
                  //取得した文字列データをUITextViewに収納
                self.LabelHN.text = data
                self.LabelHN.sizeToFit()
                self.ScrollHN.contentSize = CGSize(width: self.LabelHN.frame.width, height: self.LabelHN.frame.height)
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
        area = UserDefaults.standard.string( forKey: "Area4") ?? ""
        areaView.isHidden = true
        AreaLabel.text=UserDefaults.standard.string( forKey: "Area4")
    }
    @IBAction func B2_Click(_ sender: Any) {
        area = UserDefaults.standard.string( forKey: "Area5") ?? ""
        areaView.isHidden = true
        AreaLabel.text=UserDefaults.standard.string( forKey: "Area5")
    }
    @IBAction func B3_Click(_ sender: Any) {
        area = UserDefaults.standard.string( forKey: "Area6") ?? ""
        areaView.isHidden = true
        AreaLabel.text=UserDefaults.standard.string( forKey: "Area6")
    }
}
