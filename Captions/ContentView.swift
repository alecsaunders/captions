//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: CaptionsDocument
    @State var captions: Captions = Captions(fromText: "")

    var body: some View {
        NavigationView {
            VStack {
                ForEach($captions.cues) { $cue in
                    HStack {
                        CueView(cue: $cue)
                        Spacer()
                    }
                }
                
            }
                .frame(minWidth: 200)
            VStack {
                Text("Main body")
                Spacer()
                Button("OK") {
                    getSubContents()
                }
            }
            
        }
    }
    
    func getSubContents() -> Void {
        captions = Captions(fromText: document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(CaptionsDocument()))
    }
}
