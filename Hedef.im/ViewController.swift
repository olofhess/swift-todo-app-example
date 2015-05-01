//
//  ViewController.swift
//  Hedef.im
//
//  Created by Emre YILMAZ on 1.05.2015.
//  Copyright (c) 2015 AybarsCengaver. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , TableViewCellDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var toDoItems = [ToDoItem]()
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell",
                forIndexPath: indexPath) as! TableViewCell
            let item = toDoItems[indexPath.row]
           // cell.textLabel?.text = item.text
//            cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            cell.delegate = self
            cell.toDoItem = item
            return cell
    }
    func toDoItemDeleted(toDoItem: ToDoItem){
        let index = (toDoItems as NSArray).indexOfObject(toDoItem)
        if index == NSNotFound{ return }
        toDoItems.removeAtIndex(index)
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
    } 
    func colorForIndex(index: Int) -> UIColor{
        let itemCount = toDoItems.count - 1
        let val = (CGFloat(index)/CGFloat(itemCount)) * 0.6;
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha:1.0)
        
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
            cell.backgroundColor = colorForIndex(indexPath.row)
    }
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.rowHeight = 50.0
        
        super.viewDidLoad()
        if toDoItems.count>0 {
            return
        }
        toDoItems.append(ToDoItem(text: "Sakız al"))
        toDoItems.append(ToDoItem(text: "Cumaya git"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        toDoItems.append(ToDoItem(text: "Büşrayı ara"))
        // Do any additional setup after loading the view, typically from a nib.
    }

 
    
    
    


}

