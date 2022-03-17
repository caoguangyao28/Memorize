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
  // 这是个计算属性
  private var indexOfTheOneAndOnlyFaceUpCard: Int? {
    // 利用计算属性 完成 计算
    get { // 访问变量时 触发
//      var faceUpCardIndices = [Int]()
//      for index in cards.indices {
//        if cards[index].isFaceUp {
//          faceUpCardIndices.append(index)
//        }
//      }
      // 进一步优化
      let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp }) // index in cards[index].isFaceUp
      
//      if faceUpCardIndices.count == 1 {
//        return faceUpCardIndices.first
//      } else {
//        return nil
//      }
      
      // 拓展一个Array 属性-计算属性：判断数组长度 返回值
      return faceUpCardIndices.oneAndOnly
      // 还可以简化为链式调用 且单行时还可以省略 return
      // return faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
    }
    set { // 外部进行变量赋值 时触发
//      for index in cards.indices {
//        if index != newValue {
//          cards[index].isFaceUp = false
//        } else {
//          cards[index].isFaceUp = true
//        }
//      }
      // 简化为
      cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue) })
    }
  }
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
//        indexOfTheOneAndOnlyFaceUpCard = nil
        cards[chooseIndex].isFaceUp = true
        
      } else {
//        for index in 0..<cards.count { 提炼到计算属性 里了
//          cards[index].isFaceUp = false
//        }
        indexOfTheOneAndOnlyFaceUpCard = chooseIndex
      }
//      cards[chooseIndex].isFaceUp.toggle()
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
  
  mutating func shuffle() {
    // 打乱卡片顺序
    cards.shuffle()
  }
  
  struct Card: Identifiable {
    var isFaceUp = false
    var isMatched = false
    let content: CardContent // 来自 MemoryGame 的 CardContent 同样由外部初始化时传入决定
    let id: Int
  }
}

// 给Array 拓展一个属性
extension Array {
  var oneAndOnly: Element? {
    if count == 1 {
      return first
    } else {
      return nil
    }
  }
}
