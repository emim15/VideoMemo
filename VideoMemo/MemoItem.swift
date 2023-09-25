//
//  MemoItem.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/17.
//

import Foundation
import UIKit
import RealmSwift

class MemoItem: Object {
    @Persisted var memo: String = ""
    @Persisted var imageURL: String? = nil
    @Persisted var time: String = ""
    
    
    /// 保存したファイル名を使って写真データを検索し、UIImageとして出力する
    /// - ドキュメントディレクトリのURLを取得
    /// - ファイルのURLを取得
    /// - ファイルからデータを読み込み、UIImageに変換して返却する
    func getImage() -> UIImage? {
         // photoFileNameがnilならnilを返却して抜ける
         guard let path = self.imageURL else { return nil }
         // ドキュメントディレクトリのURLを取得
         let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
         // ファイルのURLを取得
         let fileURL = documentsDirectoryURL.appendingPathComponent(path)
         // ファイルからデータを読み込む
             do {
                let imageData = try Data(contentsOf: fileURL)
                // データをUIImageに変換して返却する
                return UIImage(data: imageData)
                } catch {
                print("出力💀エラー")
                print(error)
                return nil
             }
         }
}
