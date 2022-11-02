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
    @Binding var shiftControlOpts: ShiftControlOptions
    @State var timeButtonHover: Bool = false
    
    var body: some View {
        Button(String(start ? cue.timings.startTime: cue.timings.endTime)) {
            shiftControlOpts.showShiftPopover = true
            shiftControlOpts.isStart = start
        }
            .buttonStyle(.plain)
            .timestampStyle()
            .onHover { hovering in
                timeButtonHover = hovering
            }
            .padding(1)
            .foregroundColor(timeButtonHover ? .primary.opacity(0.8) : .primary)
            .cornerRadius(5)
    }
}

struct TimestampButton_Previews: PreviewProvider {
    @State static var cue: Cue = Cue()
    @State static var shiftControlOpts = ShiftControlOptions()
    
    static var previews: some View {
        TimestampButton(cue: $cue, shiftControlOpts: $shiftControlOpts)
    }
}
