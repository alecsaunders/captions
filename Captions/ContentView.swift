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
    @State var searchText: String = ""
    @State var highlighted: Cue?
    @State private var scrollTarget: Int?
    @State private var searchResults: [Cue] = []

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { (proxy: ScrollViewProxy) in
                    LazyVStack {
                        ForEach($document.captions.cues) { $cue in
                            CueView(captions: $document.captions, videoPlayer: $document.player, cue: $cue, highlighted: $highlighted)
                                .searchable(text: $searchText) {
                                    SearchView(searchResults: $searchResults, scrollTarget: $scrollTarget)
                                }
                                .contextMenu {
                                    Button("Delete row") {
                                        self.document.captions.cues.removeAll { $0.id == cue.id }
                                    }
                                }
                                .listRowInsets(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                                .id(cue.identifier)
                        }
                        .onChange(of: scrollTarget) { target in
                            if let target = target {
                                scrollTarget = nil

                                withAnimation {
                                    proxy.scrollTo(target, anchor: .top)
                                }
                            }
                        }
                        .onChange(of: searchText) { newValue in
                            if searchText.isEmpty {
                                searchResults = []
                            } else {
                                searchResults = document.captions.cues.filter { $0.text.lowercased().contains(searchText.lowercased())}
                            }
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
                        scrollTarget = document.captions.getCueBeforeTime(time: document.player.currentTime()).identifier
                    } label: {
                        Image(systemName: "arrow.forward.to.line")
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
