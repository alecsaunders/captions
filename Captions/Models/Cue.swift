//
//  Cue.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import Foundation


struct Timestamp {
    private let timeValue: Double
    
    init(_ timeValue: Double) {
        self.timeValue = timeValue
    }
}

extension Timestamp {
    func hour() -> Int {
        return Int(timeValue / 3600.0)
    }
    
    func minute() -> Int {
        return Int((timeValue - Double(self.hour()) * 3600.0) / 60.0)
    }
    
    func second() -> Int {
        return Int(timeValue - (Double(self.hour()) * 3600.0) - (Double(self.minute()) * 60.0))
    }
    
    func millisecond() -> Int {
        return Int(timeValue * 1000) - Int(timeValue) * 1000
    }
}


struct Timings {
    let startTime: Timestamp
    let endTime: Timestamp
    
    init(timingsLine: String) {
        startTime = Timings.parse(line: timingsLine, parseStartTime: true)
        endTime = Timings.parse(line: timingsLine, parseStartTime: false)
    }
    
    init() {
        startTime = Timestamp(0.0)
        endTime = Timestamp(0.0)
    }
    
    private static func parse(line: String, parseStartTime: Bool) -> Timestamp {
        let parts = line.components(separatedBy: " --> ")
        if parseStartTime {
            return stringToTimestamp(timestampString: parts[0].trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            return stringToTimestamp(timestampString: parts[1].trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
    private static func stringToTimestamp(timestampString: String) -> Timestamp {
        var hourString = "0"
        var minString = "0"
        var secString = "0"
        var milString = "0"
        var tsParts = timestampString.components(separatedBy: ":")
        let secMil = tsParts.popLast()
        if let secMil = secMil {
            var separator = "."
            if secMil.contains(",") {
                separator = ","
            }
            let secMilParts = secMil.components(separatedBy: separator)
            secString = secMilParts[0]
            milString = secMilParts[1]
            minString = timePartToString(tsParts.popLast())
            hourString = timePartToString(tsParts.popLast())
        }
        return Timestamp(Double(Int(hourString)! * 3600 + Int(minString)! * 60 + Int(secString)!) + Double(Double(milString)! / 1000))
    }
    
    
    private static func timePartToString(_ part: String?) -> String {
        if let part = part {
            return part
        } else {
            return "0"
        }
    }
}


class Cue: Identifiable {
    let id: UUID = UUID()
    let identifier: Int
    let timings: Timings
    let settings: String
    var text: String
    
    init() {
        self.identifier = 0
        self.timings = Timings(timingsLine: "00:00.000 --> 00:00.000")
        self.settings = ""
        self.text = "New Caption"
    }
    
    init(identifier: Int, timings: Timings, settings: String, text: String) {
        self.identifier = identifier
        self.timings = timings
        self.settings = settings
        self.text = text
    }
}


extension String {
    init(_ timestamp: Timestamp) {
        self = "\(String(format: "%02d", timestamp.hour())):\(String(format: "%02d", timestamp.minute())):\(String(format: "%02d", timestamp.second())).\(String(format: "%03d", timestamp.millisecond()))"
    }
}

extension String {
    init(_ timings: Timings) {
        self = "\(String(timings.startTime)) --> \(String(timings.endTime))"
    }
}


extension String {
    init(_ cue: Cue) {
        self = "\(cue.identifier)\n\(String(cue.timings))\n\(cue.text)"
    }
}
