//
//  ShowdownViewController.swift
//  FantasyStockLeague
//
//  Created by neil robichaud on 2016-11-12.
//  Copyright © 2016 neil robichaud. All rights reserved.
//

import UIKit

class ShowdownViewController: UIViewController {
    var yourScore: Double?
    var theirScore: Double?
    var winner: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        theirScore = (rand()%2==0) ? yourScore!+1 : yourScore!-3
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var winnerMessage: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reveal(sender: UIButton) {
        aiNum.text = String(theirScore!)
        youNum.text =  String(yourScore!)

        UIView.animateWithDuration(0.3, animations: {
            weak var weakSelf = self
            weakSelf!.youNum.hidden = false
            weakSelf!.aiNum.hidden = false
        })
        if yourScore > theirScore {
            winner = "YOU WON"
        }
        else{
            winner = "THE COMPUTER WON"
        }
        winnerMessage.text = winner
        
        
        

        
    }
    @IBOutlet weak var youNum: UILabel!{
        didSet{
            
            youNum.hidden = true
        }
    }

    @IBOutlet weak var aiNum: UILabel!{
        didSet{
            aiNum.hidden = true
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
