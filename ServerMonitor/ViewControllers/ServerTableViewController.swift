//
//  ServerTableViewController.swift
//  ServerMonitor
//
//  Created by Mark Westenberg on 03/10/15.
//  Copyright © 2015 Final Media. All rights reserved.
//

import UIKit
import Charts

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}

class ServerTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate, ServerLoaderDelegate  {

    
    // MARK: Properties
    var servers = [Server]();
    let serverLoader = ServerLoader()
    var loading: Bool = true
    let urlPath:String = "https://transactie.digiaccept.nl/apiclients/public/json.php"
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //control to refresh on pull down
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.tableFooterView = UIView() //removes lines from empty cells
        self.tableView.backgroundColor = UIColor.blackColor()
        self.loadServerSamples()
        serverLoader.delegate = self
        serverLoader.getJsonSync(self.urlPath) //load the new
        
        
        
    
    }
    
    
    func jsonResponse( servers: [Server]) {
        //self.servers.removeAll() //remove the current array
        self.servers = servers
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
        
    }
    
    
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        serverLoader.getJsonAsync(self.urlPath) //load the new
    }
    
    //this is a list of examples that is loaded when there is no response from the server
    func loadServerSamples() {
        
        let server1 = Server(name: "loading", cpu: 10.0, mem: 65.6)!
        server1.cpu.hidden = true
        server1.mem.hidden = true
        self.servers  += [server1]
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return servers.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ServerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ServersTableViewCell
        
        let server = servers[indexPath.row]
        
        //  if(self.respondsToSelector(Selector("setCellLayoutMarginsFollowReadableWidth:")))
        
        
        if (cell.respondsToSelector(Selector("setSeparatorInset:"))) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
//        
        if (cell.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:"))) {
            cell.preservesSuperviewLayoutMargins =  false;
        }
        
        // Explictly set your cell's layout margins
        
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))) {
            cell.layoutMargins = UIEdgeInsetsZero;
        }

        
        
        cell.serverNameLbl.text = server.name
        cell.cpuLbl.text = server.cpu.text
        cell.cpuLbl.backgroundColor = server.cpu.backgroundColor
        cell.memLbl.text = server.mem.text
        cell.memLbl.backgroundColor = server.mem.backgroundColor
        cell.serverImageView.image = server.serverImage
        cell.extraLbl1.text = server.extraLbl1.text
        cell.extraOutputImageView1.image = server.extraImage1.image
        cell.extraLbl2.text = server.extraLbl2.text
        cell.extraOutputImageView2.image = server.extraImage2.image
        cell.extraLbl3.text = server.extraLbl3.text
        cell.extraOutputImageView3.image = server.extraImage3.image
        cell.extraLbl4.text = server.extraLbl4.text
        cell.extraOutputImageView4.image = server.extraImage4.image
        cell.backgroundColor = UIColor.whiteColor()
       
        return cell
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
  
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var controller: BarChartViewController
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("BarChartViewController") as! BarChartViewController
        controller.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        controller.modalPresentationStyle = .Popover
        controller.preferredContentSize = CGSizeMake(250, 200)
        let server = servers[indexPath.row]
        controller.server = server
        
        
        var rowRect: CGRect
        rowRect = tableView.rectForRowAtIndexPath(indexPath)
        
        
        let popoverMenuViewController = controller.popoverPresentationController
        popoverMenuViewController?.backgroundColor = UIColor.blackColor()
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(
            x: (rowRect.origin.x + rowRect.size.width)-200,
            y: rowRect.origin.y + (rowRect.size.height/2),
            width: 1,
            height: 1)
        presentViewController(
            controller,
            animated: true,
            completion: nil)
        
        
        //self.presentViewController(controller, animated: true, completion: nil)

        
//        navigationController?.presentViewController(barChartViewController, animated: true, completion: { () -> Void in
//        })

        
    }


}
