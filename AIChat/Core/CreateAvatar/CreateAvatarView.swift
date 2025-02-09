//
//  CreateAvatarView.swift
//  AIChat
//
//  Created by Nando on 1/31/25.
//

import SwiftUI

struct CreateAvatarView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AIImageGeneratorManager.self) private var aiImageGeneratorManager
    @Environment(AvatarManager.self) private var avatarManager
    @Environment(AuthManager.self) private var authManager
    
    @State private var name: String = ""
    @State private var character: CharacterOption = .woman
    @State private var characterAction: CharacterAction = .sitting
    @State private var characterLocation: CharacterLocation = .park
    @State private var isGeneratingImage: Bool = false
    @State private var generatedImage: UIImage?
    @State private var isSaving: Bool = false
    @State private var isPrivate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                nameSection
                
                characterSection
                
                privacySection
                
                imageSection
                
                actionsSection
            }
        }
        //TODO: Remove
        .onAppear { generatedImage = UIImage(resource: .generatedAvatar) }
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
    private var privacySection: some View {
        Toggle("Private", isOn: $isPrivate)
            .padding(.vertical, 11)
            .padding(.horizontal)
            .background()
            .clipShape(.rect(cornerRadius: 15))
            .padding(.horizontal)
    }
    
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
                    if let generatedImage {
                        Image(uiImage: generatedImage)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .clipShape(.circle)
                .animation(.easeInOut, value: generatedImage)
                
            
            Button(action: { onGenerateImagePress() }) {
                Group {
                    if isGeneratingImage { ProgressView().tint(.accent) }
                    else {
                        Text(generatedImage == nil ? "Genernate Image" : "Regenerate Image")
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
        generatedImage = nil
        
        Task {
            generatedImage = try await aiImageGeneratorManager.generateImage(from: "empty prompt")
            isGeneratingImage.toggle()
        }
    }
    
    private func onSavePress() {
        if isSaving { return }
        isSaving.toggle()
        
        Task { @MainActor in
            do {
                let newAvatar = AvatarModel(
                    id: UUID().uuidString,
                    name: name,
                    characterOption: character,
                    characterAction: characterAction,
                    characterLocation: characterLocation,
                    imageUrl: nil,
                    createdBy: try authManager.getId(),
                    timestamp: .now,
                    isPrivate: isPrivate
                )
                
                guard let generatedImage else { return }
                try await avatarManager.save(
                    newAvatar,
                    withImage: generatedImage
                )
                print("Successfully added avatar!")
            }
            catch {
                print("Error saving avatar: \(error)")
            }
            
            isSaving.toggle()
            dismiss()
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
        CreateAvatarView()
            .environment(AuthManager(service: MockAuthService(user: .sample())))
            .environment(UserManager(service: MockUserService()))
            .environment(AIImageGeneratorManager(service: MockAIImageGeneratorService()))
    }
}
