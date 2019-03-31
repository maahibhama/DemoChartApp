//
//  ViewController.swift
//  DemoChartApp
//
//  Created by Maahi Bhama  on 28/03/19.
//  Copyright © 2019 Mahendra Bhama. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var linechart: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        linechart.delegate = self
        let constantData:[(Double, Double)] = [(30,1)]
        
        let datasetForChart = self.getLineDataSet(chartPoints: constantData, color: .yellow,label: "Card")
        let data : LineChartData = LineChartData()
        data.addDataSet(datasetForChart)
        linechart.data = data
       // linechart.xAxis.setLabelCount(constantData.count, force: true)
        linechart.setupKotakCharts(withMarker: true)
        //self.setupUIElements()
        linechart.highlightValue(x: 1, y: 30, dataSetIndex: 0, callDelegate: true)
    }
    
    func getLineDataSet(chartPoints:[(Double,Double)]?,color: UIColor,label: String) -> LineChartDataSet {
        var lineChartEntry1: [ChartDataEntry]? = nil
        if let chartDataPoint = chartPoints {
            lineChartEntry1 = [ChartDataEntry]()
            for i in 0 ..< chartDataPoint.count {
                let val1 = ChartDataEntry(x: chartDataPoint[i].1, y: chartDataPoint[i].0)
                lineChartEntry1?.append(val1)
            }
        }
       
            let line = LineChartDataSet(values: lineChartEntry1, label: "")
            line.setupKotakLineChartDataSet(colour: UIColor.red)
            return line
    }


}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry.y)
    }
}

