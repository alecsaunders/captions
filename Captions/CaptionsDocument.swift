//
//  CaptionsDocument.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var webVTTDocument: UTType {
        UTType(importedAs: "com.example.webvtt")
    }
}

struct CaptionsDocument: FileDocument {
    var captions: Captions = Captions(fromText: "")

    init() {}

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
}
