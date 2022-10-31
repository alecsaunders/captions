//
//  CueCellView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import Foundation
import SwiftUI


struct CueView: View {
    @Binding var cue: Cue

    var body: some View {
        VStack {
            Text("\(cue.identifier)")
            Text(cue.timings)
            Text(cue.text)
            Text("end cue\n")
        }
    }
}
