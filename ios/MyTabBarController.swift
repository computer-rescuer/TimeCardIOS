//
//  MyTabBarController.swift
//  TimeCard
//
//  Created by CRK on 2020/11/10.
//
import Foundation
import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }

    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("First tab")
        let  str:String = ReadFromFile(file_nm: "setting.txt")
        if (str == "NG" ){
            let rootVC = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
            rootVC?.selectedIndex = 3
        }
    }

}
