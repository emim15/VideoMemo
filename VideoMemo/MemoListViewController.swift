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
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func unwindSegue(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        let item: MemoItem = items[indexPath.row]
        cell.setCell(memo: item.memo, imageURL: item.imageURL, time: item.time)
        return cell
    }
    
    func readItems() -> [MemoItem] {
        return Array(realm.objects(MemoItem.self))
    }

}

