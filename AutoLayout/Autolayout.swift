//
//  Autolayout.swift
//  AutoLayout
//
//  Created by Admin on 9/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

enum PossitionType: Int {
    case inside
    case aboveCenterOfTopEdge
    case underCenterOfTopEdge
    case inTopLeftCorner
    case aboveTopLeftCorner
    case inTopRightCorner
    case aboveTopRightCorner
    case onTopLeftSide
    case besideTopLeftCorner
    case besideTopRightCorner
    case onTheLeftOfMidOfLeftEdge
    case outsideAndFrontOfMidOfLeftEdge
    
    
    
    
    case inCenter
    case inLeftSide
    case inRightSide
    
    case aboveBottomEdge
    case inBottomLeftCorner
    case inBottomRightCorner
    
    case onTop
    case onTopLeftCorner
    case onTopRightCorner
    
    case byLeftEdge
    case byRightEdge
    case underBottomEdge
    
    
    func getAttributes() -> [[NSLayoutAttribute]] {
        switch self {
        case .inside:
            return [[.leading, .leading],
                    [.top, .top],
                    [.trailing, .trailing],
                    [.bottom, .bottom]]
        case .underTopEdge:
            return [[.centerX, .centerX],
                    [.top, .top],
                    [.width, .notAnAttribute],
                    [.height, .notAnAttribute]]
        case .inTopLeftCorner:
            return [[.leading, .leading],
                    [.top, .top],
                    [.width, .notAnAttribute],
                    [.height, .notAnAttribute]]
        case .inTopRightCorner:
             return [[.trailing, .trailing],
                     [.top, .top], [.width, .notAnAttribute], [.height, .notAnAttribute]]
        default:
            return [[.left, .left], [.top, .top], [.right, .right], [.bottom, .bottom]]
        }
    }
    
    func getFactories() -> [CGFloat] {
        switch self{
        case .inside:
            return self.getAttributes().map({ (itemArray) -> CGFloat in
                getFactory(from: (itemArray[0], itemArray[1]))
            })
        default:
            return [1,1,1,1]
        }
    }
    
    private func getFactory(from: (NSLayoutAttribute, NSLayoutAttribute)) -> CGFloat {
        switch from {
        case (.trailing, .trailing), (.bottom, .bottom):
            return -1
        default:
            return 1
        }
    }
    
    
}

// MARK: - UIView Autolayout

extension UIView {
    func autolayoutWithSuperview(edge: UIEdgeInsets)  {
        guard let superView = self.superview else {
            return
        }
        let edgeArray = edge.convertToArray()
        self.translatesAutoresizingMaskIntoConstraints = false
        let layoutAttributes = PossitionType.inside.getAttributes()
        for (index,item) in layoutAttributes.enumerated() {
            let constraint = NSLayoutConstraint(item: self,
                                                attribute: item[0],
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: superView,
                                                attribute: item [1],
                                                multiplier: 1,
                                                constant: PossitionType.inside.getFactories()[index] * edgeArray[index] )
            NSLayoutConstraint.activate([constraint])
            
        }
    }
    
    func autolayout(at position: PossitionType, of view: UIView, offsetIs offset: UIOffset,sizeIs size: CGSize) {
        // Nếu có superView thì mới so sánh với thằng view
        if let superview = self.superview {
            
        } else {
            // TODO: need add self to view
           
            self.addIfNeed(to: view, position: position)
           
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let distanceArray = [offset.horizontal, offset.vertical, size.width, size.height]
        self.translatesAutoresizingMaskIntoConstraints = false
        let listOfLayoutAttributes = position.getAttributes()
        for (index,layoutAttributes) in listOfLayoutAttributes.enumerated() {
            
            let toView: UIView? = (layoutAttributes[1] == NSLayoutAttribute.notAnAttribute) ? nil:superview
            
            let constraint = NSLayoutConstraint(item: self,
                                                attribute: layoutAttributes[0],
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: toView,
                                                attribute: layoutAttributes [1],
                                                multiplier: 1,
                                                constant: position.getFactories()[index] * distanceArray[index] )
            NSLayoutConstraint.activate([constraint])
        }
    }
    
    func addIfNeed(to superview:UIView, position: PossitionType) {
        switch position {
        case .inside, .underTopEdge, .inTopLeftCorner, .inTopRightCorner, .inCenter
        case inLeft
        case inRight             superview.addSubview(self)
        default:
            <#code#>
        }
    }
}

extension UIEdgeInsets {
    func convertToArray() -> [CGFloat] {
        return [self.left, self.top, self.right, self.bottom]
    }
}
