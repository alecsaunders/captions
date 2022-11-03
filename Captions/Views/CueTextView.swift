//
//  CueTextView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI


struct CueTextView: View {
    @FocusState private var textFocus: Bool
    @Binding var cue: Cue

    var body: some View {
        HStack {
            TextField("", text: $cue.text)
                .textFieldStyle(.plain)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        self.textFocus = false
                    }
                }
                .focused($textFocus)
            Spacer()
        }
    }
}
