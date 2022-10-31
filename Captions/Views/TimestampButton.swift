//
//  TimestampButton.swift
//  Captions
//
//  Created by Saunders, Alec on 10/31/22.
//

import SwiftUI

struct TimestampButton: View {
    @Binding var cue: Cue
    @State var start: Bool = false
    
    var body: some View {
        Button(String(start ? cue.timings.startTime: cue.timings.endTime)) {
            print("Click \(start ? "start" : "end") time")
        }
            .buttonStyle(.plain)
    }
}

struct TimestampButton_Previews: PreviewProvider {
    @State static var cue: Cue = Cue()
    
    static var previews: some View {
        TimestampButton(cue: $cue)
    }
}
