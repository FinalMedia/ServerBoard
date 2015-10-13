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
    
    
    init(urlPath:String?) {
        
        if urlPath == nil {
            return
        }
        
        self.getJsonSync(urlPath!)
    }
    
    
    func getJsonSync(urlPath:String) {

        let json = JSON()
        let jsonData =  json.doRequest(urlPath) as AnyObject?
        
        if jsonData == nil
        {
            self.loadServerList(jsonData)
        }
        else
        {
            self.loadServerList(jsonData)
        }
    }
    
    func getJsonAsync(urlPath: String) {
        
        let url : NSURL = NSURL(string: urlPath)!
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
    
    //this is a list of examples that is loaded when there is no response from the server
    func loadServerSamples() {
        
        let server1 = Server(name: "Sample 1", cpu: 10.0, mem: 65.6)!
        server1.setServerImage("webserver")
        let server2 = Server(name: "Sample 2", cpu: 91.0, mem: 80)!
        server2.setServerImage("server")
        let server3 = Server(name: "Sample 3", cpu: 1.23, mem: 99.0)!
        server3.setServerImage("database")
        let server4 = Server(name: "Sample 4", cpu: 30.555, mem: 10.23)!
        server4.setServerImage("webserver")
        let server5 = Server(name: "Sample 5", cpu: 20, mem: 81.34)!
        server5.setServerImage("webserver")
        
        self.servers  += [server1, server2, server3, server4, server5]
        
    }
    
    
    func loadServerList(response:AnyObject?) {
        
        //clear the array
        servers.removeAll();
        
        
        if (response == nil)
        {
            self.loadServerSamples()
            return
        }
        
        
        
        if let counter: Int = response!.count
        {
            for var i=0;i<counter;i++
            {
                if let item = response![i] {
                    
                    
                    if let computerName = item["LocalComputerName"] as? String {
                        
                        if computerName.isEmpty {continue;}
                        let server = Server(name: computerName, cpu: 0, mem: 0)!
                        
                        if let serverType = item["ServerType"] as? String {
                            server.setServerImage(serverType)
                        }
                        else
                        {
                            server.setServerImage("server")
                        }
                        
                        if let cpuHistory = item["ProcessorHistory"] as? String {
                            server.setProcessorHistory(cpuHistory)
                        }
                        
                        
                        let memory = item["PhysicalMemoryUsed"] as? String
                        let cpu = item["Processor0"] as? String
                        
                        if (cpu != nil && memory != nil)
                        {
                            server.setCpuMem((cpu?.toDouble())!, mem: (memory?.toDouble())!)
                        }
                        
                        let services = item["Services"]! as! [[String : AnyObject]]
                        for service in services {
                            let serviceName = service["name"] as? String
                            let serviceStatus = service["status"] as? String
                            if (serviceName != nil && serviceStatus != nil)
                            {
                                server.setExtra(serviceName!, status: serviceStatus!)
                            }
                            
                        }
                        
                        self.servers  += [server];
                        
                        
                    }
                }
            }
            
        }
        
        
        self.delegate.jsonResponse(self.servers) //load the delegate
        
    }
    
    
}