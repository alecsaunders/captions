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
    @Binding var showShiftControls: Bool
    @State var showPopover: Bool = false
    @State var startTimeSelected: Bool = false
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
                        showShiftControls = false
                        showPopover = false
                    }
                }
                .padding(5)
                .background(cue.id == highlighted?.id ? .secondary.opacity(0.125) : Color.clear)
                .cornerRadius(8)
                .padding(.leading, 8)
            Divider()
        }
        .popover(isPresented: $shiftControlOpts.showShiftPopover, attachmentAnchor: .rect(.rect(CGRect(x: shiftControlOpts.isStart ? 25 : 175, y: 5, width: 0, height: 0))) ) {
            HStack {
                Button("-") {
                    print("subtract")
                }
                Text("0.0")
                Button("+") {
                    print("add")
                }
            }
            .padding(20)
        }
    }
}
