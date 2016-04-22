//
//  TableView.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

protocol TableViewDataSource: class {
    func tableViewGetNumberOfRows(tableView: TableView) -> Int
    func tableView(tableView: TableView, cellForRowAtIndex index: Int) -> TableViewCell
}

@objc protocol TableViewDelegate: class {
    optional func tableView(tableView: TableView, didRemovedCellAtIndex index: Int)
    optional func tableView(tableView: TableView, didMoveCellFromIndex fromIndex: Int, toIndex: Int)
}

class TableView: UIScrollView {
    private var cells = [TableViewCell]()
    weak var tableViewDataSource: TableViewDataSource?
    weak var tableViewDelegate: TableViewDelegate?
    
    var editable = false {
        didSet {
            UIView.animateWithDuration(0.2) {
                self.cells.forEach({
                    $0.editable = self.editable
                })
            }
        }
    }
    
    func reloadData() {
        cells.forEach({
            $0.removeFromSuperview()
        })
        cells.removeAll()
        
        guard let dataSource = tableViewDataSource else {
            contentSize = CGSize.zero
            return
        }
        
        var contentHeight: CGFloat = 0
        
        for i in 0..<dataSource.tableViewGetNumberOfRows(self) {
            let cell = dataSource.tableView(self, cellForRowAtIndex: i)
            cell.tableView = self
            cell.index = i
            cell.frame.origin.y = contentHeight
            contentHeight += cell.frame.height
            cells.append(cell)
            addSubview(cell)
        }
        
        contentSize = CGSize(width: frame.width, height: contentHeight)
    }

    func removeCell(cell: TableViewCell) {
        let index = cell.index
        cells.removeAtIndex(index)
        let height = cell.frame.height
        let cellsForMove = cells[index..<self.cells.count]
        contentSize.height -= height
        UIView.animateWithDuration(0.3, animations: {
            cell.alpha = 0
            cellsForMove.forEach({
                $0.index -= 1
                $0.frame.origin.y -= height
            })
        }) { _ in
            cell.removeFromSuperview()
        }
        
        tableViewDelegate?.tableView?(self, didRemovedCellAtIndex: index)
    }
    
    var movedCellIndex: Int?
    
    func startMovingCell(cell: TableViewCell) {
        scrollEnabled = false
        bringSubviewToFront(cell)
        movedCellIndex = cell.index
    }
    
    func stopMovingCell(cell: TableViewCell) {
        scrollEnabled = true
        let newY: CGFloat = cell.index == 0 ? 0 : {
            let cell = cells[cell.index - 1]
            return cell.frame.origin.y + cell.frame.height
        }()
        
        UIView.animateWithDuration(0.2, animations: {
            cell.frame.origin.y = newY
        })
        
        tableViewDelegate?.tableView?(self, didMoveCellFromIndex: movedCellIndex!, toIndex: cell.index)
        movedCellIndex = nil
    }
    
    func movingCell(cell: TableViewCell, withTouch touch: UITouch) {
        let y = touch.locationInView(self).y
        cell.center.y = y
        
        let index = cell.index
        
        let flagUp = index != 0 && y < cells[index - 1].center.y
        let flagDown = index != (cells.count - 1) && y > cells[index + 1].center.y
        
        if flagUp || flagDown {
            let multiplier = flagUp ? 1 : -1
            cells.removeAtIndex(index)
            cells.insert(cell, atIndex: index - 1 * multiplier)
            cell.index -= 1 * multiplier
            let anotherCell = cells[index]
            anotherCell.index += 1 * multiplier
            UIView.animateWithDuration(0.2, animations: {
                anotherCell.frame.origin.y += anotherCell.frame.height * CGFloat(multiplier)
            })
        }
        
        let yDiff = y - contentOffset.y
        let semiHeight = cell.frame.height / 2
        let scrollFlagUp = (yDiff - cell.frame.height) < 0 && (contentOffset.y + contentInset.top) >= 0
        let scrollFlagDown = (contentSize.height - y - semiHeight) > 0 && (yDiff - frame.height + semiHeight) > 0
        
        if scrollFlagUp || scrollFlagDown {
            UIView.animateWithDuration(0.2, animations: {
                self.contentOffset.y -= scrollFlagUp ? 5 : -5
            }) { _ in
                if self.movedCellIndex != nil {
                    self.movingCell(cell, withTouch: touch)
                }
            }
        }
    }
    
}