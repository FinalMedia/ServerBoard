//
//  Server.swift
//  ServerMonitor
//
//  Created by Mark Westenberg on 05/10/15.
//  Copyright © 2015 Final Media. All rights reserved.
//

import Foundation
import WatchKit




struct GlanceAlert {
    let name: String
    let type: String
    let value: String
}

class Server {
    
    var serverImage: UIImage?
    var name: String
    var cpuText: String
    var cpuColor: UIColor
    var memText: String
    var memColor: UIColor
    var extraLbl1: String
    var extraImage1: UIImage
    var extraLbl2: String
    var extraImage2: UIImage
    var extraLbl3: String
    var extraImage3: UIImage
    var extraLbl4: String
    var extraImage4: UIImage
    var glanceAlerts  = [GlanceAlert]()

    
    init?(name: String, cpu: Double, mem: Double) {
        
        self.name = name;
        self.cpuText = ""
        self.cpuColor = UIColor.greenColor()
        self.memText = ""
        self.memColor = UIColor.greenColor()
        self.extraLbl1 = ""
        self.extraLbl1 = ""
        self.extraLbl2 = ""
        self.extraLbl3 = ""
        self.extraLbl4 = ""
        self.extraImage1 = UIImage()
        self.extraImage2 = UIImage()
        self.extraImage3 = UIImage()
        self.extraImage4 = UIImage()
        
        
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
    
    
    
    func setCpuMem(cpu: Double, mem: Double) {
        
        
        let cpuVal: Int = Int(cpu)
        let memVal: Int = Int(mem)
        
        switch (cpuVal) {
            
        case _ where cpuVal > 90:
            self.cpuColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            self.cpuText = self.convertDoubleToString(cpu,decimals: 0) + "%"
            self.glanceAlerts += [GlanceAlert(name: self.name, type: "cpu", value: String(cpuVal))]
            break
        case 80...90:
            self.cpuColor = UIColor(red: 253, green: 236, blue: 0, alpha: 1)
            self.cpuText = self.convertDoubleToString(cpu,decimals: 0) + "%"
            break
            
        default:
            self.cpuColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
            self.cpuText = self.convertDoubleToString(cpu,decimals: 0) + "%"
            break;
        }
        
        
        switch (memVal) {
            
        case _ where memVal > 90:
            self.memColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
            self.memText = self.convertDoubleToString(mem,decimals: 0) + "%"
            self.glanceAlerts += [GlanceAlert(name: self.name, type: "mem", value: String(memVal))]
            break
        case 80...90:
            self.memColor = UIColor(red: 253, green: 236, blue: 0, alpha: 1)
            self.memText = self.convertDoubleToString(mem,decimals:0) + "%"
            break
            
        default:
            self.memColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
            self.memText = self.convertDoubleToString(mem,decimals:0) + "%"
            break;
        }
        
        
    }
    
    func convertDoubleToString(doubleValue : Double, decimals: Double) -> String {
        
        if (decimals == 0)
        {
            return String(Int(doubleValue))
        }
        
        let dec = pow(10, decimals);
        
        let roundedVal = Double(round(dec*doubleValue)/dec)
        return String(roundedVal)
    }
    
    
    func setExtra(label: String, status: String) {
        
        //let extraLabel = self.extraLbl1 as UILabel
        
        if (extraLbl1.isEmpty)
        {
            self.extraLbl1 = label
            self.extraImage1 =  self.setExtraStatus(status)
            
        }
        else if (extraLbl2.isEmpty)
        {
            self.extraLbl2 = label
            self.extraImage2 =  self.setExtraStatus(status)
        }
        else if (extraLbl3.isEmpty)
        {
            self.extraLbl3 = label
            self.extraImage3 =  self.setExtraStatus(status)
        }
        else if (extraLbl4.isEmpty)
        {
            self.extraLbl4 = label
            self.extraImage4 =  self.setExtraStatus(status)
        }
        
        if status == "red"
        {
            self.glanceAlerts += [GlanceAlert(name: self.name, type: "label", value: status)]
        }
        
    }
    
    func setExtraStatus(status:String) -> UIImage {
        var image: UIImage
        
        
        
        switch (status) {
            case "red":
                image = UIImage(named: "red")!;
                break;
            case "yellow":
                image = UIImage(named: "yellow")!;
                break;
            default:
                image = UIImage(named: "green")!;
                break;
            
        }
        
        return image;
        
    }
    
    
    func getGlanceInfo() {
        
        
        
    }
    
}
