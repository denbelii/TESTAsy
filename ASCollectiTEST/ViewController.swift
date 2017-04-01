////
////  ViewController.swift
////  ASCollectiTEST
////
////  Created by Nataliia Klemenchenko on 31.03.17.
////  Copyright © 2017 Andrew Klemenchenko. All rights reserved.
////
//
//import UIKit
//import AsyncDisplayKit
//
//class ViewController: ASViewController<ASDisplayNode>, ASCollectionDataSource{
//    
//    
//    var pageNumber: Int32 = 1
//    var _groups: [Lady]?
//    var _collectionNode = ASCollectionNode()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        _collectionNode.backgroundColor = .red
//        
//    }
//    init() {
//        super.init(node: ASDisplayNodeType())
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
////    init() {
////        _collectionNode = ASCollectionNode()
////        super.init(node: _collectionNode)
////        setupInitialState()
////        }
////    
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//
//    func setupInitialState() {
//        title = "Browse Meetup"
//        _collectionNode.delegate = self
//        _collectionNode.dataSource = self
//    }
//    
//
//
//    
//
//}
//
//extension ViewController: ASCollectionDelegate{
//    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
//        return _groups?.count ?? 0
//    }
//    
//    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
//        return ASCellNode()
//    }
//}
