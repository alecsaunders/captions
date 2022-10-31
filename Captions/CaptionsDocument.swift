//
//  CaptionsDocument.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}

struct CaptionsDocument: FileDocument {
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
        let fileUrl = Bundle.main.url(forResource: "subtitle", withExtension: "srt")
        do {
            let contents = try String(contentsOf: fileUrl!)
            self.text = contents
        } catch {
            print("Error")
        }
        
    }

    static var readableContentTypes: [UTType] { [.exampleText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
