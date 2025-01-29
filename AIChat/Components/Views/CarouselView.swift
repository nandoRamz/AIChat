//
//  CarouselView.swift
//  AIChat
//
//  Created by Nando on 1/29/25.
//

import SwiftUI

struct CarouselView<T: Hashable, Content: View>: View {
    var items: [T]
    @State private var selectedItem: T?
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                            .id(item)
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                    }
                    .scrollTransition(.interactive.threshold(.visible(0.8))) { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1 : 0.8)
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 200)
            .scrollClipDisabled(true)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selectedItem)
            
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Circle()
                        .fill(selectedItem == item ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(.quinary))
                        .frame(width: 8, height: 8)
                }
            }
            .animation(.linear, value: selectedItem)
        }
        .onAppear { updateSelection() }
    }
}



//MARK: - Methods
///Methods
extension CarouselView {
    private func updateSelection() {
        selectedItem = items.first
    }
}

#Preview {
    CarouselView( 
        items: AvatarModel.samples,
        content: { item in
            HeroCell(
                title: item.name,
                subTitle: item.characterDescription(),
                imageName: item.profileImageName
            )
        }
    )
    .padding(.horizontal)
}

/*
 struct CarouselView: View {
     var items: [AvatarModel] = AvatarModel.samples
     @State private var selectedAvatarModel: AvatarModel?
     
     var body: some View {
         VStack(spacing: 16) {
             ScrollView(.horizontal) {
                 LazyHStack(spacing: 16) {
                     ForEach(items, id: \.self) { item in
                         HeroCell(
                             title: item.name,
                             subTitle: item.characterDescription(),
                             imageName: item.profileImageName
                         )
                         .id(item)
                         .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                     }
                     .scrollTransition(.interactive.threshold(.visible(0.8))) { content, phase in
                         content
                             .scaleEffect(phase.isIdentity ? 1 : 0.8)
                     }
                 }
                 .scrollTargetLayout()
             }
             .frame(height: 200)
             .scrollClipDisabled(true)
             .scrollIndicators(.hidden)
             .scrollTargetBehavior(.viewAligned)
             .scrollPosition(id: $selectedAvatarModel)
             
             HStack(spacing: 8) {
                 ForEach(items, id: \.self) { item in
                     Circle()
                         .fill(selectedAvatarModel == item ? AnyShapeStyle(Color.accentColor) : AnyShapeStyle(.quinary))
                         .frame(width: 8, height: 8)
                 }
             }
             .animation(.linear, value: selectedAvatarModel)
         }
         .onAppear { updateSelection() }
     }
 }
 */
