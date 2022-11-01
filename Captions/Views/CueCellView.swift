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

    var body: some View {
        VStack {
            CueHeaderView(cue: $cue)
            CueTimingsView(cue: $cue)
            CueTextView(cue: $cue)
            Divider()
        }
            .onHover { hovering in
                if hovering {
                    highlighted = cue
                }
            }
            .padding(5)
            .background(cue.id == highlighted?.id ? .secondary.opacity(0.125) : Color.clear)
            .cornerRadius(8)
            .padding(.leading, 5)
    }
}
