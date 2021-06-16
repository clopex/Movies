//
//  UITableViewExt.swift
//  Movies
//
//  Created by Adis Mulabdic on 15.06.2021..
//

import UIKit

extension UITableView
{
    func indexPathExists(indexPath:IndexPath) -> Bool {
        if indexPath.section >= self.numberOfSections {
            return false
        }
        if indexPath.row >= self.numberOfRows(inSection: indexPath.section) {
            return false
        }
        return true
    }
}
