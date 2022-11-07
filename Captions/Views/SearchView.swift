//
//  SearchView.swift
//  Captions
//
//  Created by Saunders, Alec on 11/6/22.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchResults: [Cue]
    @Binding var scrollTarget: Int?
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach($searchResults) { $searchCue in
                    VStack {
                        HStack {
                            Text("\(String(searchCue.timings.startTime))")
                                .font(Font.system(size: 12, design: .monospaced))
                                .fontWeight(.light)
                        }
                        HStack {
                            Text(searchCue.text)
                            Spacer()
                        }
                            .padding(5)
                        Divider()
                    }
                    .onTapGesture {
                        print("Scroll to \(searchCue.identifier)")
                        scrollTarget = searchCue.identifier
                    }
                }
            }
        }
            .frame(height: 200)
    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var searchResults = [
        Cue(identifier: 1, timings: Timings(timingsLine: "00:00.000 --> 00:01.000"), settings: "", text: "Line 1"),
        Cue(identifier: 2, timings: Timings(timingsLine: "00:02.000 --> 00:03.000"), settings: "", text: "Line 2 asdfas"),
        Cue(identifier: 3, timings: Timings(timingsLine: "00:04.000 --> 00:05.000"), settings: "", text: "Line 3asdf"),
        Cue(identifier: 4, timings: Timings(timingsLine: "00:06.000 --> 00:07.000"), settings: "", text: "Line 4 asdfa asdfasdf asdf ")
    ]
    
    @State static var scrollTarget: Int? = 2
    
    static var previews: some View {
        SearchView(searchResults: $searchResults, scrollTarget: $scrollTarget)
    }
}
