//
//  ContactsFeatureTests.swift
//  TCA-tutorial-chapter-2Tests
//
//  Created by torobi on 2026/01/10.
//

import ComposableArchitecture
import Foundation
import Testing

@testable import TCA_tutorial_chapter_2

@MainActor
struct ContactsFeatureTests {
    @Test
    func addFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }

        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: .init(id: UUID(0), name: "")
                )
            )
        }
        await store.send(\.destination.addContact.setName, "Blob Jr.") {
            $0.destination?.modify(\.addContact) { $0.contact.name = "Blob Jr." }
        }
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.receive(
            \.destination.addContact.delegate.saveContact,
            Contact(id: UUID(0), name: "Blob Jr.")
        ) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
        }
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }

    @Test
    func addFlowNonExhaustive() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        store.exhaustivity = .off

        await store.send(\.addButtonTapped)
        await store.send(\.destination.addContact.setName, "Blob Jr.")
        await store.send(\.destination.addContact.saveButtonTapped)
        await store.skipReceivedActions()
        store.assert {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
            $0.destination = nil
        }
    }

    @Test
    func deleteContact() async {
        let store = TestStore(initialState: ContactsFeature.State(contacts: [
            .init(id: .init(0), name: "Blob"),
            .init(id: .init(1), name: "Blob Jr.")
        ])) {
            ContactsFeature()
        }

        await store.send(.deleteButtonTapped(id: .init(1))) {
            $0.destination = .alert(.deleteConfirmation(id: .init(1)))
        }
        await store.send(\.destination.alert.confirmDeletion, .init(1)) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob")
            ]
            $0.destination = nil
        }
    }
}
