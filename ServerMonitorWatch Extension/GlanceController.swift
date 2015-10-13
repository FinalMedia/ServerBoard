//
//  GlanceController.swift
//  ServerMonitorWatch Extension
//
//  Created by Mark Westenberg on 12/10/15.
//  Copyright © 2015 Addcomm Direct B.V. All rights reserved.
//

import WatchKit
import Foundation


class GlanceInterfaceController: WKInterfaceController, ServerLoaderDelegate {
    
    
    
    @IBOutlet var serverStatus: WKInterfaceImage!
    
    // MARK: Properties
    var servers = [Server]();
    var urlPath: String?
    let serverLoader = ServerLoader()
    
    
    
    override init() {
        super.init()
        
        
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.serverStatus.setImage(UIImage(named: "server-question"))
        
        // Configure interface objects here.
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.serverStatus.setImage(UIImage(named: "server-question"))
        self.urlPath = "https://transactie.digiaccept.nl/apiclients/public/json.php"
        self.serverLoader.delegate = self
        self.serverLoader.getJsonAsync(self.urlPath)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func jsonResponse(servers: [Server]) {
        
        
        
        var serverOk = true
        
        for server: Server in servers {
            
            if let glanceAlerts: [GlanceAlert] = server.glanceAlerts {
                for _: GlanceAlert in glanceAlerts {
                    serverOk = false
                    
                }
            }
        }
        
        
        if (serverOk)
        {
            self.serverStatus.setImage(UIImage(named: "server-ok"))
        }
        else
        {
            self.serverStatus.setImage(UIImage(named: "server-nok"))
            
        }
        
        
        
        
        
    }
    
}
