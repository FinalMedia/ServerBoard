//
//  BarChartViewController.swift
//  ServerMonitor
//
//  Created by Mark Westenberg on 07/10/15.
//  Copyright © 2015 Final Media. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet var barChartView: LineChartView!
    var server: Server?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
        if let _ = self.server {
            
            
            let cpuHistoryStringArr = server?.ProcessorHistory!.componentsSeparatedByString(",")
            var cpuHistory = [Int]()
            var xAxis = [String]()
        
            var index = 0
            for val: String in cpuHistoryStringArr! {
                 if (!val.isEmpty)
                 {
                    xAxis.append(String(""))
                    cpuHistory.append(Int(val)!)
                }
                index++
            }
            
            self.setBarChart(xAxis, values: cpuHistory)
            
        }
        

    }
    
    
    //line chart
    func setLineChart(dataPoints: [String], values: [Int]) {
        barChartView.noDataText = "No data received"
        barChartView.noDataTextDescription = "There was no CPU data available at the moment"
        self.barChartView!.infoTextColor = UIColor.blackColor()
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: Double(values[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "CPU in %")
        chartDataSet.drawCirclesEnabled = false;
    
        let chartData = LineChartData(xVals: dataPoints, dataSet: chartDataSet)
        barChartView.descriptionText = "CPU History"
        barChartView.data = chartData
        
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        
    }
    
    //bar chart
    func setBarChart(dataPoints: [String], values: [Int]) {
        barChartView.noDataText = "No data received"
        barChartView.noDataTextDescription = "There was no CPU data available at the moment"
        self.barChartView!.infoTextColor = UIColor.blackColor()
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: Double(values[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "CPU in percentage (%)")
        chartDataSet.setColor(UIColor.blackColor())
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        barChartView.descriptionText = "CPU History"
        barChartView.data = chartData
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func dismissPopOverView(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

}
