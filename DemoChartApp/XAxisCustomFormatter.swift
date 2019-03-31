//
//  XAxisCustomFormatter.swift
//  Kotak
//
//  Created by Purushottam Chandra on 02/04/18.
//  Copyright © 2018 Kuliza. All rights reserved.
//

import Charts

class XAxisCustomFormatter: NSObject, IAxisValueFormatter {
    fileprivate var values: [String]?
    let dateFormatter = DateFormatter()
    let returnDateFormatter = DateFormatter()
    
    convenience init(values: [String],defaultFormat: String = "dd-MM-yyyy", format: String) {
        self.init()
        self.values = values
        dateFormatter.dateFormat = defaultFormat
        returnDateFormatter.dateFormat = format
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard let values = values, index >= 0, index < values.count, let date = dateFormatter.date(from: values[index]) else {
            return ""
        }
        if returnDateFormatter.dateFormat != "dd" {
            if values[index].lowercased().contains("jan") || index == 0 {
                returnDateFormatter.dateFormat = "MMM-yyyy"
                let finalDate = returnDateFormatter.string(from: date)
                let dateComponents = finalDate.split(separator: "-")
                return dateComponents[0] + "\n" + dateComponents[1]
            } else {
                returnDateFormatter.dateFormat = "MMM"
            }
        } else {
            let components = values[index].split(separator: "-")
            return String(components[0])
        }
        return returnDateFormatter.string(from: date)
    }
}

class YAxisCustomFormatter: NSObject, IAxisValueFormatter {
    
    override init() {
        
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))"
    }
}
