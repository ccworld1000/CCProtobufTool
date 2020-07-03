//
//  ViewController.swift
//  CCProtobufTool
//
//  Created by CC on 2019/10/30.
//  Copyright © 2019 CC (deng you hua | cworld1000@gmail.com). All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var sourceFileTips: NSTextField!
    @IBOutlet weak var sourceFileTextField: NSTextField!
    @IBOutlet weak var outputDirTips: NSTextField!
    @IBOutlet weak var outputDirTextField: NSTextField!
    @IBOutlet weak var list: NSTableView!
    
    var sourceFileDirURL: URL?
    var selectLanguage: String?
    var dataList = ["cpp",  "csharp", "java", "js", "objc", "php", "python", "ruby"]
    
    @IBAction func chooseFileHandle(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Choose Proto File"
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = true
        openPanel.beginSheetModal(for: view.window!) { [weak self] (result) in
            if result == .OK {
                let directoryURL = openPanel.directoryURL
                self?.sourceFileDirURL = directoryURL
                
                if let path = openPanel.url?.path {
                    self?.sourceFileTextField.stringValue = path
                } else {
                    print("get path error!")
                }
            }
            
            sender.state = .off
        }
    }
    
    @IBAction func chooseDirHandle(_ sender: NSButton) {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Choose Output Dir"
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.beginSheetModal(for: view.window!) { [weak self] (result) in
            if result == .OK {
                if let path = openPanel.directoryURL?.path {
                    self?.outputDirTextField.stringValue = path
                    print(type(of: path))
                } else {
                    print("get path error!")
                }
            }
            
            sender.state = .off
        }
    }
    
    @IBAction func generateFileHandle(_ sender: Any) {
//        if sourceFileTextField.stringValue.count < 3 {
//            alert("You must select " + sourceFileTips.stringValue)
//            return
//        }
//
//        if outputDirTextField.stringValue.count < 3 {
//            alert("You must select " + outputDirTips.stringValue)
//            return
//        }
//
//        if list.selectedRow < 0 {
//            alert("Select the corresponding language!")
//            return
//        }
        
        print("list.selectedRow -> \(list.selectedRow)")
        
        let index = list.selectedRow;
        
        if let language = selectLanguage {
            print(sourceFileDirURL?.baseURL)
            
            var optionOut = dataList[0];
            
            if index < dataList.count {
                optionOut = dataList[index];
            }
        }
    }
    
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
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if let table = notification.object as? NSTableView {
            let selectedRow = table.selectedRow
            if selectedRow < dataList.count {
                selectLanguage = dataList[selectedRow]
            }
        }
    }
}


extension ViewController {
    func alert(_ info: String) {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.informativeText = info
        alert.runModal()
    }
    
    @discardableResult
    func runCommand(launchPath: String, arguments: [String]) -> Int32 {
        let task = Process.launchedProcess(launchPath: launchPath, arguments: arguments)
        task.waitUntilExit()
    
        return task.terminationStatus
    }
}
