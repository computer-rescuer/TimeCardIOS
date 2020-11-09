//
//  Download_crk.swift
//  Sample04
//
//  Created by Computer=Rescuer.com on 2020/10/18.
//

import Foundation
func Download_crk(stUrl:String, fn:@escaping (_ data: String)->Void)
{
    let u = URL(string: stUrl)
    var r = URLRequest(url:u!)
    r.httpMethod = "GET"
    let sess = URLSession.shared
    sess.dataTask(with: r){(data,response,error) in
        if error == nil, let data = data, let _ = response as? HTTPURLResponse {
            let data = data
            fn(String(data: data, encoding: .utf8) ?? "")
        }
        }.resume()
}
