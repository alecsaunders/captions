//
//  TimeShiftView.swift
//  Captions
//
//  Created by Saunders, Alec on 11/1/22.
//

import SwiftUI

struct TimeShiftView: View {
    @Binding var cue: Cue
    @Binding var shiftControlOpts: ShiftControlOptions
    
    var body: some View {
        HStack(spacing: 5) {
            TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: false)
            Text(shiftControlOpts.timeShiftLabel)
                .frame(minWidth: 60, alignment: .trailing)
                .font(Font.system(.body, design: .monospaced))
                .padding(3)
            TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: true)
                       
            Spacer()
            Button("Shift") {
                print("shift \(shiftControlOpts.timeShiftLabel)")
            }
        }
    }
}

struct TimeShiftView_Previews: PreviewProvider {
    @State static var cue = Cue()
    @State static var shiftControlOpts = ShiftControlOptions()
    
    static var previews: some View {
        TimeShiftView(cue: $cue, shiftControlOpts: $shiftControlOpts)
    }
}
