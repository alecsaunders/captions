//
//  TimeShiftView.swift
//  Captions
//
//  Created by Saunders, Alec on 11/1/22.
//

import SwiftUI

struct TimeShiftView: View {
    @Binding var captions: Captions
    @Binding var cue: Cue
    @Binding var shiftControlOpts: ShiftControlOptions
    
    var body: some View {
        VStack {
            Text("New Time: \(String(shiftControlOpts.newTimestamp(cue: cue)))")
                .font(Font.system(.body, design: .monospaced))
            Divider()
                .padding(.top, 0)
                .padding(.bottom, 10)
            HStack(spacing: 5) {
                TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: false)
                Text(shiftControlOpts.timeShiftLabel)
                    .frame(minWidth: 60, alignment: .trailing)
                    .timestampStyle()
                    .foregroundColor(.init("ControlsColor"))
                    .padding(3)
                TimeShiftButton(cue: $cue, shiftControlOpts: $shiftControlOpts, addTime: true)
                           
                Spacer()

                ControlGroup {
                    Button(shiftControlOpts.shiftSymbol) {
                        shiftAllRemainingTimestamps()
                        shiftControlOpts.resetOptions()
                    }
                        .disabled(shiftControlOpts.timeShiftValue == 0)
                    Menu("") {
                        Button("\(shiftControlOpts.shiftSymbol) \(shiftControlOpts.isStart ? "start" : "end") and remainingâ€¦") {
                            shiftAllRemainingTimestamps()
                            shiftControlOpts.resetOptions()
                        }
                        Divider()
                        Button("\(shiftControlOpts.shiftSymbol) \(shiftControlOpts.isStart ? "start" : "end") only") {
                            self.shiftSingleTimestamp()
                            shiftControlOpts.resetOptions()
                        }
                        Button("\(shiftControlOpts.shiftSymbol) both") {
                            self.shiftBothTimestamps()
                            shiftControlOpts.resetOptions()
                        }
                    }
                        .disabled(shiftControlOpts.timeShiftValue == 0)
                }
                    .frame(minWidth: 50)
                    .onSubmit {
                        print("Submitted")
                    }
            }
            Slider(value: $shiftControlOpts.timeShiftDouble, in: -200...200)
        }
    }
    
    private func shiftSingleTimestamp() {
        if shiftControlOpts.isStart {
            cue.timings.startTime.add(milliseconds: shiftControlOpts.timeShiftValue)
        } else {
            cue.timings.endTime.add(milliseconds: shiftControlOpts.timeShiftValue)
        }
    }
    
    private func shiftBothTimestamps() {
        cue.timings.startTime.add(milliseconds: shiftControlOpts.timeShiftValue)
        cue.timings.endTime.add(milliseconds: shiftControlOpts.timeShiftValue)
    }
    
    private func shiftAllRemainingTimestamps() {
        var shouldShiftTimestamp = false
        for idx in 0..<captions.cues.count {
            if shouldShiftTimestamp {
                captions.cues[idx].timings.startTime.add(milliseconds: shiftControlOpts.timeShiftValue)
                captions.cues[idx].timings.endTime.add(milliseconds: shiftControlOpts.timeShiftValue)
            }
            if captions.cues[idx].id == cue.id {
                if shiftControlOpts.isStart {
                    captions.cues[idx].timings.startTime.add(milliseconds: shiftControlOpts.timeShiftValue)
                }
                captions.cues[idx].timings.endTime.add(milliseconds: shiftControlOpts.timeShiftValue)
                shouldShiftTimestamp = true
            }
        }
    }
}

struct TimeShiftView_Previews: PreviewProvider {
    @State static var captions = Captions(fromText: "")
    @State static var cue = Cue()
    @State static var shiftControlOpts = ShiftControlOptions()
    
    static var previews: some View {
        TimeShiftView(captions: $captions, cue: $cue, shiftControlOpts: $shiftControlOpts)
    }
}
