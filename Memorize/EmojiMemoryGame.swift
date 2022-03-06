//
//  EmojiMemoryGame.swift
//  Memorize
//  mvvm - vm 属于ui一部分
//  Created by 曹光耀 on 2022/3/5.
//  class
//

import SwiftUI

// 单独命名函数 作为参数
//func cardsContent(pairIndex: Int) -> String {
//  return "😀"
//}
// ObservableObject 发布为 可观察、订阅对象, 发生变动时会获取一个 ···publisher 对象
class EmojiMemoryGame: ObservableObject {
  static let emojis = ["🚗", "🚕", "🚙", "🏎", "🚌", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🏍", "🚲", "🚨", "🚔", "🚍", "🚘", "🚖", "🚠", "🚋", "🚄", "🚈", "🚂"]
  
  static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
      emojis[pairIndex]
    }
  }
  
//  private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardsContentFactory: cardsContent)
  
//  简略写法 - 闭包
//  private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardsContentFactory: { (pairIndex: Int) -> String in
//    return "😀"
//  })
  
//  进一步简写
// @Published 推送变化的信息
  @Published private var model: MemoryGame<String> = createMemoryGame()
  
  var cards: Array<MemoryGame<String>.Card> {
    model.cards
  }
  
  // MARK: intent(s)
  
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
}
