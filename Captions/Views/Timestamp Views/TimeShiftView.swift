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
        HStack {
            TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: false)
            Text(shiftControlOpts.timeShiftLabel)
                .frame(minWidth: 55, alignment: .trailing)
                .font(Font.system(.body, design: .monospaced))
            TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: true)
            Spacer()
            Button("Shift") {
                print("shift timestamp")
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
