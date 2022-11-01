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

    var body: some View {
        VStack {
            VStack {
                CueHeaderView(cue: $cue)
                CueTimingsView(cue: $cue, highlighted: $highlighted, showShiftControls: $showShiftControls, showPopover: $showPopover)
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
        .popover(isPresented: $showPopover) {
            Text("Popover")
                .padding(10)
        }
    }
}
