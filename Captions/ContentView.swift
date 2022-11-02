//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: CaptionsDocument
    @State var highlighted: Cue?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach($document.captions.cues) { $cue in
                        HStack {
                            CueView(captions: $document.captions, cue: $cue, highlighted: $highlighted)
                            Spacer()
                        }
                        .contextMenu {
                            Button("Delete row") {
                                document.captions.removeCue(withId: cue.identifier)
                            }
                        }
                    }
                }
            }
                .frame(minWidth: 268)
            
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
