//
//  CoreExtensions.swift
//  Captions
//
//  Created by Saunders, Alec on 11/1/22.
//


import CoreGraphics

extension CGKeyCode
{
    static let kVK_Option: CGKeyCode = 0x3A
    static let kVK_RightOption: CGKeyCode = 0x3D
    
    var isPressed: Bool {
        CGEventSource.keyState(.combinedSessionState, key: self)
    }
    
    static var optionKeyPressed: Bool {
        return Self.kVK_Option.isPressed || Self.kVK_RightOption.isPressed
    }
}
