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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
    
        UserID.text=arr[0]
        Password.text=arr[1]
        Name.text=arr[2]
        Syain_cd.text=arr[3]
        Area1.text=arr[4]
        Area2.text=arr[5]
        Area3.text=arr[6]
 */
    }
    @IBAction func Save(_ sender: Any) {
        
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


