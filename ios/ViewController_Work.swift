import UIKit
//class ViewController_Work: UIViewController {
class ViewController_Work: UIViewController , UIPickerViewDelegate,
                           UIPickerViewDataSource {
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var wk_sv_row=0
    @IBOutlet weak var pickerView2: UIPickerView!
    var rs_sv_row=0
    @IBOutlet weak var riyu: UITextField!
    
    @IBOutlet weak var syutyou: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePicker2: UIDatePicker!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    
    @IBOutlet weak var txt_out2: UITextView!
   
    let dataList = [
        "休出","出張"
    ]
    var dataList2:[String] = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        let rst:String
        if str != ""{
            rst = "社員番号：" + arr[3] + "　氏名：" + arr[2]
            Result.text=rst
            dataList2[0] = arr[4]
            dataList2[1] = arr[5]
            dataList2[2] = arr[6]
            
        }
//        print("【ファイル内容】\(self.readFromFile())")
//        txt_out2.text=self.readFromFile()
//        txt_out2.isEditable=false
       // Delegate設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        riyu.text = ""
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.isHidden = true
        syutyou.text = ""
        
 
        // ピッカー設定
//        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
 //       datePicker.timeZone = NSTimeZone.local
//        datePicker.locale = Locale.current
        fromDate.inputView = datePicker
        toDate.inputView = datePicker2
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        _ = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        fromDate.inputView = datePicker
        toDate.inputView = datePicker2
        fromDate.inputAccessoryView = toolbar
        toDate.inputAccessoryView = toolbar
        
        // デフォルト日付
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
//        datePicker.date = formatter.date(from: "2018-5-14")!
    }
    
    @IBAction func FOCUS(_ sender: Any) {
 //       riyu.isEnabled = true
        pickerView.isHidden = false
        
    }
    
    @IBAction func LOST_F(_ sender: Any) {
//        riyu.isEnabled = false
        riyu.text = dataList[wk_sv_row]
        pickerView.isHidden = true
    }
    
    @IBAction func FOCUS_2(_ sender: Any) {
        pickerView2.isHidden = false
    }
    
    @IBAction func LOST_F_2(_ sender: Any) {
        syutyou.text = dataList2[rs_sv_row]
        pickerView2.isHidden = true
    }
    
    @IBAction func LOST_F_FROM(_ sender: Any) {
        // デフォルト日付
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        fromDate.text = formatter.string(from: datePicker.date)
    }
    
    @IBAction func LOST_F_TO(_ sender: Any) {
        // デフォルト日付
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        toDate.text = formatter.string(from: datePicker2.date)
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
    // UIPickerViewの列の数
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // UIPickerViewの行数、リストの数
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            if pickerView == pickerView2 {
                return dataList2.count
            } else {
                return dataList.count
            }
        }
        
        // UIPickerViewの最初の表示
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            if pickerView == pickerView2 {
                return dataList2[row]
            } else {
                return dataList[row]
            }
        }
        
        // UIPickerViewのRowが選択された時の挙動
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            
            if pickerView == pickerView2 {
                syutyou.text = dataList2[row]
                rs_sv_row = row
            } else {
                riyu.text = dataList[row]
                wk_sv_row = row
            }
            
        }
        
}
