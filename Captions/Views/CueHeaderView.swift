//
//  CueHeaderView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueHeaderView: View {
    @Binding var cue: Cue

    var body: some View {
        HStack {
            Text("\(cue.identifier)")
            Spacer()
        }
    }
}
