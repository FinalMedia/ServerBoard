//
//  Server.swift
//  ServerMonitor
//
//  Created by Mark Westenberg on 03/10/15.
//  Copyright © 2015 Final Media. All rights reserved.
//

import UIKit

class Server {
    
    // MARK: Properties
    
    var serverImage: UIImage?
    var name: String
    var cpu: UILabel
    var mem: UILabel
    var extraLbl1: UILabel
    var extraImage1: UIImageView
    var extraLbl2: UILabel
    var extraImage2: UIImageView
    var extraLbl3: UILabel
    var extraImage3: UIImageView
    var extraLbl4: UILabel
    var extraImage4: UIImageView
    var ProcessorHistory: String?
    
    
    init?(name: String, cpu: Double, mem: Double) {
        
        self.name = name;
        self.cpu = UILabel()
        self.mem = UILabel()
        self.extraLbl1 = UILabel()
        self.extraLbl1.hidden = true;
        self.extraLbl2 = UILabel()
        self.extraLbl2.hidden = true;
        self.extraLbl3 = UILabel()
        self.extraLbl3.hidden = true;
        self.extraLbl4 = UILabel()
        self.extraLbl4.hidden = true;
        self.extraImage1 = UIImageView()
        self.extraImage2 = UIImageView()
        self.extraImage3 = UIImageView()
        self.extraImage4 = UIImageView()
        
        
        
        
        if name.isEmpty || cpu.isNaN || mem.isNaN
        {
            return nil;
        }
        else
        {
            self.setCpuMem(cpu, mem: mem)
        }
        
    }
    
    
    func setServerName(name: String) {
        self.name = name;
    }
    
    
    func setProcessorHistory(history: String) {
        self.ProcessorHistory = history
    }
    
    func setCpuMem(cpu: Double, mem: Double) {
        
        
        let cpuVal: Int = Int(cpu)
        let memVal: Int = Int(mem)
        
        switch (cpuVal) {
            
            case _ where cpuVal > 90:
                self.cpu.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
                self.cpu.text = self.convertDoubleToString(cpu,decimals: 1) + "%"
                break
            case 80...90:
                self.cpu.backgroundColor = UIColor(red: 253, green: 236, blue: 0, alpha: 1)
                self.cpu.text = self.convertDoubleToString(cpu,decimals: 1) + "%"
                break
            
            default:
                self.cpu.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
                self.cpu.text = self.convertDoubleToString(cpu,decimals: 1) + "%"
            break;
        }
        
        
        switch (memVal) {
            
        case _ where cpuVal > 90:
            self.mem.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            self.mem.text = self.convertDoubleToString(mem,decimals: 1) + "%"
            break
        case 80...90:
            self.mem.backgroundColor = UIColor(red: 253, green: 236, blue: 0, alpha: 1)
            self.mem.text = self.convertDoubleToString(mem,decimals:1) + "%"
            break
            
        default:
            self.mem.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
            self.mem.text = self.convertDoubleToString(mem,decimals:1) + "%"
            break;
        }
        
        
    }
    
    
    
    func convertDoubleToString(doubleValue : Double, decimals: Double) -> String {
        
        let dec = pow(10, decimals);
        
        let roundedVal = Double(round(dec*doubleValue)/dec)
        return String(roundedVal)
    }
    
    func setExtra(label: String, status: String) {
        
        //let extraLabel = self.extraLbl1 as UILabel
        
        if (extraLbl1.hidden)
        {
            self.extraLbl1.hidden = false
            self.extraLbl1.text = label
            self.setExtraStatus(status, imageView: self.extraImage1)
        }
        else if (extraLbl2.hidden)
        {
            self.extraLbl2.hidden = false
            self.extraLbl2.text = label
            self.setExtraStatus(status, imageView: self.extraImage2)
        }
        else if (extraLbl3.hidden)
        {
            self.extraLbl3.hidden = false
            self.extraLbl3.text = label
            self.setExtraStatus(status, imageView: self.extraImage3)
        }
        else if (extraLbl4.hidden)
        {
            self.extraLbl4.hidden = false
            self.extraLbl4.text = label
            self.setExtraStatus(status, imageView: self.extraImage4)
        }
        
        
    }
    
    func setExtraStatus(status:String,  imageView:UIImageView) {
        
        switch (status) {
            
        case "red":
            imageView.image = UIImage(named: "red")!;
            break;
        case "yellow":
            imageView.image = UIImage(named: "yellow")!;
            break;
        default:
            imageView.image = UIImage(named: "green")!;
            break;
            
        }
        
        imageView.hidden = false;
        
        
    }
    
    func setServerImage(serverType: String) {
        
        switch serverType {
            
        case "webserver" :
            self.serverImage = UIImage(named: "webserver");
            break;
        case "database" :
            self.serverImage = UIImage(named: "database");
            break;
        default :
            self.serverImage = UIImage(named: "server");
            break;
        }
        
    }
    
    
}
