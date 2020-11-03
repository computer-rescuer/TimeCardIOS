//
//  ViewController_load.swift
//  Sample04
//
//  Created by takahiro on 2020/11/03.
//

import UIKit

class ViewController_load: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let img01 = UIImageView(image: UIImage(named: "titleimage01"))
        img01.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.view.addSubview(img01)
        Timer.scheduledTimer(timeInterval: 5, target:self,selector:#selector(timerUpdate),userInfo: nil, repeats: false)
    }
    @objc private func timerUpdate(){
        let userdefaults = UserDefaults.standard
        userdefaults.register(defaults: ["loginstatus" : false])
        var loginstatus:Bool = false
        loginstatus = UserDefaults.standard.bool(forKey: "loginstatus")
        if loginstatus == false
        {
            //login画面へ
            self.performSegue(withIdentifier: "tologin", sender: nil)
            }else{
         //報告画面へ
                self.performSegue(withIdentifier: "towork", sender: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
