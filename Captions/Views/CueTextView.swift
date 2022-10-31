//
//  CueTextView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueTextView: View {
    @Binding var cue: Cue

    var body: some View {
        HStack {
            TextField("", text: $cue.text)
            Spacer()
        }
    }
}
