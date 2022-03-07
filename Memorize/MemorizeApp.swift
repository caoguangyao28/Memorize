//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/5.
//

import SwiftUI

@main
struct MemorizeApp: App {
  //  实例游戏的 vm 交给 view
  private let game = EmojiMemoryGame()
  var body: some Scene {
      WindowGroup {
          EmojiMemoryGameView(game: game)
      }
  }
}
