//
//  ContentView.swift
//  Captions
//
//  Created by Saunders, Alec on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: CaptionsDocument
    @Binding var capText: String

    var body: some View {
        VStack {
            TextEditor(text: $capText)
            Button("OK") {
                getSubContents()
            }
        }
    }
    
    func getSubContents() -> Void {
        let fileUrl = Bundle.main.url(forResource: "subtitle", withExtension: "srt")
        do {
            let contents = try String(contentsOf: fileUrl!)
            self.capText = contents
        } catch {
            print("Error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var capText = ""
    
    static var previews: some View {
        ContentView(document: .constant(CaptionsDocument()), capText: $capText)
    }
}
