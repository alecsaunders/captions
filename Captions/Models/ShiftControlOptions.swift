//
//  ShiftControlOptions.swift
//  Captions
//
//  Created by Saunders, Alec on 11/1/22.
//

import Foundation


struct ShiftControlOptions {
    var showShiftPopover: Bool = false
    var isStart: Bool = true
    var timeShiftValue: Int = 0
    var timeShiftLabel: String {
        return String(format: "%.3f", Double(self.timeShiftValue) / 1000.0)
    }
}
