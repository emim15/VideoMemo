//
//  ViewController.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/17.
//

import UIKit
import RealmSwift

class MemoListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let realm = try! Realm()
    var items: [MemoItem] = []
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    var cellOffset: CGFloat!
    var navHeight: CGFloat!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func unwindSegue(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MemoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemoCell")
        items = readItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = readItems()
        collectionView.reloadData()
        print(items)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoCell", for: indexPath) as! MemoCollectionViewCell
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.masksToBounds = false
        
        let item: MemoItem = items[indexPath.row]
        cell.setCell(memo: item.memo, image: item.getImage() ?? UIImage(), time: item.time)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellWidth = viewWidth-200
        cellHeight = 115
        cellOffset = viewWidth-cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func readItems() -> [MemoItem] {
        return Array(realm.objects(MemoItem.self))
    }

}

