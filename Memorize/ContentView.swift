//
//  ContentView.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/5.
//

import SwiftUI

struct ContentView: View {
 // ObservedObject 观察订阅
  @ObservedObject var viewModle: EmojiMemoryGame
//  一但 viewModle 变化 则会更新 body
  var body: some View {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
  //        HStack {
            // 循环 需要 id 标识 这里将字符串本身作为唯一标识 最后一个 参数是函数-闭包 可以简写
          ForEach(viewModle.cards) { card in
            CardView(card: card)
              .aspectRatio(2/3, contentMode: .fit)
              .onTapGesture {
                viewModle.choose(card)
              }
            }
  //        }
        }
        
      }
      .foregroundColor(.red)
      .padding(.horizontal)
  }
  
  
}

// 视图拆分  swiftui 组件化基础
struct CardView: View {
  let card: MemoryGame<String>.Card
  
  var body: some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      if card.isFaceUp {
        shape.fill().foregroundColor(.white)
//        shape.stroke(lineWidth: 3)
        shape.strokeBorder(lineWidth: 3)
        Text(card.content).font(.largeTitle)
      } else if card.isMatched {
        shape.opacity(0)
      } else {
        shape.fill()
      }
    }
//    .onTapGesture { // view 加事件
//      card.isFaceUp = !card.isFaceUp
//    }
  }
}


































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let game = EmojiMemoryGame()
      ContentView(viewModle: game).preferredColorScheme(.dark)
      ContentView(viewModle: game).preferredColorScheme(.light)
    }
}
