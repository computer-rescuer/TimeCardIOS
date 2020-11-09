import UIKit
//class ViewController_Work: UIViewController {
class ViewController_Work: UIViewController , UIPickerViewDelegate,
                           UIPickerViewDataSource {
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var wk_sv_row=0
    @IBOutlet weak var riyu: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var txt_out2: UITextView!
   
    let dataList = [
        "欠勤（事前）","欠勤（当日）","有給（事前）","有給（当日）","半休（午前）","半休（午後）","忌引","代休","夏季休","冬季休"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        let  str:String = self.readFromFile()
        let arr:[String] = str.components(separatedBy: ",")
        let rst:String
        if str != ""{
            rst = "社員番号：" + arr[3] + "　氏名：" + arr[2]
            Result.text=rst
        
            
        }
//        print("【ファイル内容】\(self.readFromFile())")
//        txt_out2.text=self.readFromFile()
//        txt_out2.isEditable=false
       // Delegate設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        riyu.text = ""
 
        // ピッカー設定
//        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
 //       datePicker.timeZone = NSTimeZone.local
//        datePicker.locale = Locale.current
        textField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        _ = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        textField.inputView = datePicker
        textField.inputAccessoryView = toolbar
        
        // デフォルト日付
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
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
            return dataList.count
        }
        
        // UIPickerViewの最初の表示
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            
            return dataList[row]
        }
        
        // UIPickerViewのRowが選択された時の挙動
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            
            riyu.text = dataList[row]
            wk_sv_row = row
            
        }
        
}
