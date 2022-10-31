//
//  CueTimingsView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueTimingsView: View {
    @Binding var cue: Cue

    var body: some View {
        HStack {
            TimestampButton(cue: $cue, start: true)
            Text("-->")
            TimestampButton(cue: $cue, start: false)
            Spacer()
        }
    }
}
