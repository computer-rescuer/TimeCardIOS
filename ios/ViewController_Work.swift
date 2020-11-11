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
    
    // 画面に表示された直後に呼ばれます。
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        let  str:String = ReadFromFile(file_nm: "setting.txt")

        let arr:[String] = str.components(separatedBy: ",")
        let rst:String
        if str != ""{
            rst = "社員番号：" + arr[3] + "　氏名：" + arr[2]
            Result.text=rst
            dataList2[0] = arr[4]
            dataList2[1] = arr[5]
            dataList2[2] = arr[6]
            
        }
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
    // UI 部品を View へセットする場合はこちらをオーバーライドします。
    // ただし、UI 部品のセットはこのメソッドでなくても問題ありません。
    override func loadView() {
        super.loadView()
        print("loadView")
    }

    // 初期表示時に必要な処理を設定します。
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }

    // 画面に表示される直前に呼ばれます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewWillAppear")
    }
    // 画面から非表示になる直前に呼ばれます。
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    // 画面から非表示になる直後に呼ばれます。
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    // メモリーが不足にてインスタンスが破棄される直前に呼ばれます。
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
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
