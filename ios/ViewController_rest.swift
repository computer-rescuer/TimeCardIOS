//
//  File.swift
//  Sample04
//
//  Created by CRK on 2020/10/23.
//
import UIKit
import Foundation

class ViewController_rest: UIViewController, UIPickerViewDelegate,
                           UIPickerViewDataSource {
    
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    var wk_sv_row = 0
    var rs_sv_row = 0
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var kyuka_cd: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var syounin: UITextField!
    
    let dataList = [
        "欠勤（事前）","欠勤（当日）","有給（事前）","有給（当日）","半休（午前）","半休（午後）","忌引","代休","夏季休","冬季休"
    ]
    
    let dataList2 = [
        "有り","無し"
    ]
    
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
        
            
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        kyuka_cd.text = ""
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.isHidden = true
        syounin.text = ""
        
        date.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        _ = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        // インプットビュー設定
        date.inputView = datePicker
        date.inputAccessoryView = toolbar
        
        // デフォルト日付
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }

    @IBAction func FOCUS(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    @IBAction func LOST_F(_ sender: Any) {
//        riyu.isEnabled = false
        kyuka_cd.text = dataList[wk_sv_row]
        pickerView.isHidden = true
    }
    
    @IBAction func LOST_F_DATE(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        date.text = formatter.string(from: datePicker.date)
    }
    
    @IBAction func FOCUS2(_ sender: Any) {
        pickerView2.isHidden = false
    }
    
    @IBAction func LOST_F_2(_ sender: Any) {
        syounin.text = dataList2[rs_sv_row]
        pickerView2.isHidden = true
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
                syounin.text = dataList2[row]
                rs_sv_row = row
            } else {
                kyuka_cd.text = dataList[row]
                wk_sv_row = row
            }
        }
    
}
