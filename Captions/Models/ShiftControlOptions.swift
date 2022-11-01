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
    var timeShiftDouble: Double {
        get {
            return Double(timeShiftValue)
        }
        set {
            timeShiftValue = Int(newValue)
        }
        
    }
    var timeShiftLabel: String {
        return String(format: "%.3f", Double(self.timeShiftValue) / 1000.0)
    }
    
    var shiftSymbol: String {
        return self.shiftGTEZero() ? ">>" : "<<"
    }
    
    mutating func resetOptions() -> Void {
        showShiftPopover = false
        timeShiftValue = 0
    }
    
    func shiftGTEZero() -> Bool {
        return timeShiftValue >= 0
    }
    
    func newTimestamp(cue: Cue) -> Timestamp {
        var timestamp = isStart ? cue.timings.startTime : cue.timings.endTime
        timestamp.add(milliseconds: timeShiftValue)
        return timestamp
    }
}
