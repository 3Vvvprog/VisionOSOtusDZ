//
//  ImmersiveView.swift
//  VisionOSOtusDZ
//
//  Created by Вячеслав Вовк on 13.02.2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    @State private var model = Entity()
    @State private var isDropTargeted = false
    
    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                model = immersiveContentEntity
                model.components.set(InputTargetComponent(allowedInputTypes: .indirect))
                model.generateCollisionShapes(recursive: true)
                content.add(model)

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }
        }
        .gesture(
            DragGesture()
                .targetedToEntity(model)
                .onChanged({ value in
                    model.position = value.convert(value.location3D, from: .local, to: model.parent!)
                })
            
        )
        
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
