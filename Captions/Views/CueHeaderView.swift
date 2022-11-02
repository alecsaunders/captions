//
//  CueHeaderView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueHeaderView: View {
    @Binding var cue: Cue
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
                        print("play")
                    } label: {
                        Image(systemName: "play.circle")
                    }
                        .buttonStyle(.borderless)
                        .tint(.blue)
                }
                Spacer()
            }
                .frame(width: 60)
                .onHover { hovering in
                    showPlayIcon = hovering
                }
            Spacer()
        }
    }
}

