//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/5.
//

import SwiftUI

@main
struct MemorizeApp: App {
  let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModle: game)
        }
    }
}
