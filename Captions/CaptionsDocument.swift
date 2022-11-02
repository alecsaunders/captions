//
//  CaptionsDocument.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI
import UniformTypeIdentifiers
import AVKit

extension UTType {
    static var webVTTDocument: UTType {
        UTType(importedAs: "com.example.webvtt")
    }
}

struct CaptionsDocument: FileDocument {
    var subtitleUrl = URL(string: "/")
    var captions: Captions = Captions(fromText: "")
    var playerUrl: URL?
    var player: AVPlayer = AVPlayer()

    init() {
    }

    static var readableContentTypes: [UTType] { [.webVTTDocument] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        captions = Captions(fromText: string)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let textContents = String(captions)
        let data = textContents.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
    
    mutating func loadSavedFileContents(contents: String) {
        self.captions = Captions(fromText: contents)
    }
    
    mutating func loadPlayer(subsUrl: URL) {
        guard let videoUrl = self.playerUrl else { return }
        
        let mixComposition = AVMutableComposition()
        
        // 1 - Video Track
        let videoAsset = AVURLAsset(url: videoUrl)
        let videoTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            try videoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration), of: videoAsset.tracks(withMediaType: .video)[0], at: .zero)
        } catch {
            print(error)
        }
        
        // 2 - Audio track
        let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            try audioTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration), of: videoAsset.tracks(withMediaType: .audio)[0], at: .zero)
        } catch {
            print(error)
        }

        // 3 - Subtitle track
        let subtitleAsset = AVURLAsset(url: subsUrl)
        let subtitleTrack = mixComposition.addMutableTrack(withMediaType: .text, preferredTrackID: kCMPersistentTrackID_Invalid)
        do {
            try subtitleTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration), of: subtitleAsset.tracks(withMediaType: .text)[0], at: .zero)
        } catch {
            print(error)
        }
        
        // 4 - Set up player
        let playerItem = AVPlayerItem(asset: mixComposition)
        
        player = AVPlayer(playerItem: playerItem)
    }
}
