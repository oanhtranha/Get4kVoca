//
//  UIView+Extensions.swift
//  Get4kVoca
//
//  Created by Oanh tran on 11/20/18.
//  Copyright © 2018 activecog. All rights reserved.
//

import UIKit



// MARK: - Identifiable (ReusableView)

public typealias Identifier = String

public protocol Identifiable: class  {
    static var voca_identifier: Identifier { get }
}

public extension Identifiable {
    static var voca_identifier: Identifier {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable {}
extension UITableViewHeaderFooterView: Identifiable {}
extension UICollectionReusableView: Identifiable {}
extension UIViewController: Identifiable {}
