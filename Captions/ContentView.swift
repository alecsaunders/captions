//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @Binding var document: CaptionsDocument
    @State var highlighted: Cue?

    var body: some View {
        NavigationView {
            List {
                ForEach($document.captions.cues) { $cue in
                    HStack {
                        CueView(captions: $document.captions, cue: $cue, highlighted: $highlighted)
                        Spacer()
                    }
                    .contextMenu {
                        Button("Delete row") {
                            self.document.captions.cues.removeAll { $0.id == cue.id }
                        }
                    }
                    .listRowInsets(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                }
            }
                .frame(minWidth: 278)
                .listStyle(PlainListStyle())
            VStack {
                VideoPlayer(player: document.player)
                Spacer()
                Button("Add Movie") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    if panel.runModal() == .OK {
                        if let fileUrl = panel.url {
                            document.playerUrl = fileUrl
                            document.loadPlayer()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(CaptionsDocument()))
    }
}
