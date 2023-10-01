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
    
    var categoryColor: UIColor!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        selected(to: pinkColorButton, for: .selected)
//        selected(to: greenColorButton, for: .selected)
//        selected(to: purpleColorButton, for: .selected)
//        selected(to: lightPurpleColorButton, for: .selected)
    }
    
    @IBAction func pinkSelected() {
        if !pinkColorButton.isSelected {
            buttons.forEach({element in element.isSelected = false})
            categoryColor = UIColor(hex: "FEB4CB")
        }
        pinkColorButton.isSelected = !pinkColorButton.isSelected
    }
    
    @IBAction func greenSelected() {
        if !greenColorButton.isSelected {
            buttons.forEach({element in element.isSelected = false})
            categoryColor = UIColor(hex: "A9DEE2")
        }
        greenColorButton.isSelected = !greenColorButton.isSelected
    }
    
    @IBAction func purpleSelected() {
        if !purpleColorButton.isSelected {
            buttons.forEach({element in element.isSelected = false})
            categoryColor = UIColor(hex: "5C6898")
        }
        purpleColorButton.isSelected = !purpleColorButton.isSelected
    }
    
    @IBAction func lightPurpleSelected() {
        if !lightPurpleColorButton.isSelected {
            buttons.forEach({element in element.isSelected = false})
            categoryColor = UIColor(hex: "D1D5FA")
        }
        lightPurpleColorButton.isSelected = !lightPurpleColorButton.isSelected
        print(categoryColor as Any)
    }
    
    @IBAction func save() {
        let category = Category()
        category.title = categoryTextField.text ?? ""
        setColor(color: categoryColor)
        
        createItem(item: category)
        self.navigationController?.popViewController(animated: true)
        print("pushed")
    }
    
//    private func selected(to button: UIButton, for: UIControl.State) {
//        var button: UIButton!
//        button.layer.borderColor = CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1)
//        button.layer.borderWidth = 1.0
//    }

    func setColor(color: UIColor?) {
     var colorData: NSData?
     if let color = color {
      colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
     }
        let category = Category()
        category.colorData = colorData! as Data
     }
    
    func createItem(item: Category) {
        try! realm.write {
            realm.add(item)
        }
    }
    
}
