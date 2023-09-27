//
//  NewMemoViewController.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/21.
//

import UIKit
import RealmSwift

class NewMemoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: PlaceTextView!
    
    let realm = try! Realm()
    
    var image: UIImage!
    var captureTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        textView.placeHolder = "入力してください。"
//        print(captureTime)
    }
    
    @IBAction func save() {
        let item = MemoItem()
        item.memo = textView.text ?? ""
        item.time = captureTime
        item.imageURL = setImage(image: image) ?? ""
        createItem(item: item)
        print("pushed")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setImage(image: UIImage?) -> String? {
        // 画像がnilだったらnilを返却して処理から抜ける
        guard let image = image else { return nil }
        // ファイル名をUUIDで生成し、拡張子を".jpeg"にする
        let fileName = UUID().uuidString + ".jpeg"
        // ドキュメントディレクトリのURLを取得
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // ファイルのURLを作成
        var fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
        // UIImageをJPEGデータに変換
        let data = image.jpegData(compressionQuality: 1.0)
//        // 【追加】URLResourceValuesをインスタンス化
//        var values = URLResourceValues()
//        // 【追加】iCloudの自動バックアップから除外する
//        values.isExcludedFromBackup = true
        do {
//            // 【追加】iCloudの自動バックアップから除外する設定の登録
//            try fileURL.setResourceValues(values)
            // JPEGデータをファイルに書き込み
            try data!.write(to: fileURL)
            print(fileName)
        } catch {
            print("保存💀エラー")
            print(error)
        }
        return fileName
    }
    
    func createItem(item: MemoItem) {
        try! realm.write {
            realm.add(item)
        }
    }
    
}

final class PlaceTextView: UITextView {

    var placeHolder: String = "" {
        willSet {
            self.placeHolderLabel.text = newValue
            self.placeHolderLabel.sizeToFit()
        }
    }

    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textColor = .gray
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChanged),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)

        NSLayoutConstraint.activate([
            placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            placeHolderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 7),
            placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            placeHolderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5)
        ])

    }

    @objc private func textDidChanged() {
        let shouldHidden = self.placeHolder.isEmpty || !self.text.isEmpty
        self.placeHolderLabel.alpha = shouldHidden ? 0 : 1
    }

}

