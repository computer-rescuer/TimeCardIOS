//
//  File.swift
//  TimeCard
//
//  Created by CRK on 2020/10/22.
//

import Foundation

class Utility {
    // 現在時刻を"yyyy/MM/dd HH:mm:ss"のString型で返すクラスメソッド
    class func nowTimeGet() -> String {
        // 現在時刻を取得
        let now = NSDate()
        let formatter = DateFormatter()
        // 好きなフォーマットを設定する
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy年MM月dd日(EEE)"
        let str = formatter.string(from: now as Date)
        return str
    }
    class func nowTimeGet2() -> String {
        // 現在時刻を取得
        let now = NSDate()
        let formatter = DateFormatter()
        // 好きなフォーマットを設定する
        formatter.dateFormat = " HH : mm "
        let str = formatter.string(from: now as Date)
        return str
    }
    class func nowTimeGet3() -> String {
        // 現在時刻を取得
        let now = NSDate()
        let formatter = DateFormatter()
        // 好きなフォーマットを設定する
        formatter.dateFormat = "yyyyMMdd"
        let str = formatter.string(from: now as Date)
        return str
    }
    class func nowTimeGet4() -> String {
        // 現在時刻を取得
        let now = NSDate()
        let formatter = DateFormatter()
        // 好きなフォーマットを設定する
        formatter.dateFormat = "HHmm"
        let str = formatter.string(from: now as Date)
        return str
    }
    class func nowTimeGet5() -> String {
        // 現在時刻を取得
        let now = NSDate()
        let formatter = DateFormatter()
        // 好きなフォーマットを設定する
        formatter.dateFormat = "yyyy-MM-dd"
        let str = formatter.string(from: now as Date)
        return str
    }
}

