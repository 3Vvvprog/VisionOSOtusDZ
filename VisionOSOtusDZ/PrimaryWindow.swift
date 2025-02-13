//
//  ContentView.swift
//  VisionOSOtusDZ
//
//  Created by Вячеслав Вовк on 13.02.2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PrimaryWindow: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var model = Model3D(named: "Scene", bundle: realityKitContentBundle)
    var body: some View {
        VStack {
            model
                .padding(.bottom, 50)
//                .draggable(model) {
//                    Label("Figure playing golf")
//                }

            Text("Hello, world!")

            ToggleImmersiveSpaceButton()
            
            Button {
                openWindow(id: "Second")
            } label: {
                Text("Show Second Window")
                   .font(.headline)
                   .padding()
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(10)
            }.buttonStyle(.plain)

        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    PrimaryWindow()
        .environment(AppModel())
}
