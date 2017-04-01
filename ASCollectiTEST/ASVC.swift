//
//  ASVC.swift
//  ASCollectiTEST
//
//  Created by Nataliia Klemenchenko on 31.03.17.
//  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ASVC: ASViewController<ASDisplayNode>, ASCollectionDelegateFlowLayout {
    
    var _groups: [Lady]? = [Lady]()
    var _collectionNode: ASCollectionNode
    var pageNumber: Int32 = 0
    let queuePage = DispatchQueue(label: "pageIncreement", qos: .userInitiated)
    
    init() {
        let collectionViewLoyaut = UICollectionViewFlowLayout()
        _collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLoyaut)
       // _collectionNode = ASCollectionNode(frame: CGRect(x:0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLoyaut)
        super.init(node: _collectionNode)
        setupInitialState()
        
        //collectionViewLoyaut.
        
        collectionViewLoyaut.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLoyaut.minimumLineSpacing = 5
        collectionViewLoyaut.minimumInteritemSpacing = 5
        collectionViewLoyaut.itemSize = CGSize(width: 180, height: 280)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInitialState() {
        title = "Browse Meetup"
        _collectionNode.delegate = self
        _collectionNode.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _collectionNode.view.leadingScreensForBatching = 7
        _collectionNode.backgroundColor = UIColor(colorLiteralRed: 243 / 256, green: 243 / 256, blue: 243 / 256, alpha: 1)
        fetchData {
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ASVC: ASCollectionDelegate{
    //    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
    //        print("_groups?.count = \(_groups?.count)")
    //       return 0
    //    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        //print("_groups?.count = \(_groups?.count)")
        let group = _groups![indexPath.row]
        return GroupCellNode(lady: group)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        
        return _groups?.count ?? 0
    }
}

extension ASVC: ASCollectionDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        
        
        
        
        fetchData {
            context.completeBatchFetching(true)
        }
        
        print("pageNumber = \(pageNumber)")
        
    }
    
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
//        if pageNumber > 0 {
//            return true
//        }
        return true
    }
    
    
    
    ///--------------------------------------
    // MARK - Helper Methods
    ///--------------------------------------
    
    func insertNewGroupsInCollectionViewView(_ array: [Lady]?) {
        //_groups = groups
        
        let section = 0
        var indexPaths = [IndexPath]()
        var i = 0
        
        
        
        if let array = array,
            let groups = _groups{
            
            for _ in array{
                
                let row = groups.count + i
                let path = IndexPath(row: row, section: section)
                indexPaths.append(path)
                i += 1
                
            }
        }
        //        groups?.enumerated().forEach { (row, group) in
        //            let path = IndexPath(row: row, section: section)
        //            indexPaths.append(path)
        //        }
        
        _collectionNode.insertItems(at: indexPaths)//insertRows(at: indexPaths, with: .none)
        //_activityIndicatorView.stopAnimating()
    }
    
    
    
}

extension ASVC{
    func fetchData(completeForBatchFetching: @escaping () -> ()){
        self.pageNumber += 1
        LadiesFilters().fetchOnlineList(page: pageNumber) { (arrayLady) in
            if let array = arrayLady{
                if self._groups != nil{
                    
                    DispatchQueue.main.async {
                        self._collectionNode.performBatchUpdates({
                            
                            self.insertNewGroupsInCollectionViewView(array)
                            self._groups! += array
                            
                        }, completion: { (completion) in
                            })
                    }
                    
                    completeForBatchFetching()
                }
                
            }
            
        }
        
    }
    
    
}
