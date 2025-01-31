//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

struct CreateAvatarView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var character: CharacterOption = .woman
    @State private var characterAction: CharacterAction = .sitting
    @State private var characterLocation: CharacterLocation = .park
    @State private var isGeneratingImage: Bool = false
    @State private var generatedImage: UIImage?
    @State private var isSaving: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                nameSection
                
                characterSection
                
                imageSection
                
                actionsSection
            }
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .navigationTitle("Create Avatar")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { onDismissPress() }) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                }
            }
        }
        
    }
}

//MARK: - Views
///Views
extension CreateAvatarView {
    private var actionsSection: some View {
        Button(action: { onSavePress() }) {
            Text("Save")
                .mainButtonStyle(isPerformingTask: isSaving)
                
                .padding(.horizontal)
        }
        .disabled(generatedImage == nil)
    }
    
    private var imageSection: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(.quinary)
                .frame(width: 200, height: 200)
                .overlay {
                    if let _ = generatedImage {
                        Image(.appIconInternal)
                            .resizable()
                            .scaledToFill()
                        
                    }
                }
                .clipShape(.circle)
                
            
            Button(action: { onGenerateImagePress() }) {
                Group {
                    if isGeneratingImage { ProgressView().tint(.accent) }
                    else {
                        Text("Genernate Image")
                    }
                }
                .frame(height: 28)
            }
            .disabled(name.isEmpty)
        }
    }
    
    private var characterSection: some View {
        VStack(spacing: 0) {
            customPicker(
                title: "Character",
                selectedItem: $character,
                items: CharacterOption.allCases
            )
            .padding(.vertical, 11)
            .background(
                Divider()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.horizontal, -16)
            )
            customPicker(
                title: "Action",
                selectedItem: $characterAction,
                items: CharacterAction.allCases
            )
            .padding(.vertical, 11)
            .background(
                Divider()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.horizontal, -16)
            )
            
            customPicker(
                title: "Location",
                selectedItem: $characterLocation,
                items: CharacterLocation.allCases
            )
            .padding(.vertical, 11)
            
        }
        .padding(.horizontal)
        .background()
        .clipShape(.rect(cornerRadius: 15))
        .padding(.horizontal)
    }
    
    private var nameSection: some View {
        TextField("Name your avatar", text: $name)
            .padding(.vertical, 11)
            .padding(.horizontal)
            .background()
            .clipShape(.rect(cornerRadius: 15))
            .padding(.horizontal)
    }
    
    private func customPicker<T: Hashable & RawRepresentable>(
        title: String,
        selectedItem: Binding<T>,
        items: [T]
    ) -> some View where T.RawValue == String {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("", selection: selectedItem) {
                ForEach(items, id: \.self) { item in
                    Text(item.rawValue)
                        
                }
            }
            .tint(.secondary)
        }
    }
}

//MARK: - Actions
///Actions
extension CreateAvatarView {
    @MainActor
    private func onDismissPress() {
        if isSaving { return }
        dismiss()
    }
    
    private func onGenerateImagePress() {
        if isGeneratingImage { return }
        isGeneratingImage.toggle()
        
        Task {
            try? await Task.sleep(for: .seconds(3))
            generatedImage = UIImage(systemName: "heart")
            isGeneratingImage.toggle()
        }
    }
    
    private func onSavePress() {
        if isSaving { return }
        isSaving.toggle()
        
        Task {
            try? await Task.sleep(for: .seconds(5))
            isSaving.toggle()
            await onDismissPress()
        }
    }
}

//MARK: - Methods
///Methods
extension CreateAvatarView {
    private func isFormValid() -> Bool {
        return !name.isEmpty && generatedImage != nil
    }
}

#Preview {
    NavigationStack {
//        CreateAvatarView()
        ProfileView()
    }
}

/*
 ///Would perfer the user to be able to add a description instead of preselecting values
 @State private var description: String = ""

 
 VStack(spacing: 0) {
     TextField("Description", text: $description, axis: .vertical)
         .padding(.vertical, 11)
         .frame(maxHeight: 250)
 }
 .padding(.horizontal)
 .background()
 .clipShape(.rect(cornerRadius: 15))
 */
