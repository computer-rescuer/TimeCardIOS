//
//  Upload_crk.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/17.
//
import Foundation
//var semaphore:DispatchSemaphore!
func crk_upload() {
   

 //   semaphore=DispatchSemaphore(value:0)
    let url:URL = URL(string: "https://minkara.carview.co.jp")!
    
   // semaphore.wait()
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        if let error = error{
            print(error.localizedDescription)
            
           
        }
        if let response = response as? HTTPURLResponse {
            print("response.statusCode = \(response.statusCode)")
          
        }
    }
    task.resume()
}

