//
//  NewMemoViewController.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/21.
//

import UIKit

class NewMemoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage!
    var captureTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        
        print(captureTime)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {

    }
    
    
}
