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
    var selectedCategory: Category!
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    var cellOffset: CGFloat!
    var navHeight: CGFloat!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func unwindSegue(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {}
    
//UICollectionViewDiffableDataSource ----------------------------------------------------------------------
//    private enum Section {
//        case main
//    }
//    private var dataSource: UICollectionViewDiffableDataSource<Section, MemoItem>! = nil
//    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, MemoItem>!
//    
//    private lazy var listLayout: UICollectionViewLayout = {
//        var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        listConfig.trailingSwipeActionsConfigurationProvider = { indexPath -> UISwipeActionsConfiguration? in
//            guard let character = self.dataSource.itemIdentifier(for: indexPath) else {
//                return nil
//            }
//            return UISwipeActionsConfiguration(
//                actions: [
//                    UIContextualAction(
//                        style: .destructive,
//                        title: "Delete",
//                        handler: { [weak self] (_, _, completion) in
//                            self?.deleteCharacter(character)
//                            completion(true)
//                        })
//                ]
//            )
//        }
//        return UICollectionViewCompositionalLayout.list(using: listConfig)
//    }()
//---------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWidth = view.frame.width
        viewHeight = view.frame.height
        navHeight = self.navigationController?.navigationBar.frame.size.height
        
        collectionView.delegate = self
        collectionView.dataSource = self
//        setupDataSource()
        collectionView.register(UINib(nibName: "MemoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemoCell")
        items = readItems()
        navigationItem.title = selectedCategory.title
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
    
//---------------------------------------------------------------------------
//    private func setupDataSource() {
//        dataSource = .init(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, character) -> UICollectionViewCell? in
//            guard let self = self else { return nil }
//            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoCell", for: indexPath) as! MemoCollectionViewCell
//            
//            cell.backgroundColor = UIColor.white
//            cell.layer.cornerRadius = 12
//            cell.layer.shadowOpacity = 0.2
//            cell.layer.shadowRadius = 5
//            cell.layer.shadowColor = UIColor.black.cgColor
//            cell.layer.shadowOffset = CGSize(width: 4, height: 4)
//            cell.layer.masksToBounds = false
//            
//            let item: MemoItem = items[indexPath.row]
//            cell.setCell(memo: item.memo, image: item.getImage() ?? UIImage(), time: item.time)
//        
//            return cell
//        })
//        collectionView.dataSource = dataSource
//    }
//---------------------------------------------------------------------------

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellWidth = viewWidth-200
        cellHeight = 115
        cellOffset = viewWidth-cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func readItems() -> [MemoItem] {
        return Array(realm.objects(MemoItem.self).filter("category == %@", selectedCategory!))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVideoView" {
            let videoViewController = segue.destination as! VideoViewController
            videoViewController.category = self.selectedCategory
        }
    }
    
//---------------------------------------------------------------------------
//    private func deleteCharacter(_ character: MemoItem) {
//        guard let indexPath = dataSource.indexPath(for: character) else {
//            return
//        }
//        realm.delete(self.items[indexPath.row])
//        
//        var snapshot = dataSource.snapshot()
//        snapshot.deleteItems([character])
//        dataSource.apply(snapshot, animatingDifferences: true)
//        
//        items = readItems()
//        collectionView.reloadData()
//    }
//---------------------------------------------------------------------------
}

