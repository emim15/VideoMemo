//
//  NewCategoryViewController.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/29.
//

import UIKit
import RealmSwift

class NewCategoryViewController: UIViewController {
    
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var pinkColorButton: UIButton!
    @IBOutlet var greenColorButton: UIButton!
    @IBOutlet var purpleColorButton: UIButton!
    @IBOutlet var lightPurpleColorButton: UIButton!
    
    @IBOutlet var buttons: [UIButton] = []
    
    var categoryColor: String = ""
    
    let realm = try! Realm()
    
//    @objc func tap(_ sender:UIButton) {
//        print("\(sender.tag)番目がタップされた")
//        if !sender.isSelected {
//            buttons.forEach({element in element.isSelected = false})
//        }
//        sender.isSelected = !sender.isSelected
//        // isSelectedがFalseのボタンを選ぶ場合はすべてのボタンを解除してから選択したボタンのisSelectedをTrueにして、
//        // Tureのボタンを選んだ場合は単に選択をisSelectedをFalseにする
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinkColorButton.setImage(UIImage(systemName: "circle.filled"), for: .normal)
        greenColorButton.setImage(UIImage(systemName: "circle.filled"), for: .normal)
        purpleColorButton.setImage(UIImage(systemName: "circle.filled"), for: .normal)
        lightPurpleColorButton.setImage(UIImage(systemName: "circle.filled"), for: .normal)
        
        pinkColorButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        greenColorButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        purpleColorButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        lightPurpleColorButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
    }
    
    @IBAction func pinkSelected() {
        if !pinkColorButton.isSelected {
            greenColorButton.isSelected = false
            purpleColorButton.isSelected = false
            lightPurpleColorButton.isSelected = false
            categoryColor = "FEB4CB"
            print(categoryColor as Any)
        }
        pinkColorButton.isSelected = !pinkColorButton.isSelected
    }
    
    @IBAction func greenSelected() {
        if !greenColorButton.isSelected {
            pinkColorButton.isSelected = false
            purpleColorButton.isSelected = false
            lightPurpleColorButton.isSelected = false
            categoryColor = "A9DEE2"
            print(categoryColor as Any)
        }
        greenColorButton.isSelected = !greenColorButton.isSelected
    }
    
    @IBAction func purpleSelected() {
        if !purpleColorButton.isSelected {
            pinkColorButton.isSelected = false
            greenColorButton.isSelected = false
            lightPurpleColorButton.isSelected = false
            categoryColor = "5C6898"
            print(categoryColor as Any)
        }
        purpleColorButton.isSelected = !purpleColorButton.isSelected
    }
    
    @IBAction func lightPurpleSelected() {
        if !lightPurpleColorButton.isSelected {
            pinkColorButton.isSelected = false
            greenColorButton.isSelected = false
            purpleColorButton.isSelected = false
            categoryColor = "D1D5FA"
            print(categoryColor as Any)
        }
        lightPurpleColorButton.isSelected = !lightPurpleColorButton.isSelected
        print(categoryColor as Any)
    }
    
    @IBAction func save() {
        let category = Category()
        category.title = categoryTextField.text ?? ""
        category.colorData = categoryColor 
        createItem(item: category)            

        self.navigationController?.popViewController(animated: true)
        print("pushed")
    }
    
    func createItem(item: Category) {
        try! realm.write {
            realm.add(item)
        }
    }
    
}
