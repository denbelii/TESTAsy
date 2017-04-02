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
    var activityIndLoadLady: UIActivityIndicatorView!
    let collectionViewLoyaut = UICollectionViewFlowLayout()
    var delegate: UpdateListLady!
    
    init() {
        
        _collectionNode = ASCollectionNode(collectionViewLayout: collectionViewLoyaut)
        super.init(node: _collectionNode)
        setupInitialState()
        collectionViewLoyaut.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLoyaut.minimumLineSpacing = 5
        collectionViewLoyaut.minimumInteritemSpacing = 2
        collectionViewLoyaut.itemSize = CGSize(width: 200, height: 300)
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
        activityIndLoadLady = UIActivityIndicatorView(frame: CGRect(x: view.frame.midX, y: view.frame.maxY / 2.5, width: 30, height: 30))
        view.addSubview(activityIndLoadLady)
        activityIndLoadLady.startAnimating()
        fetchData {
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ASVC: ASCollectionDelegate{
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
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
        return true
    }
    
    
    
    ///--------------------------------------
    // MARK - Helper Methods
    ///--------------------------------------
    
    func insertNewGroupsInCollectionViewView(_ array: [Lady]?) {
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
        
        _collectionNode.insertItems(at: indexPaths)
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
                            self.activityIndLoadLady.stopAnimating()
                        })
                    }
                    
                    completeForBatchFetching()
                }
                
            }
            
        }
        
    }
    
    
}
