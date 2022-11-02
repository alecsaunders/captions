//
//  TimestampFormat.swift
//  Captions
//
//  Created by Saunders, Alec on 11/1/22.
//

import SwiftUI

struct TimestampStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
            .font(Font.system(.body, design: .monospaced))
        }
}


extension View {
    func timestampStyle() -> some View {
        modifier(TimestampStyle())
    }
}
