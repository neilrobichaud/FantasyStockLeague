//
//  ViewController.swift
//  FantasyStockLeague
//
//  Created by neil robichaud on 2016-11-11.
//  Copyright © 2016 neil robichaud. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, NSXMLParserDelegate {
    var you: Player?
    var symbolString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if (you?.stocks.count)!-2 >= 0{
        for i in 0...(you?.stocks.count)!-2 {
            symbolString += (you?.stocks[i])! + ","
        }
        symbolString += (you?.stocks[(you?.stocks.count)!-1])!
        }
        //print(symbolString)
        getData()
        beginParsing()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var urlComponents = NSURLComponents(string: "http://ws.nasdaqdod.com/v1/NASDAQAnalytics.asmx/GetEndOfDayData")!
    
    func getData(){
        urlComponents.queryItems = [
            NSURLQueryItem(name: "_Token", value: "BC2B181CF93B441D8C6342120EB0C971"),
            
            NSURLQueryItem(name: "Symbols", value: symbolString),
            NSURLQueryItem(name: "StartDate", value: "2/15/2015"),
            NSURLQueryItem(name: "EndDate", value: "2/22/2015"),
            NSURLQueryItem(name: "MarketCenters", value: "")
            //            NSURLQueryItem(name: "TradePrecision", value: "Hour"),
            //            NSURLQueryItem(name: "TradePeriod", value: "1")
        ]
        dUrl = urlComponents.URL!
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)){weak var weakSelf = self
        let task = NSURLSession.sharedSession().dataTaskWithURL(weakSelf!.urlComponents.URL!) {(data, response, error) in
            
            //let xmlArray = SWXMLHash.parse(data)
            
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
        }
        
    }
    var dUrl: NSURL?

    var parser = NSXMLParser()
    var posts = [Stock]()
    var elements = NSMutableDictionary()
    var element = NSString()
    var symbol = String()
    var date = String()
    var close = String()

    func beginParsing()
        
    {
       parser = NSXMLParser(contentsOfURL:(dUrl)!)!
       parser.delegate = self
       parser.parse()
        
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
   

    {
         //print(elementName)
        element = elementName
        if (elementName as NSString).isEqualToString("Symbol")
        {
            symbol = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        
        if element.isEqualToString("Symbol") {
            symbol+=(string)
            date = ""
            close = ""
        } else if element.isEqualToString("Date") || element.isEqualToString("Message") {
            date+=(string)
        }
        else if element.isEqualToString("Close"){
            close+=(string.stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()))
            //print(close)
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("Symbol") { // if ending a symbol tag, add that stock to the list
            if !symbol.isEqual(nil) {
                //elements.setObject(NSMutableDictionary(), forKey: symbol)
            }
        }
            if (elementName as NSString).isEqualToString("Close"){
                //print(close)
                if !date.isEqual(nil) && Double(close)>0 {
                    var s = Stock()
                    s.close = close
                    s.day = date
                    s.symbol = symbol
                    posts.append(s)
                    
                }
                close = ""
                date = ""
            }
        
            
        
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue()){
        self.tableView.reloadData()
        }
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print(posts.count)
        return posts.count
        
    }
    var firstval = true
    var lastval = 0.0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : StockListTableViewCell = (tableView.dequeueReusableCellWithIdentifier("Cell")! as? StockListTableViewCell)!
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! StockListTableViewCell;
        
        }
        if posts.count > 0{
        cell.company?.text = posts[indexPath.row].symbol
        
        cell.dateLabel?.text = posts[indexPath.row].day //"     "  posts[indexPath.row].close
        cell.priceLabel?.text = posts[indexPath.row].close
        if firstval{
            lastval = Double(posts[indexPath.row].close)!
            firstval = false

        }
        else{
           you!.earnings+=Double(posts[indexPath.row].close)! - lastval
            

            }}
        //print(cell.company.text, cell.dateLabel.text, cell.priceLabel.text)
        return cell as UITableViewCell
        
    }

}



