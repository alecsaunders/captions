//
//  CaptionsApp.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI

@main
struct CaptionsApp: App {
    @State var captions: Captions = Captions(fromText: "")

    var body: some Scene {
        DocumentGroup(newDocument: CaptionsDocument()) { file in
            ContentView(document: file.$document, captions: $captions)
        }
    }
}
