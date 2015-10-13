//
//  ServerLoader.swift
//  ServerMonitor
//
//  Created by Mark Westenberg on 12/10/15.
//  Copyright © 2015 Final Media. All rights reserved.
//

//
//  ServerLoader.swift
//  ServerMonitor
//
//  Created by Mark Westenberg on 09/10/15.
//  Copyright © 2015 Final Media. All rights reserved.
//

import Foundation
import UIKit



protocol ServerLoaderDelegate {
    
    //delegate returning list of servers
    //must be implemented.
    func jsonResponse(servers: [Server])
    
}


class ServerLoader {
    
    var servers = [Server]();
    var delegate: ServerLoaderDelegate! = nil
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    init() {
        //do nothing
    }
    
    
    func getJsonAsync(urlPath: String?) {
        if urlPath == nil {
            return
        }
        
        let url : NSURL = NSURL(string: urlPath!)!
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithURL(url, completionHandler: {
            (data, response, error) -> Void in
            
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as AnyObject?
                
                if (jsonData == nil)
                {
                    throw JSONError.ConversionFailed
                }
                
                //print(jsonData)
                //self.loadTableData()
                self.loadServerList(jsonData)
                
            } catch let error as JSONError {
                // handle error
                print(error.rawValue)
                self.loadServerSamples()
                self.delegate.jsonResponse(self.servers)
            } catch {
                print(error)
                self.loadServerSamples()
                self.delegate.jsonResponse(self.servers)
            }
        })
        task.resume()
        
    }
  
    
    
    func loadServerList(response:AnyObject?) {
        
        //clear the array
        servers.removeAll();
        
        if let counter: Int = response!.count
        {
            for var i=0;i<counter;i++
            {
                if let item = response![i] {
                    
                    
                    if let computerName = item["LocalComputerName"] as? String {
                        
                        if computerName.isEmpty {continue;}
                        let server1 = Server(name: computerName, cpu: 0, mem: 0)!
                        
                        let memory = item["PhysicalMemoryUsed"] as? String
                        let cpu = item["Processor0"] as? String
                        
                        if (cpu != nil && memory != nil)
                        {
                            server1.setCpuMem(Double(cpu!)!, mem: Double(memory!)!)
                        }
                        
                        let services = item["Services"]! as! [[String : AnyObject]]
                        for service in services {
                            let serviceName = service["name"] as? String
                            let serviceStatus = service["status"] as? String
                            if (serviceName != nil && serviceStatus != nil)
                            {
                                server1.setExtra(serviceName!, status: serviceStatus!)
                            }
                            
                        }
                        servers  += [server1];
                        
                        
                    }
                }
            }
            
        }
        
        self.delegate.jsonResponse(self.servers) //load the delegate
        
    }
    
    func loadServerSamples() {
        
        servers.removeAll(); // always clean up just in case
        
        let server1 = Server(name: "DigiAccept Productie", cpu: 10.0, mem: 65.6)!
        let server2 = Server(name: "Docminds 1", cpu: 91.0, mem: 80)!
        let server3 = Server(name: "Afvalwijzer DB", cpu: 1.23, mem: 99.0)!
        let server4 = Server(name: "Monuta index", cpu: 30.555, mem: 10.23)!
        let server5 = Server(name: "Signmail", cpu: 20, mem: 81.34)!
        
        servers  += [server1, server2, server3, server4, server5]
        
    }
    
    
}
