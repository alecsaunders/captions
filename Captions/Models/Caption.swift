//
//  Caption.swift
//  Captions
//
//  Created by Saunders, Alec on 10/30/22.
//

import Foundation
import AVKit


struct Captions {
    var cues: [Cue]


    init(fromText text: String) {
        self.cues = Captions.parse(fromText: text)
    }
    
    
    private static func parse(fromText text: String) -> [Cue] {
        let lines = text.components(separatedBy: .newlines)
        var tmpCues: [Cue] = []
        var isNewCue = true
        var tmpTimings = Timings()
        var tmpSettings = ""
        var tmpText = ""
        var cueCounter = 1
        for idx in 0..<lines.count {
            let line = lines[idx]
            if line.trimmingCharacters(in: .whitespacesAndNewlines) == "WEBVTT" {
                continue
            }
            if isNewCue {
                if !self.isEmptyLine(line: line) {
                    isNewCue = false
                    continue
                }
            }
            if isTimingsLine(line: line) {
                tmpTimings = Timings(timingsLine: line)
                continue
            }
            if self.isEmptyLine(line: line) && !isNewCue {
                let tmpCue = Cue(identifier: cueCounter, timings: tmpTimings, settings: tmpSettings, text: tmpText)
                tmpCues.append(tmpCue)
                tmpTimings = Timings()
                tmpSettings = ""
                tmpText = ""
                isNewCue = true
                cueCounter += 1
                continue
            } else {
                tmpText += line
            }
            if idx == lines.count - 1 && !isNewCue {
                let tmpCue = Cue(identifier: cueCounter, timings: tmpTimings, settings: tmpSettings, text: tmpText)
                tmpCues.append(tmpCue)
            }
        }
        return tmpCues
    }
    
    private static func isEmptyLine(line: String) -> Bool {
        return line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private static func isTimingsLine(line: String) -> Bool {
        if line.contains("-->") && line.contains(":") {
            return true
        }
        return false
    }
    
    mutating func removeCue(withId: Int) {
        var cueIndex: Int = 0
        
        for idx in 0..<self.cues.count{
            if self.cues[idx].identifier == withId {
                cueIndex = idx
            }
        }
        if cueIndex > 0 {
            self.cues.remove(at: cueIndex)
        }
    }
    
    func getCueBeforeTime(time: CMTime) -> Cue {
        var cueToJumpTo = cues[0]
        for someCue in cues {
            if someCue.timings.startTime.timeValue < time.seconds {
                cueToJumpTo = someCue
            } else {
                break
            }
        }
        return cueToJumpTo
    }
}


extension String {
    init(_ captions: Captions) {
        let cueStrings = captions.cues.map({ cue in
            String(cue)
        })
        self = "WEBVTT\n\n\(cueStrings.joined(separator: "\n\n"))\n"
    }
}
