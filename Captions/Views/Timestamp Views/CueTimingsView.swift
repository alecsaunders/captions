//
//  CueTimingsView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueTimingsView: View {
    @Binding var cue: Cue
    @Binding var highlighted: Cue?
    @Binding var shiftControlOpts: ShiftControlOptions

    var body: some View {
        HStack {
            TimestampButton(cue: $cue, start: true, shiftControlOpts: $shiftControlOpts)
            Text("-->")
            TimestampButton(cue: $cue, start: false, shiftControlOpts: $shiftControlOpts)
            Spacer()
        }
    }
}
