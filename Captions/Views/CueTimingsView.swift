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
    @Binding var showPopover: Bool

    var body: some View {
        HStack {
            TimestampButton(cue: $cue, start: true, showShiftControls: $showShiftControls, showPopover: $showPopover)
            Text("-->")
            TimestampButton(cue: $cue, start: false, showShiftControls: $showShiftControls, showPopover: $showPopover)            
            Spacer()
        }
    }
}
