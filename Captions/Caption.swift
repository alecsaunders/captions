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
