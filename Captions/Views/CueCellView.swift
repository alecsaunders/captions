//
//  CueCellView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI
import AVKit


struct CueView: View {
    @Binding var captions: Captions
    @Binding var videoPlayer: AVPlayer
    @Binding var cue: Cue
    @Binding var highlighted: Cue?
    @State var shiftControlOpts = ShiftControlOptions()
    @State var hoveringOverClearButton = false


    var body: some View {
        VStack {
            ZStack {
                VStack(spacing: 5) {
                    CueHeaderView(cue: $cue, videoPlayer: $videoPlayer)
                    CueTimingsView(cue: $cue, highlighted: $highlighted, shiftControlOpts: $shiftControlOpts)
                    CueTextView(cue: $cue)
                }
                    .onHover { hovering in
                        if hovering {
                            highlighted = cue
                            shiftControlOpts.resetOptions()
                        } else {
                            highlighted = nil
                        }
                    }
                if highlighted?.id == cue.id {
                    HStack {
                        Spacer()
                        VStack {
                            Button {
                                captions.removeCue(withId: cue.identifier)
                            } label: {
                                Image(systemName: "multiply.circle")
                            }
                                .buttonStyle(.borderless)
                                .onHover { hovering in
                                    hoveringOverClearButton = hovering
                                }
                                .tint(hoveringOverClearButton ? .red : Color("ControlsColor"))
                            Spacer()
                        }
                    }
                    .frame(height: 58)
                }
            }
                .padding(5)
                .background(cue.id == highlighted?.id ? .secondary.opacity(0.125) : Color.clear)
                .cornerRadius(8)
            Divider()
        }
            .popover(isPresented: $shiftControlOpts.showShiftPopover, attachmentAnchor: .rect(.rect(CGRect(x: shiftControlOpts.isStart ? 50 : 185, y: 5, width: 0, height: 0))) ) {
                TimeShiftView(captions: $captions, cue: $cue, shiftControlOpts: $shiftControlOpts)
                    .frame(minWidth: 175)
                    .padding(20)
            }
    }
}
