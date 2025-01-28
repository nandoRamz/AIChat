//
//  AppState.swift
//  AIChat
//
//  Created by Nando on 1/28/25.
//

import Foundation
import Observation

@Observable
class AppState {
    private(set) var isSignedIn: Bool {
        didSet { UserDefaults.isSignedIn = isSignedIn }
    }
    
    init(isSignedIn: Bool = UserDefaults.isSignedIn) {
        self.isSignedIn = isSignedIn
    }
    
    func updateViewState(isSignedIn: Bool) {
        self.isSignedIn = isSignedIn
    }
}

extension UserDefaults {
    private struct Keys {
        static let isSignedIn = "isSignedIn"
    }
    
    static var isSignedIn: Bool {
        get { standard.bool(forKey: Keys.isSignedIn) }
        set { standard.set(newValue, forKey: Keys.isSignedIn) }
    }
}
