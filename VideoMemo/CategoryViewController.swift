//
//  CategoryViewController.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/29.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var categories: [Category] = []
    var selectedCategory: Category? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")

        categories = readCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 5
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        cell.layer.masksToBounds = false
        
        let category: Category = categories[indexPath.row]
        selectedCategory = category
        let count = readItems().count
        //realmに保存してるdata型をUIcolorに変換する
//        cell.setCell(title: category.title, count: count, color: <#UIColor#>)
        cell.setCell(title: category.title, count: count)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        self.performSegue(withIdentifier: "toMemoListView", sender: nil)
    }
    
    func readCategories() -> [Category] {
        return Array(realm.objects(Category.self))
    }
    
    func readItems() -> [MemoItem] {
        return Array(realm.objects(MemoItem.self).filter("category == %@", selectedCategory!))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemoListView" {
            let memoListViewController = segue.destination as! MemoListViewController
            memoListViewController.selectedCategory = self.selectedCategory!
        }
    }

}
