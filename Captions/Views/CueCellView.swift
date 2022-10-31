//
//  CueCellView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueView: View {
    @Binding var cue: Cue

    var body: some View {
        VStack {
            CueHeaderView(cue: $cue)
            CueTimingsView(cue: $cue)
            CueTextView(cue: $cue)
            Divider()
        }
    }
}
