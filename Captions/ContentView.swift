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
    @State var showShiftControls: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach($document.captions.cues) { $cue in
                        HStack {
                            CueView(cue: $cue, highlighted: $highlighted, showShiftControls: $showShiftControls)
                            Spacer()
                        }
                    }
                    
                }
            }
                .frame(minWidth: 250)
            
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
