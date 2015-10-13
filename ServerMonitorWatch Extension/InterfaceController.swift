//
//  InterfaceController.swift
//  ServerMonitorWatch Extension
//
//  Created by Mark Westenberg on 12/10/15.
//  Copyright © 2015 Addcomm Direct B.V. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, ServerLoaderDelegate {
    
    
    @IBOutlet var serverTable: WKInterfaceTable!
    @IBOutlet var refreshButton: WKInterfaceButton!
    @IBOutlet var loadingLbl: WKInterfaceLabel!
    
    
    // MARK: Properties
    var servers = [Server]();
    var urlPath: String?
    let serverLoader = ServerLoader()
    
    override init() {
        super.init()
        self.tableVisible(tableVisible: false)
        self.urlPath = "https://transactie.digiaccept.nl/apiclients/public/json.php"
        self.serverLoader.delegate = self
        self.serverLoader.getJsonAsync(self.urlPath)
        
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //delegate method from serverLoader Class
    func jsonResponse(servers: [Server]) {
        self.servers = servers
        self.loadTableData()
        self.tableVisible(tableVisible: true)
    }
    
    
    //load the table data using self.servers
    func loadTableData() {
        
        serverTable.setNumberOfRows(servers.count, withRowType: "ServerRowController")
        
        var index = 0
        
        for server: Server in servers {
            let row = serverTable.rowControllerAtIndex(index) as! ServerRow
            row.ServerName.setText(server.name)
            row.cpuLbl.setText(server.cpuText)
            row.cpuLbl.setTextColor(server.cpuColor)
            row.memLbl.setText(server.memText)
            row.memLbl.setTextColor(server.memColor)
            
            
            //extra label 1
            if (server.extraLbl1.isEmpty)
            {
                row.extraLbl1.setHidden(true)
                row.extraImageView1.setHidden(true)
            }
            else
            {
                row.extraLbl1.setHidden(false)
                row.extraImageView1.setHidden(false)
                row.extraLbl1.setText(server.extraLbl1)
                row.extraImageView1.setImage(server.extraImage1)
            }
            
            //extra label 2
            if (server.extraLbl1.isEmpty)
            {
                row.extraLbl2.setHidden(true)
                row.extraImageView2.setHidden(true)
            }
            else
            {
                row.extraLbl2.setHidden(false)
                row.extraImageView2.setHidden(false)
                row.extraLbl2.setText(server.extraLbl2)
                row.extraImageView2.setImage(server.extraImage2)
            }
            
            //extra label 3
            if (server.extraLbl3.isEmpty)
            {
                row.extraLbl3.setHidden(true)
                row.extraImageView3.setHidden(true)
                
            }
            else
            {
                row.extraLbl3.setHidden(false)
                row.extraImageView1.setHidden(false)
                row.extraLbl3.setText(server.extraLbl3)
                row.extraImageView3.setImage(server.extraImage3)
            }
            //extra label 4
            if (server.extraLbl4.isEmpty)
            {
                row.extraLbl4.setHidden(true)
                row.extraImageView4.setHidden(true)
            }
            else
            {
                row.extraLbl4.setHidden(false)
                row.extraImageView4.setHidden(false)
                row.extraLbl4.setText(server.extraLbl4)
                row.extraImageView4.setImage(server.extraImage4)
            }
            
            
            
            
            
            index++
        }
        
        self.tableVisible(tableVisible: true)
        
    }
    
    
    func tableVisible(tableVisible tableVisible: Bool) {
        
        if (tableVisible)
        {
            //table is visible
            self.loadingLbl.setHidden(true) //hide the loading label
            self.serverTable.setHidden(false) //show the table itself
            self.refreshButton.setHidden(false) //show the refreshbutton
        }
        else
        {
            //table is loading
            self.serverTable.setHidden(true) //hide the table itself
            self.refreshButton.setHidden(true) //hide the refreshbutton
            self.loadingLbl.setHidden(false) //show the loading label
            
        }
        
        
    }
    
    @IBAction func refreshTable() {
        
        //reset the table view
        self.tableVisible(tableVisible: false)
        
        //clear the table
        self.serverTable.setNumberOfRows(0, withRowType: "ServerRowController")
        //set the row count again
        self.serverTable.setNumberOfRows(servers.count, withRowType: "ServerRowController");
        self.serverTable.scrollToRowAtIndex(0)
        self.serverLoader.getJsonAsync(self.urlPath)
        
        
    }
    
    
}

