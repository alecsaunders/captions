//
//  TimestampButton.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI

struct TimestampButton: View {
    @Binding var cue: Cue
    @State var start: Bool = false
    @Binding var showShiftControls: Bool
    @Binding var showPopover: Bool
    
    var body: some View {
        Button(String(start ? cue.timings.startTime: cue.timings.endTime)) {
            cue.timings.startTime.add(milliseconds: 1500)
            showPopover = true
            showShiftControls = true
        }
            .buttonStyle(.plain)
    }
}

struct TimestampButton_Previews: PreviewProvider {
    @State static var cue: Cue = Cue()
    @State static var showShiftControls: Bool = false
    @State static var showPopover: Bool = false
    
    static var previews: some View {
        TimestampButton(cue: $cue, showShiftControls: $showShiftControls, showPopover: $showPopover)
    }
}
