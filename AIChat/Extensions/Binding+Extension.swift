//
//  Binding+Extension.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T:Sendable>(isNotNil value: Binding<T?>) {
        self.init(
            get: { value.wrappedValue != nil },
            set: { newValue in
                if !newValue { value.wrappedValue = nil }
            }
        )
    }
}
