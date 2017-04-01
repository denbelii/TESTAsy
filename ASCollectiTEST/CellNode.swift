//
//  GroupCellNode.swift
//  BrowseMeetup
//
//  Created by Simon Ng on 28/12/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import AsyncDisplayKit
import  Kingfisher

fileprivate let SmallFontSize: CGFloat = 12
fileprivate let FontSize: CGFloat = 16
fileprivate let OrganizerImageSize: CGFloat = 30
fileprivate let HorizontalBuffer: CGFloat = 10

final class GroupCellNode: ASCellNode, ASNetworkImageNodeDelegate{
    
    fileprivate var avatarImageView: ASNetworkImageNode!
    fileprivate var nameLabel: ASTextNode!
    fileprivate var ageLabel: ASTextNode!
    fileprivate var idLabel: ASTextNode!
    fileprivate var onlineLabel: ASTextNode!
    fileprivate var buttonCam: ASButtonNode!
    fileprivate var buttonVideo: ASButtonNode!
    //fileprivate var _photoImageView: ASNetworkImageNode!
    
    var _activityIndicatorView: UIActivityIndicatorView!
    
    init(lady: Lady) {
        super.init()
        //style.preferredSize.height = 260
        //style.preferredSize.width = 180
        view.backgroundColor = .white
        _activityIndicatorView = UIActivityIndicatorView()
        view.addSubview(_activityIndicatorView)
        let name = lady.name == nil ? "" : lady.name!
        nameLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: name, attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: FontSize)!, NSForegroundColorAttributeName: UIColor.black]))
        
        
        
        
        
        let age = lady.age == nil ? "" : String(describing: lady.age!)
        
        ageLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: age, attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: SmallFontSize)!, NSForegroundColorAttributeName: UIColor.darkGray]))
        
        let id = lady.id == nil ? "" : String(describing: lady.id!)
        idLabel = createLayerBackedTextNode(attributedString: NSAttributedString(string: "ID: " + id, attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: SmallFontSize)!, NSForegroundColorAttributeName: UIColor.darkGray]))
        
        
        var onlineString = ""
        if lady.online != nil{
            if lady.online!{
                onlineString = "online"
            }
            
        }
        
        onlineLabel  = createLayerBackedTextNode(attributedString: NSAttributedString(string: onlineString, attributes: [NSFontAttributeName: UIFont(name: "Avenir-Medium", size: FontSize)!, NSForegroundColorAttributeName: UIColor.green]))
        
        buttonCam = ASButtonNode()
        buttonCam.setTitle("Vide chat", with: UIFont(name: "Avenir-Medium", size: SmallFontSize), with: UIColor.darkGray, for: .normal)
        
        if let onlineCam = lady.onlineCam{
            print("!!!!!!!!!!!!!")
            if onlineCam {}
            else{
                buttonCam.alpha = 0.5
            }
        }else{
            buttonCam.alpha = 0
        }
        
        buttonVideo = ASButtonNode()
        buttonVideo.setTitle("Vide chat", with: UIFont(name: "Avenir-Medium", size: SmallFontSize), with: UIColor.darkGray, for: .normal)
        if let videoCount = lady.videoCount{
            if videoCount > 0{
                buttonVideo.alpha = 1
            }else{
                buttonVideo.alpha = 0
            }
        }else{
            buttonVideo.alpha = 0
        }
        
        
        
        avatarImageView = ASNetworkImageNode()
        avatarImageView.defaultImage = UIImage(named: "IconGirl")
        avatarImageView?.url = lady.avatarURL
        avatarImageView.shouldRenderProgressImages = true
        avatarImageView.shouldCacheImage = true
        avatarImageView.delegate = self
        automaticallyManagesSubnodes = true
        
        
        
    }
    
    fileprivate func createLayerBackedTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.isLayerBacked = true
        textNode.attributedText = attributedString
        
        return textNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        //
        let verticalStack = ASStackLayoutSpec.vertical()
        
        /////////Photo Avatar
        let cellWidth = constrainedSize.max.width
        avatarImageView.style.preferredSize = CGSize(width: cellWidth, height: cellWidth)
        let avatarLabelInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let avatarWithInsets = ASInsetLayoutSpec(insets: avatarLabelInsets, child: avatarImageView)
        //let photoImageViewAbsolute = ASAbsoluteLayoutSpec(children: [avatarImageView])
        //////////
        
        
        //////   Name Label
        let nameLabelSubStack = ASStackLayoutSpec.horizontal()
        nameLabelSubStack.justifyContent = .start
        //avatarImageView.style.flexShrink = 1.0
        let nameLabelInsets = UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 0)
        let nameWithInsets = ASInsetLayoutSpec(insets: nameLabelInsets, child: nameLabel)
        nameLabelSubStack.children = [nameWithInsets]
        //////////
        
        /////// Horizontal stack with Age Id Online(icon)
        
        let hsAgeIdOnlineSub = ASStackLayoutSpec.horizontal()
        hsAgeIdOnlineSub.justifyContent = .start
        hsAgeIdOnlineSub.verticalAlignment = .bottom
        //ageLabel.style.flexShrink = 1.0
        
        let hsAgeIdSub = ASStackLayoutSpec.horizontal()
        hsAgeIdSub.justifyContent = .spaceAround
        
        let ageLabelInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        let ageWithInsets = ASInsetLayoutSpec(insets: ageLabelInsets, child: ageLabel)
        
        let idLabelInsets = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 10)
        let idSpec = ASInsetLayoutSpec(insets: idLabelInsets, child: idLabel)
        
        
        hsAgeIdSub.children = [ageWithInsets, idSpec]
        
        
        hsAgeIdOnlineSub.children = [hsAgeIdSub]
        
        
        /////Horizontal stack Online
        let onlineSubStack = ASStackLayoutSpec.horizontal()
        onlineSubStack.justifyContent = .center
        
        let onlineInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        let onlneSpec = ASInsetLayoutSpec(insets: onlineInsets, child: onlineLabel)
        
        hsAgeIdOnlineSub.children = [hsAgeIdSub, onlneSpec]
        
        
        
        ////////
        let buttonSubStackHor = ASStackLayoutSpec.horizontal()
        buttonSubStackHor.justifyContent = .spaceBetween

        
        buttonCam.laysOutHorizontally = false
        buttonCam.contentSpacing = 0
        buttonCam.imageNode.image = UIImage(named: "CameraLarge")
        buttonCam.imageNode.style.preferredSize = CGSize(width: 30, height: 30)
        let buttonInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        let buttonSpec = ASInsetLayoutSpec(insets: buttonInsets, child: buttonCam)
        
        
        
        buttonVideo.laysOutHorizontally = false
        buttonVideo.contentSpacing = 0
        buttonVideo.imageNode.image = UIImage(named: "VideoLarge")
        buttonVideo.imageNode.style.preferredSize = CGSize(width: 30, height: 30)
        let buttonVideoInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        let buttonVideoSpec = ASInsetLayoutSpec(insets: buttonVideoInsets, child: buttonVideo)
        
        buttonSubStackHor.children = [buttonSpec, buttonVideoSpec]

        
        
        
        
        
        //verticalStack.alignItems = .
        verticalStack.children = [avatarWithInsets, nameLabelSubStack, hsAgeIdOnlineSub, buttonSubStackHor]
        
        
        return verticalStack
    }
    
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        
        _activityIndicatorView.stopAnimating()
    }
    
    func imageNodeDidStartFetchingData(_ imageNode: ASNetworkImageNode) {
        print("self.frame = \(self.bounds)")
        var refreshRect = _activityIndicatorView.frame
        refreshRect.origin = CGPoint(x: (view.bounds.size.width - _activityIndicatorView.frame.width) / 2.0, y: _activityIndicatorView.frame.midY)
        _activityIndicatorView.frame = refreshRect
        
        _activityIndicatorView.frame = bounds
        _activityIndicatorView.startAnimating()
    }
}
