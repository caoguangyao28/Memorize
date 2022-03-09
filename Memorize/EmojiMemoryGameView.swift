//
//  EmojiMemoryGameView.swift
//  Memorize
//  视图修改- 所有卡片在 首屏展示 不出现滚动， 卡片大小动态计算 以保证 屏幕放得下
//  Created by 曹光耀 on 2022/3/5.
//

import SwiftUI

struct EmojiMemoryGameView: View {
 // ObservedObject 观察订阅
  @ObservedObject var game: EmojiMemoryGame
//  一但 viewModle 变化 则会更新 body
  var body: some View {

    AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
      // 如果在这里进行一些 非view 的操作
      if card.isMatched && !card.isFaceUp {
        Rectangle().opacity(0.6) // 条件满足时将导致 闭包没有返回 view  ，不符合 view 内容的推断要求 需要 AspectVGrid 处 使用到 @ViewBuilder
      } else {
        CardView(card: card)
          .padding(4) // 因为容器的 间距被设置为了 0 这里添加卡片 padding 起到间隔
          .onTapGesture {
            game.choose(card)
          }
      }
    }
    .foregroundColor(.red)
    .padding(.horizontal)
  }
  
  
}

// 视图拆分  swiftui 组件化基础 - 可以拆分单独的文件
struct CardView: View {
//  EmojiMemoryGame.Card 是 MemoryGame<String>.Card 别名的使用
  let card: EmojiMemoryGame.Card
  
  var body: some View {
    
    GeometryReader { geometry in
      // 容器大小 定制 内容
      ZStack {
        let shape = RoundedRectangle(cornerRadius: DrawingConstans.cornerRadius)
        if card.isFaceUp {
          shape.fill().foregroundColor(.white)
          shape.strokeBorder(lineWidth: DrawingConstans.lineWidth)
          // shape circle
//          Circle().padding(5).opacity(0.5)
          Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110 - 90)).padding(5).opacity(0.5)
          Text(card.content).font(font(in: geometry.size))
        } else if card.isMatched {
          shape.opacity(0)
        } else {
          shape.fill()
        }
      }
    }
    
  }
 //  用于根据容器 大小计算 文本图案大小
  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstans.fontScale)
  }
  // 将响应式的一些比例值 定义为 struct 常量
  private struct DrawingConstans {
    static let cornerRadius:CGFloat = 10
    static let lineWidth:CGFloat = 3
    static let fontScale:CGFloat = 0.65
  }
}


































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = EmojiMemoryGame()
      game.choose(game.cards.first!)
      return EmojiMemoryGameView(game: game)//.preferredColorScheme(.dark)
//      EmojiMemoryGameView(viewModle: game).preferredColorScheme(.light)
    }
}
