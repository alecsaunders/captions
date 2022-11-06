//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI
import AVKit
import MediaPlayer

struct ContentView: View {
    @Binding var document: CaptionsDocument
    var file: FileDocumentConfiguration<CaptionsDocument>
    @State var highlighted: Cue?

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { value in
                    LazyVStack {
                        Button("Temp scrollTo logic") {
                            value.scrollTo(500, anchor: .top)
                        }
                        ForEach($document.captions.cues) { $cue in
                            HStack {
                                CueView(captions: $document.captions, videoPlayer: $document.player, cue: $cue, highlighted: $highlighted)
                                Spacer()
                            }
                            .contextMenu {
                                Button("Delete row") {
                                    self.document.captions.cues.removeAll { $0.id == cue.id }
                                }
                            }
                            .listRowInsets(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                            .id(cue.identifier)
                        }
                    }
                }
            }
            .padding(.leading, 8)
                .frame(minWidth: 278)
                .listStyle(PlainListStyle())
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        VideoPlayer(player: document.player)
                            
                        VStack {
                            Rectangle()
                                .fill(Color(.white).opacity(0.001))
                                .zIndex(1)
                                .frame(width: geometry.size.width, height: geometry.size.height - 45)
                                .onTapGesture {
                                    if document.player.rate > 0 {
                                        document.player.pause()
                                    } else {
                                        document.player.play()
                                    }
                                }
                            Spacer()
                        }
                    }
                }
                .toolbar {
                    Button {
                        print("Skip to now")
                    } label: {
                        Image(systemName: "arrow.forward.to.line.circle")
                    }
                    Button {
                        let currentTime = document.player.currentTime()
                        let isPlaying = document.player.rate > 0
                        document.player.pause()
                        document.player = AVPlayer()
                        document.loadPlayer(subsUrl: file.fileURL!)
                        document.player.seek(to: currentTime, toleranceBefore: .zero, toleranceAfter: .zero)
                        if isPlaying {
                            document.player.play()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                        .keyboardShortcut("r", modifiers: .command)
                    Button {
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = false
                        if panel.runModal() == .OK {
                            if let fileUrl = panel.url {
                                document.playerUrl = fileUrl
                                document.loadPlayer(subsUrl: file.fileURL!)
                            }
                        }
                    } label: {
                        Image(systemName: "film")
                    }
                        .frame(width: 50)
                        .buttonStyle(.bordered)
                }
            }
            
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(document: .constant(CaptionsDocument()))
//    }
//}
