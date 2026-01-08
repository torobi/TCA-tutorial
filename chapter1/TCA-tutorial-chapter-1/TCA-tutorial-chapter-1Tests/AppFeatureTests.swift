//
//  AppFeatureTests.swift
//  TCA-tutorial-chapter-1Tests
//
//  Created by torobi on 2026/01/08.
//

import ComposableArchitecture
import Testing

@testable import TCA_tutorial_chapter_1

@MainActor
struct AppFeatureTests {
  @Test
  func incrementInFirstTab() async {
      let store = TestStore(initialState: AppFeature.State()) {
          AppFeature()
      }

      await store.send(\.tab1.incrementButtonTapped) {
          $0.tab1.count = 1
      }
  }
}
