//
//  MenuViewController.swift
//  FantasyStockLeague
//
//  Created by neil robichaud on 2016-11-12.
//  Copyright © 2016 neil robichaud. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var you  = Player()
    var ai = Player()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //checkStocks, draftSegue
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destinationViewController as? DraftTableViewController{
            vc.you = you
            vc.ai = ai
        }
        else if let inventoryController = segue.destinationViewController as? ViewController{
            inventoryController.you = you
        }
        else if let showdownController = segue.destinationViewController as? ShowdownViewController{
            showdownController.theirScore = ai.earnings
            //print(ai.earnings)
            showdownController.yourScore = you.earnings
            //print(you.earnings)
        }
    }
    
    

}
