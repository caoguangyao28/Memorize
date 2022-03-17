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
    VStack {
      gameBody
      shuffle
    }
    .padding()
  }
  
  var gameBody: some View {
    AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
      // 如果在这里进行一些 非view 的操作
      if card.isMatched && !card.isFaceUp {
        
//        Rectangle().opacity(0.6) // 条件满足时将导致 闭包没有返回 view  ，不符合 view 内容的推断要求 需要 AspectVGrid 处 使用到 @ViewBuilder
        // 另一种好的 处理方法-- 清楚所有颜色 而不是矩形填充 原内容被 丢弃
        Color.clear // 颜色作为一种视图
      } else {
        CardView(card: card)
          .padding(4) // 因为容器的 间距被设置为了 0 这里添加卡片 padding 起到间隔
          .onTapGesture {
            withAnimation(.easeInOut(duration: 3)){
              game.choose(card)
            }
          }
      }
    }
    .foregroundColor(.red)
  }
  
  var shuffle: some View {
    Button("shuffle") {
      // 显式动画
      withAnimation(.easeInOut(duration: 1)) {
        game.shuffle()
      }
    }
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
        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110 - 90))
          .padding(5)
          .opacity(0.5)
        Text(card.content)
          .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
          .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
          .font(Font.system(size: DrawingConstans.fontSize))
          .scaleEffect(scale(thatFits: geometry.size))// 调整到合适大小 且动画效果在屏幕翻转时不会异常
      }
//      .modifier(Cardify(isFaceUp: card.isFaceUp)) // 把整个 ZStack 所有内容  传给 修改器 作为 content 类似于vue的 slot
//      拓展 view 一个 cardify 方法后 简写 如下
      .cardify(isFaceUp: card.isFaceUp)
    }
    
  }
  private func scale(thatFits size: CGSize) -> CGFloat {
    min(size.width, size.height) / (DrawingConstans.fontSize / DrawingConstans.fontScale)
  }
 //  用于根据容器 大小计算 文本图案大小
  private func font(in size: CGSize) -> Font {
    Font.system(size: min(size.width, size.height) * DrawingConstans.fontScale)
  }
  // 将响应式的一些比例值 定义为 struct 常量

  private struct DrawingConstans {
    static let fontScale:CGFloat = 0.65
    static let fontSize:CGFloat = 32
    
  }
}


































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = EmojiMemoryGame()
      game.choose(game.cards.first!)
      return EmojiMemoryGameView(game: game)
.previewInterfaceOrientation(.portrait)//.preferredColorScheme(.dark)
//      EmojiMemoryGameView(viewModle: game).preferredColorScheme(.light)
    }
}
