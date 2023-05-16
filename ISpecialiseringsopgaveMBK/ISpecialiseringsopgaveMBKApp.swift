//
//  ISpecialiseringsopgaveMBKApp.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 15/05/2023.
//

import SwiftUI

@main
struct ISpecialiseringsopgaveMBKApp: App {
    @StateObject var stateController = StateController()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateController)
        }
    }
}
