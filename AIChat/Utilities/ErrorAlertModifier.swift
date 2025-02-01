//
//  CustomAlertModifier.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

struct ErrorAlertModifier<T: View>: ViewModifier {
    @Binding var error: AnyAlertError?
    @ViewBuilder var actions: () -> T
    
    func body(content: Content) -> some View {
        content
            .alert(
                error?.title ?? "",
                isPresented: .init(isNotNil: $error),
                presenting: error,
                actions: { _ in
                    actions()
                },
                message: { error in
                    Text(error.message)
                }
            )
    }
}

extension View {
    func errorAlert<T: View>(
        _ error: Binding<AnyAlertError?>,
    @ViewBuilder actions: @escaping () -> T = { EmptyView() }
    ) -> some View {
        self.modifier(
            ErrorAlertModifier(
                error: error,
                actions: {
                    Button("Cancel", role: .cancel, action: {})
                    actions()
                }
            )
        )
    }
}

fileprivate struct Preview: View {
    @State var error: AnyAlertError?
    
    var body: some View {
        VStack {
            Text("Show alert")
                .onTapGesture {
                    error = SendMessageError.containsProfanity
                }
        }
        .errorAlert($error)
    }
}


#Preview {
    Preview()
}
