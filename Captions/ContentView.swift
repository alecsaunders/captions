//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: CaptionsDocument

    var body: some View {
        NavigationView {
            VStack {
                ForEach($document.captions.cues) { $cue in
                    HStack {
                        CueView(cue: $cue)
                        Spacer()
                    }
                }
                
            }
                .frame(minWidth: 200)
            VStack {
                Text("Main body")
                    .padding(25)
                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(CaptionsDocument()))
    }
}
