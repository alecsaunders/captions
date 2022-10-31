//
//  Caption.swift
//  Captions
//
//  Created by Saunders, Alec on 10/30/22.
//

import Foundation


struct Cue {
    let id: UUID = UUID()
    let identifier: Int
    let timings: String
    let settings: String
    let text: String
}


struct Captions {
    let cues: [Cue]
    
    init(fromText text: String) {
        self.cues = Captions.parse(fromText: text)
    }
    
    
    private static func parse(fromText text: String) -> [Cue] {
        let lines = text.components(separatedBy: .newlines)
        var tmpCues: [Cue] = []
        var isNewCue = true
        var tmpTimings = ""
        var tmpSettings = ""
        var tmpText = ""
        var cueCounter = 1
        for line in lines {
            if isNewCue {
                if !self.isEmptyLine(line: line) {
                    isNewCue = false
                    continue
                }
            }
            if isTimingsLine(line: line) {
                tmpTimings = line.trimmingCharacters(in: .whitespacesAndNewlines)
                continue
            }
            if self.isEmptyLine(line: line) {
                let tmpCue = Cue(identifier: cueCounter, timings: tmpTimings, settings: tmpSettings, text: tmpText)
                tmpCues.append(tmpCue)
                tmpTimings = ""
                tmpSettings = ""
                tmpText = ""
                isNewCue = true
                cueCounter += 1
                continue
            } else {
                tmpText += line
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
}


extension String {
    init(_ cue: Cue) {
        self = "\(cue.identifier)\n\(cue.timings)\n\(cue.text)"
    }
}


extension String {
    init(_ captions: Captions) {
        let cueStrings = captions.cues.map({ cue in
            String(cue)
        })
        self = cueStrings.joined(separator: "\n\n")
    }
}
