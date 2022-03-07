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
  // 类型别名
  typealias Card = MemoryGame<String>.Card
  
  private static let emojis = ["🚗", "🚕", "🚙", "🏎", "🚌", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🏍", "🚲", "🚨", "🚔", "🚍", "🚘", "🚖", "🚠", "🚋", "🚄", "🚈", "🚂"]
  
  private static func createMemoryGame() -> MemoryGame<String> {
    MemoryGame<String>(numberOfPairsOfCards: 9) { pairIndex in
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
  @Published private var model = createMemoryGame()
  
  // MemoryGame<String>.Card 可以使用类型别名
  var cards: Array<Card> {
    model.cards
  }
  
  // MARK: intent(s)
  
  func choose(_ card: Card) {
    model.choose(card)
  }
}
