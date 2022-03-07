//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/5.
//

import SwiftUI

struct EmojiMemoryGameView: View {
 // ObservedObject 观察订阅
  @ObservedObject var game: EmojiMemoryGame
//  一但 viewModle 变化 则会更新 body
  var body: some View {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
          ForEach(game.cards) { card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                game.choose(card)
              }
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
    static let cornerRadius:CGFloat = 20
    static let lineWidth:CGFloat = 3
    static let fontScale:CGFloat = 0.8
  }
}


































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = EmojiMemoryGame()
      EmojiMemoryGameView(game: game)//.preferredColorScheme(.dark)
//      EmojiMemoryGameView(viewModle: game).preferredColorScheme(.light)
    }
}
