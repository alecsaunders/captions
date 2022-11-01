//
//  CueCellView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueView: View {
    @Binding var cue: Cue
    @Binding var highlighted: Cue?
    @State var shiftControlOpts = ShiftControlOptions()


    var body: some View {
        VStack {
            VStack {
                CueHeaderView(cue: $cue)
                CueTimingsView(cue: $cue, highlighted: $highlighted, shiftControlOpts: $shiftControlOpts)
                CueTextView(cue: $cue)
            }
                .onHover { hovering in
                    if hovering {
                        highlighted = cue
                        shiftControlOpts.resetOptions()
                    }
                }
                .padding(5)
                .background(cue.id == highlighted?.id ? .secondary.opacity(0.125) : Color.clear)
                .cornerRadius(8)
                .padding(.leading, 8)
            Divider()
        }
        .popover(isPresented: $shiftControlOpts.showShiftPopover, attachmentAnchor: .rect(.rect(CGRect(x: shiftControlOpts.isStart ? 50 : 175, y: 5, width: 0, height: 0))) ) {
            TimeShiftView(cue: $cue, shiftControlOpts: $shiftControlOpts)
                .frame(minWidth: 150)
                .padding(20)
        }
    }
}
