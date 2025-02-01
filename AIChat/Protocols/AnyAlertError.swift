//
//  AnyAlertError.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import Foundation

protocol AnyAlertError: Error {
    var message: String { get }
    var title: String { get }
}
