//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by ONE on 4/19/26.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
