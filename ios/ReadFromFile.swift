//
//  ReadFromFile.swift
//  TimeCard
//
//  Created by CRK on 2020/11/11.
//

import Foundation
func ReadFromFile(file_nm: String) -> String {
            /// ①DocumentsフォルダURL取得
    guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("フォルダURL取得エラー")
        return "NG"
    }
    /// ②対象のファイルURL取得
    let fileURL = dirURL.appendingPathComponent(file_nm)
    /// ③ファイルの読み込み
    guard let fileContents = try? String(contentsOf: fileURL)
    else {
        print("ファイル読み込みエラー")
        return "NG"
    }
  //④読み込んだ内容を戻り値として返す
    return fileContents
}
