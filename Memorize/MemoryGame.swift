//
//  MemoryGame.swift
//  Memorize
//  mvvm - molde
//  Created by 曹光耀 on 2022/3/5.
//

import Foundation

struct MemoryGame<CardContent> {
  var cards: Array<Card>
  
  mutating func choose(_ card: Card) {
    // swift 赋值 函数入参都是 拷贝 不存在引用
    let chooseIndex = index(of: card)
    cards[chooseIndex].isFaceUp.toggle()
    
    print(" cards choose \(card.isFaceUp)")
  }
  
  func index(of card: Card) -> Int {
    for index in 0..<cards.count {
      if cards[index].id == card.id {
        return index
      }
    }
    return 0 // bug 时
  }
  
  init(numberOfPairsOfCards: Int, cardsContentFactory: (Int) -> CardContent) {
    cards = Array<Card>()
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = cardsContentFactory(pairIndex)
      cards.append(Card(content: content, id: pairIndex * 2))
      cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
  }
  
  struct Card: Identifiable {
    var isFaceUp: Bool = true
    var isMatched: Bool = false
    var content: CardContent // 泛型使用
    var id: Int
  }
}
