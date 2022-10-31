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
    let cues: [Cue] = []
    
    let tempText: String
    
    init(fromText text: String) {
        self.tempText = "\(text)"
    }
    
    func toText() -> String {
        return tempText
    }
}
