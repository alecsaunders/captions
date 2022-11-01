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
            TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: true)
        }
            .padding(20)
    }
}

struct TimeShiftView_Previews: PreviewProvider {
    @State static var cue = Cue()
    @State static var shiftControlOpts = ShiftControlOptions()
    
    static var previews: some View {
        TimeShiftView(cue: $cue, shiftControlOpts: $shiftControlOpts)
    }
}
