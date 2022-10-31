//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: CaptionsDocument
    @Binding var captions: Captions

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
        let fileUrl = Bundle.main.url(forResource: "subtitle", withExtension: "srt")
        do {
            let contents = try String(contentsOf: fileUrl!)
            captions = Captions(fromText: contents)
        } catch {
            print("Error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var captions = Captions(fromText: "")
    
    static var previews: some View {
        ContentView(document: .constant(CaptionsDocument()), captions: $captions)
    }
}
