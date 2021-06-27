//
//  UITableView+Extensions.swift

import Foundation
import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: cellClass.identifier, bundle: nil), forCellReuseIdentifier: cellClass.identifier)
    }
    
    func register<Cell: UITableViewCell>(cellClass: Cell.Type){
        self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell{
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.identifier) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
    
    func scrollToBottom(with animated: Bool = true){
        DispatchQueue.main.async {
            let lastSectionIndex = self.numberOfSections - 1
            let indexPath = IndexPath(row: self.numberOfRows(inSection:  lastSectionIndex) - 1, section: lastSectionIndex)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
}

