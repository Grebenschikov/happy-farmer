//
//  TableViewCell.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

class TableViewCell: UIView {
    private var contentView: UIView!
    
    weak var tableView: TableView?
    var index: Int = 0
    
    var backgroundImage: UIImageView!
    var removeButton: UIButton!
    var moveButton: UIButton!
    
    var editable = false {
        didSet {
            contentView.frame.origin.x += (editable ? 1 : -1) * 30
            removeButton.alpha = editable ? 1 : 0
            moveButton.alpha = editable ? 1 : 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        
        backgroundImage = UIImageView(frame: frame)
        super.addSubview(backgroundImage)
        
        contentView = UIView(frame: frame)
        contentView.backgroundColor = UIColor.clearColor()
        super.addSubview(contentView)
        
        removeButton = UIButton(frame: CGRect(x: 36, y: (frame.height - 22) / 2, width: 22, height: 22))
        removeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        removeButton.setImage(UIImage(named: "RemoveBtn")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        removeButton.tintColor = UIColor.whiteColor()
        removeButton.alpha = 0
        removeButton.addTarget(self, action: #selector(remove), forControlEvents: .TouchUpInside)
        super.addSubview(removeButton)
        
        moveButton = UIButton(frame: CGRect(x: frame.width - 52, y: (frame.height - 22) / 2, width: 22, height: 22))
        moveButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        moveButton.setImage(UIImage(named: "MoveBtn")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        moveButton.tintColor = UIColor.whiteColor()
        moveButton.alpha = 0
        moveButton.addTarget(self, action: #selector(startMoving), forControlEvents: .TouchDown)
        moveButton.addTarget(self, action: #selector(stopMoving), forControlEvents: [.TouchUpOutside, .TouchUpInside])
        moveButton.addTarget(self, action: #selector(moving), forControlEvents: [.TouchDragInside, .TouchDragOutside])
        super.addSubview(moveButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubview(view: UIView) {
        contentView.addSubview(view)
    }
    
    @objc private func remove() {
        removeButton.removeTarget(self, action: #selector(remove), forControlEvents: .TouchUpInside)
        tableView?.removeCell(self)
    }
    
    @objc private func startMoving() {
        tableView?.startMovingCell(self)
    }
    
    @objc private func stopMoving() {
        tableView?.stopMovingCell(self)
    }
    
    
    func moving(sender: UIButton, event: UIEvent) {
        guard let touch = event.allTouches()?.first else {
            return
        }
        
        tableView?.movingCell(self, withTouch: touch)
    }
    
}
