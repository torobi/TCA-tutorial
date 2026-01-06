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
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            CounterView(store: TCA_tutorial_chapter_1App.store)
        }
    }
}
