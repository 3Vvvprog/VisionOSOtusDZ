//
//  VisionOSOtusDZApp.swift
//  VisionOSOtusDZ
//
//  Created by Вячеслав Вовк on 13.02.2025.
//

import SwiftUI

@main
struct VisionOSOtusDZApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            PrimaryWindow()
                .environment(appModel)
        }
        
        WindowGroup(id: "Second") {
            SecondWindow()
                .environment(appModel)
        }

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
     }
}
