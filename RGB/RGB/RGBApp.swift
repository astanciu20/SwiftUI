//
//  RGBApp.swift
//  RGB
//
//  Created by Andrei Stanciu on 23.06.2023.
//

import SwiftUI

@main
struct RGBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(guess: RGB())
        }
    }
}
