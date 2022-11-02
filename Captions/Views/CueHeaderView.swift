//
//  CueHeaderView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI
import AVKit


struct CueHeaderView: View {
    @Binding var cue: Cue
    @Binding var videoPlayer: AVPlayer
    @State var showPlayIcon: Bool = false

    var body: some View {
        HStack {
            HStack {
                Text("\(cue.identifier)")
                    .fontWeight(.semibold)
                    .font(.system(size: CGFloat(12)))
                    .foregroundColor(.gray)
                if showPlayIcon {
                    Button {
                        videoPlayer.seek(to: CMTime(Timestamp(cue.timings.startTime.timeValue - 0.5)), toleranceBefore: .zero, toleranceAfter: .zero)
                        videoPlayer.play()
                    } label: {
                        Image(systemName: "play.circle")
                    }
                        .buttonStyle(.borderless)
                        .tint(.blue)
                }
                Spacer()
            }
                .frame(width: 75)
                .onHover { hovering in
                    showPlayIcon = hovering
                }
            Spacer()
        }
    }
}

