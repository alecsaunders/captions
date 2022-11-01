//
//  TimeShiftButton.swift
//  Captions
//
//  Created by Saunders, Alec on 11/1/22.
//

import SwiftUI

struct TimeShiftButton: View {
    @Binding var cue: Cue
    @Binding var shiftControlOpts: ShiftControlOptions
    let addTime: Bool
    
    var body: some View {
        Button(addTime ? "+" : "-") {
            if CGKeyCode.optionKeyPressed {
                print("\(addTime ? "+" : "-") 1000")
            } else {
                print("\(addTime ? "+" : "-") 100")
            }
        }
    }
}

struct TimeShiftButton_Previews: PreviewProvider {
    @State static var cue = Cue()
    @State static var shiftControlOpts = ShiftControlOptions()
    static var addTime = false
    
    static var previews: some View {
        TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: addTime)
    }
}
