//
//  LaunchScreenStateManager.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/15/23.
//

import Foundation
final class LaunchScreenStateManager: ObservableObject {

@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(2))

            self.state = .finished
        }
    }
}
