//
//  ViewController_Setting
//  Sample04
//
//  Created by CRK on 2020/10/21.
//
    
import UIKit

class ViewController_Setting:UIViewController{
    @IBOutlet weak var UserID: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Syain_cd: UITextField!
    @IBOutlet weak var Area1: UITextField!
    @IBOutlet weak var Area2: UITextField!
    @IBOutlet weak var Area3: UITextField!
    @IBOutlet weak var Host: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        let rst:String
        if str != ""{
            
            UserID.text=arr[0]
            Password.text=arr[1]
            Name.text=arr[2]
            Syain_cd.text=arr[3]
            Area1.text=arr[4]
            Area2.text=arr[5]
            Area3.text=arr[6]
//          Host.text=arr[7]
        
            
        }
        Host.text=UserDefaults.standard.string( forKey: "Setting1")
        print(UserDefaults.standard.string( forKey: "Setting1"))
    }
    @IBAction func Save(_ sender: Any) {
        let WK_HOST = Host.text!
        print(WK_HOST)

        UserDefaults.standard.set(WK_HOST, forKey: "Setting1")
        print(Host.text!)
        print(UserDefaults.standard.string( forKey: "Setting1"))
        
        let tf1  = UserID.text!
        let tf2  = Password.text!
        let tf3  = Name.text!
        let tf4  = Syain_cd.text!
        let tf5  = Area1.text!
        let tf6  = Area2.text!
        let tf7  = Area3.text!
        //       let tf8  = Host.text!
        
        let alltf = tf1 + "," + tf2 + "," + tf3 + "," + tf4 + "," + tf5 + "," + tf6 + "," + tf7
        /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        
        /// ②対象のファイルURL取得
        let fileURL = dirURL.appendingPathComponent("setting.txt")

        /// ③ファイルの書き込み
        do {
            try alltf.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error: \(error)")
        }
        /// ④完了メッセージの表示
        //アラートのタイトル
        let dialog = UIAlertController(title: "入力内容を保存しました。", message: "", preferredStyle: .alert)
        //ボタンのタイトル
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //実際に表示させる
        self.present(dialog, animated: true, completion: nil)
    }
    
    @IBAction func Clear(_ sender: Any) {
        UserID.text=""
        Password.text=""
        Name.text=""
        Syain_cd.text=""
        Area1.text=""
        Area2.text=""
        Area3.text=""
        
        let tf1  = UserID.text!
        let tf2  = Password.text!
        let tf3  = Name.text!
        let tf4  = Syain_cd.text!
        let tf5  = Area1.text!
        let tf6  = Area2.text!
        let tf7  = Area3.text!
        
        let alltf = tf1 + "," + tf2 + "," + tf3 + "," + tf4 + "," + tf5 + "," + tf6 + "," + tf7
        /// ①DocumentsフォルダURL取得
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        
        /// ②対象のファイルURL取得
        let fileURL = dirURL.appendingPathComponent("setting.txt")

        /// ③ファイルの書き込み
        do {
            try alltf.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("Error: \(error)")
        }
        /// ④完了メッセージの表示
        //アラートのタイトル
        let dialog = UIAlertController(title: "入力内容をクリアしました。", message: "", preferredStyle: .alert)
        //ボタンのタイトル
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //実際に表示させる
        self.present(dialog, animated: true, completion: nil)
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
}
