//
//  TCA_tutorial_chapter_1App.swift
//  TCA-tutorial-chapter-1
//
//  Created by torobi on 2026/01/06.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_tutorial_chapter_1App: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    var body: some Scene {
        WindowGroup {
            AppView(store: TCA_tutorial_chapter_1App.store)
        }
    }
}
