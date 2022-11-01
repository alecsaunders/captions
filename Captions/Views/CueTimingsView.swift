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
    @Binding var showShiftControls: Bool

    var body: some View {
        HStack {
            TimestampButton(cue: $cue, start: true, showShiftControls: $showShiftControls)
            Text("-->")
            TimestampButton(cue: $cue, start: false, showShiftControls: $showShiftControls)
            
            if highlighted?.id == cue.id && showShiftControls {
                Button("Adjust timestamp") {
                    print("adjust")
                }
            }
            
            Spacer()
        }
    }
}
