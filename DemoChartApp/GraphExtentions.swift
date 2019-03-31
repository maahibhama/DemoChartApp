//
//  GraphExtentions.swift
//  Kotak
//
//  Created by Purushottam Chandra on 05/02/19.
//  Copyright © 2019 Kuliza. All rights reserved.
//

import Charts

extension LineChartView {
    func setupKotakCharts(withMarker: Bool = true) {
        setupKotakLegend()
        doubleTapToZoomEnabled = false
        rightAxis.axisLineColor = .clear
        rightAxis.labelTextColor = .clear
        xAxis.drawGridLinesEnabled = false
        leftAxis.drawGridLinesEnabled = false
        rightAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        chartDescription?.text = ""
        xAxis.avoidFirstLastClippingEnabled = false
        xAxis.granularityEnabled = true
        scaleXEnabled = false
        scaleYEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.valueFormatter = YAxisCustomFormatter()
        fitScreen()
        extraBottomOffset = 15
        xAxis.labelFont = UIFont.systemFont(ofSize: 17)
        xAxis.labelTextColor = .black
        xAxis.axisLineWidth = 3
        xAxis.axisLineColor = .green
        leftAxis.axisLineWidth = 3
        leftAxis.axisLineColor = .green
        xAxis.labelRotationAngle = 0
        if withMarker {
            let customMarker = BalloonMarker(color: .orange, font: UIFont.systemFont(ofSize: 22), textColor: .black, insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
           // customMarker.image = ImageAssets.graphSelection.image
            marker = customMarker
            customMarker.chartView = self
        } else {
            marker = nil
        }
        noDataTextColor = .black
        noDataFont = UIFont.systemFont(ofSize: 22)
    }
    
    private func setupKotakLegend() {
        legend.drawInside = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .horizontal
        legend.formSize = 10.0
        legend.font = UIFont.systemFont(ofSize: 15)
        legend.form = .circle
        legend.textColor = .black
    }
}

extension LineChartDataSet {
    
    func setupKotakLineChartDataSet(colour: UIColor) {
        colors = [colour]
        drawCirclesEnabled = false
        circleColors = [.black]
        circleRadius = 1.5
        drawCircleHoleEnabled = false
        drawValuesEnabled = false
        fillColor = .clear
        drawFilledEnabled = true
        highlightLineDashPhase = 3
        highlightLineDashLengths = [3 ,3]
        drawHorizontalHighlightIndicatorEnabled = false
        if colour == .white {
            highlightLineWidth = 0
        } else {
            highlightLineWidth = 2
        }
        lineWidth = 3
        //mode = .horizontalBezier
    }
}
