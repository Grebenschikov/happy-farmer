//  HarvestTableViewCell.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

class HarvestTableViewCell: TableViewCell {
    
    var idLabel: UILabel!
    var iconImage: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    static var background: UIImage?
    static func getBackground(rect: CGRect) -> UIImage {
        if let background = background {
            return background
        }
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        
        let beizerPath = UIBezierPath(roundedRect: CGRect(x: 16, y: 8, width: rect.width - 32, height: rect.height - 16), cornerRadius: 2)
        UIColor(hex: 0x172026).setFill()
        CGContextSaveGState(context);
        CGContextSetShadow(context, CGSize(width: 2, height: 2), 5);
        beizerPath.fill()
        CGContextRestoreGState(context)
        UIColor(hex: 0x393F43).setStroke()
        beizerPath.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        background = image
        return image
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage.image = HarvestTableViewCell.getBackground(frame)
        
        idLabel = UILabel(frame: CGRect(x: 30, y: 0, width: 30, height: frame.height))
        idLabel.font = UIFont.systemFontOfSize(18)
        idLabel.textColor = UIColor.whiteColor()
        idLabel.textAlignment = .Center
        addSubview(idLabel)
        
        iconImage = UIImageView(frame: CGRect(x: 60, y: (frame.height - 35) / 2, width: 35, height: 35))
        addSubview(iconImage)
        
        titleLabel = UILabel(frame: CGRect(x: 110, y: 0, width: 100, height: frame.height))
        titleLabel.font = UIFont.systemFontOfSize(24)
        titleLabel.textColor = UIColor.whiteColor()
        addSubview(titleLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 220, y: 0, width: 170, height: frame.height))
        descriptionLabel.font = UIFont.systemFontOfSize(14)
        descriptionLabel.textColor = UIColor(hex: 0x878787)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.text = "До сбора урожая осталось около 30 дней"
        addSubview(descriptionLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}