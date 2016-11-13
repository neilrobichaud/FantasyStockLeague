//
//  DraftTableViewController.swift
//  FantasyStockLeague
//
//  Created by neil robichaud on 2016-11-12.
//  Copyright © 2016 neil robichaud. All rights reserved.
//

import UIKit

class DraftTableViewController: UITableViewController {
    var stocksPerPerson = 2
    var you:Player?
    var ai: Player?
    var tickerList = ["AAPL",
                      "ABC",
                      "ABI",
                      "ABK",
                      "ABT",
                      "ACAS",
                      "ACE",
                      "ACS",
                      "ADBE",
                      "ADI",
                      "ADM",
                      "ADP",
                      "ADSK",
                      "AEE",
                      "AEP",
                      "AES"
    ]
    
    func winAlert(){
        let victoryAlert = UIAlertController(title: "Congratulations", message: "Draft finished", preferredStyle:UIAlertControllerStyle.Alert)
        victoryAlert.addAction(UIAlertAction(title: "Menu", style: UIAlertActionStyle.Default){
            (alert: UIAlertAction!) in
            weak var weakself = self
            weakself?.navigationController?.popViewControllerAnimated(true)
            })

        self.presentViewController(victoryAlert, animated: false, completion: {})
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        you?.stocks.removeAll()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tickerList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DraftCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = tickerList[indexPath.row]

        // Configure the cell...

        return cell
    }
    func aiPick(){
        var x = Int(rand())%(tickerList.count-1)
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: x, inSection: 0))
        if (cell!.textLabel?.enabled == true){

        cell!.textLabel?.enabled = false
        cell!.userInteractionEnabled = false
        ai!.stocks.append(tickerList[x])
        }
        else{
            aiPick()
        }

        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell!.textLabel?.enabled == true){
            cell!.textLabel?.enabled = false
            cell!.userInteractionEnabled = false
        
            you!.stocks.append(tickerList[indexPath.row])
            aiPick()
        if (you!.stocks.count >= stocksPerPerson){
            winAlert()
        }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
