//
//  ForkTestApp.swift
//  ForkTest
//
//  Created by KyoungJin Baek on 1/17/25.
//

import SwiftData
import SwiftUI

@main
struct ForkTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self)
    }
}
