//
//  ListTitleView.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct ListTitleView: View {
    var text: String = "Some title"
    var body: some View {
        Text(text.uppercased())
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ListTitleView()
}
