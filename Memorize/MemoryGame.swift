//
//  MemoryGame.swift
//  Memorize
//  mvvm - molde
//  Created by 曹光耀 on 2022/3/5.
//

import Foundation
// where CardContent: Equatable 要求可以对比
struct MemoryGame<CardContent> where CardContent: Equatable {
//  私有但外部可以看到，外部不可以修改
  private(set) var cards: Array<Card>
  private var indexOfTheOneAndOnlyFaceUpCard: Int?
  // mutating 修饰 方法可以修改 struct 内变量
  mutating func choose(_ card: Card) {
    // struct 是值类型  swift 赋值 函数入参都是 拷贝 不存在引用
    // let chooseIndex = index(of: card) 直接用 Array api 替换 这个函数
    
    // Array.firstIndex -> optional , if let 可以对齐进行展开判断取值
    if let chooseIndex = cards.firstIndex(where: {$0.id == card.id}),
       !cards[chooseIndex].isFaceUp,
       !cards[chooseIndex].isMatched {
      if let potentialMacthIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chooseIndex].content == cards[potentialMacthIndex].content {
          cards[chooseIndex].isMatched = true
          cards[potentialMacthIndex].isMatched = true
        }
        indexOfTheOneAndOnlyFaceUpCard = nil
      } else {
        for index in 0..<cards.count {
          cards[index].isFaceUp = false
        }
        indexOfTheOneAndOnlyFaceUpCard = chooseIndex
      }
      cards[chooseIndex].isFaceUp.toggle()
    }
    
  }
  
 // 直接用 Array api 替换 这个函数
 //  Int? 返回值可选 将变成 optional 包裹
//  func index(of card: Card) -> Int? {
//    for index in 0..<cards.count {
//      if cards[index].id == card.id {
//        return index
//      }
//    }
//    return nil // bug 时
//  }
  
  //  自定义初始化，有这个自定义init 后 struct vars 默认的初始化将不执行
  // cardsContentFactory 闭包标签，由 vm 初始化 MemoryGame 时传入 由它决定 MemoryGame 的 CardContent
  init(numberOfPairsOfCards: Int, cardsContentFactory: (Int) -> CardContent) {
//    cards = Array<Card>() 简化
    cards = []
    for pairIndex in 0..<numberOfPairsOfCards {
      let content = cardsContentFactory(pairIndex)
      cards.append(Card(content: content, id: pairIndex * 2))
      cards.append(Card(content: content, id: pairIndex * 2 + 1))
    }
  }
  
  struct Card: Identifiable {
    var isFaceUp = false
    var isMatched = false
    let content: CardContent // 来自 MemoryGame 的 CardContent 同样由外部初始化时传入决定
    let id: Int
  }
}
