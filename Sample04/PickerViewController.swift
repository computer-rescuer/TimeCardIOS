//
//  PickerViewController.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/18.
//
class PickerViewController: UIViewController, UIPickerViewDelegate,
UIPickerViewDataSource{

  override func viewDidLoad(){
    super.viewDidLoad()
    picker.delegate = self
    picker.dataSource = self
  }
  let language = {
    "html"
    "css"
    "javascript"
    "java"
    "swift"
  }
  let school
  "ITCE"
  "TechAcademy"
  "CodeCampGate"
}
override func didReceiveMemoryWarning(){
  super.didReceiveMemoryWarning()
}
@IBOutlet weak var picker: UIPickerView!
//列数
func numberOfComponentsInPickerView(pickerView: UIPickerView)
Int{
  return 2
}
//行数
func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int)
Int{
  switch component{
    case 0: return language.count
    case 1: return school.count
    default: return 0
  }
}
//文字列を表示させる
func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
String!{
  switch component{
    case 0: return language[row]
    case 1: return school[row]
    default: return ""
  }
}
//列の幅を調整
func pickerView(pickerView: UIPickerView, widthForComponent component: Int)
CGFloat{
  switch component{
      case 0: return 200.0
      case 1: return 100.0
      default: return 0.0
    }
  }
}
