//
//  ViewController.swift
//  CCProtobufTool
//
//  Created by CC on 2019/10/30.
//  Copyright © 2019 CC (deng you hua | cworld1000@gmail.com). All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var list: NSTableView!
    
    var dataList = ["cpp",  "csharp", "java", "js", "objc", "php", "python", "ruby"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: .init("CellID"), owner: nil) as? NSTableCellView {
            if row < dataList.count {
                cell.textField?.stringValue = dataList[row]
            }

            return cell
        }

        return nil
    }

}
