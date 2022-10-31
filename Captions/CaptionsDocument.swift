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
    var text: String
    var captions: Captions = Captions(fromText: "")

    init(text: String = "Hello, world!") {
        self.text = text        
    }

    static var readableContentTypes: [UTType] { [.webVTTDocument] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
        captions = Captions(fromText: string)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
