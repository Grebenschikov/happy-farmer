//
//  HarvestViewController.swift
//  Happy Farmer
//
//  Created by Alexander on 22.04.16.
//  Copyright © 2016 Alexander Grebenschikov. All rights reserved.
//

import UIKit

class HarvestViewController: UIViewController, TableViewDataSource, TableViewDelegate {

    struct CellContent {
        let title: String
        let image: String
    }
    
    var dataSource = [
        CellContent(title: "Томаты", image: "RedTomato"),
        CellContent(title: "Огурцы", image: "LimeTomato"),
        CellContent(title: "Ягоды", image: "PurpleTomato"),
        CellContent(title: "Зелень", image: "GreenTomato"),
        CellContent(title: "Томаты", image: "RedTomato"),
        CellContent(title: "Зелень", image: "GreenTomato"),
        CellContent(title: "Томаты", image: "RedTomato"),
        CellContent(title: "Ягоды", image: "PurpleTomato"),
    ]
    
    var tableView: TableView!
    
    override func loadView() {
        super.loadView()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0.1, y: 0.33)
        gradient.endPoint = CGPoint(x: 0.9, y: 0.5)
        gradient.colors = [
            UIColor(hex: 0x0A4F70).CGColor,
            UIColor(hex: 0x0A3B56).CGColor,
            UIColor(hex: 0x0A334C).CGColor,
            UIColor(hex: 0x0A2E46).CGColor,
            UIColor(hex: 0x0A2F48).CGColor,
            UIColor(hex: 0x0A354F).CGColor,
            UIColor(hex: 0x0A3A55).CGColor
        ]
        
        view.layer.insertSublayer(gradient, atIndex: 0)
        view.backgroundColor = UIColor(hex: 0x0A2E46)
        
        navigationItem.title = "Мой урожай"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(barButtonClick))
         
        tableView = TableView(frame: view.frame)
        tableView.tableViewDataSource = self
        tableView.tableViewDelegate = self
        view.addSubview(tableView)
        tableView.reloadData()
    }
    
    func barButtonClick() {
        navigationItem.rightBarButtonItem?.title = tableView.editable ? "Edit" : "Done"
        tableView.editable = !tableView.editable
    }

    func tableViewGetNumberOfRows(tableView: TableView) -> Int {
        return 100
    }
    
    func tableView(tableView: TableView, cellForRowAtIndex index: Int) -> TableViewCell {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100)
        let cell = HarvestTableViewCell(frame: frame)
        cell.idLabel.text = String(UnicodeScalar(Int("A".utf8.first!) + (index % 26)))
        let data = dataSource[index % dataSource.count]
        cell.titleLabel.text = data.title
        cell.iconImage.image = UIImage(named: data.image)
        return cell
    }
    
    func tableView(tableView: TableView, didRemovedCellAtIndex index: Int) {
        print("Cell \(index) was deleted")
    }
    
    func tableView(tableView: TableView, didMoveCellFromIndex fromIndex: Int, toIndex: Int) {
        print("Cell \(fromIndex) moved to \(toIndex)")
    }
    
}
