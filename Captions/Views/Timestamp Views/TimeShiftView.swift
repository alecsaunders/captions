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
        VStack {
            HStack(spacing: 5) {
                TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: false)
                Text(shiftControlOpts.timeShiftLabel)
                    .frame(minWidth: 60, alignment: .trailing)
                    .font(Font.system(.body, design: .monospaced))
                    .padding(3)
                TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: true)
                           
                Spacer()

                ControlGroup {
                    Button(shiftControlOpts.shiftSymbol) {
                        print("Shift timestamp by \(shiftControlOpts.timeShiftLabel)")
                    }
                        .disabled(shiftControlOpts.timeShiftValue == 0)
                    Menu(content: {
                        Button("\(shiftControlOpts.shiftSymbol) \(shiftControlOpts.isStart ? "start" : "end") and remaining…") {}
                        Divider()
                        Button("\(shiftControlOpts.shiftSymbol) \(shiftControlOpts.isStart ? "start" : "end") only") {}
                        Button("\(shiftControlOpts.shiftSymbol) both") {}
                    }, label: {
                        Image(systemName: "down")
                    })
                        .disabled(shiftControlOpts.timeShiftValue == 0)
                }
                    .frame(minWidth: 50)
                    .onSubmit {
                        print("Submitted")
                    }
            }
            Slider(value: $shiftControlOpts.timeShiftDouble, in: -200...200)
            Divider()
            Text("New Time: \(String(shiftControlOpts.newTimestamp(cue: cue)))")
                .font(Font.system(.body, design: .monospaced))
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
