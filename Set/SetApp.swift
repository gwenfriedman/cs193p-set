//
//  SetApp.swift
//  Set
//
//  Created by Gwen Friedman on 2/7/22.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
