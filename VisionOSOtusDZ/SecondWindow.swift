    //
//  SecondWindow.swift
//  VisionOSOtusDZ
//
//  Created by Вячеслав Вовк on 13.02.2025.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SecondWindow: View {
    @State private var models: [Entity] = []
    var body: some View {
        
        VStack {
            // Кнопка для добавления объектов
            Button(action: {
                Task {
                    await addDefaultModel()
                }
            }) {
                Text("Add Default Model")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            // Пространство для отображения моделей
                if models.isEmpty {
                    Text("No models added yet.")
                        .padding()
                } else {
                    ForEach(models.indices, id: \.self) { index in
                        Model3D(named: "Scene", bundle: realityKitContentBundle)
                            .frame(height: 200)
                            .padding()
                    }
                }

            ToggleImmersiveSpaceButton()
            
        }
        .padding()
        .dropDestination(for: URL.self) { items, _ in
            guard let item = items.first,
                  item.startAccessingSecurityScopedResource(),
                  let model = try? Entity.loadModel(named: item.path) else {
                return false
            }
            models.append(model)
            return true
        }
    }
    // Добавление стандартной модели
    private func addDefaultModel() async {
        if let model = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
            models.append(model)
        }
    }
}

#Preview(windowStyle: .automatic) {
    SecondWindow()
        .environment(AppModel())
}
