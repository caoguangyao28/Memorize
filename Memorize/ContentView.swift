//
//  ContentView.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/5.
//

import SwiftUI

struct ContentView: View {
  var emojis = ["🚗", "🚕", "🚙", "🏎", "🚌", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🏍", "🚲", "🚨", "🚔", "🚍", "🚘", "🚖", "🚠", "🚋", "🚄", "🚈", "🚂"]
  @State var emojiCount = 20
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
  //        HStack {
            // 循环 需要 id 标识 这里将字符串本身作为唯一标识 最后一个 参数是函数-闭包 可以简写
            ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
              CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
            }
  //        }
        }
        
      }
      .foregroundColor(.red)
      Spacer()// 会竟可能的占有 上方 下方 空间
      HStack {
        remove
        Spacer()
        add
      }
      .font(.largeTitle)
      .padding(.horizontal)
    }
    .padding(.horizontal)
    
    
  }
  
  var remove: some View {
    Button(action: {
      emojiCount -= 1
    }, label: {
      Image(systemName: "minus.circle")
    })
  }
  
  // 视图分割 -- 组件化？
  var add: some View {
    Button(action: { // button 的事件
      emojiCount += 1
    }) {
      Image(systemName: "plus.circle") // 系统图标
    }
  }
}

// 视图拆分  swiftui 组件化基础
struct CardView: View {
  var content: String
  @State var isFaceUp: Bool = true
  
  var body: some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: 20)
      if isFaceUp {
        shape.fill().foregroundColor(.white)
//        shape.stroke(lineWidth: 3)
        shape.strokeBorder(lineWidth: 3)
        Text(content).font(.largeTitle)
      } else {
        shape.fill()
      }
    }
    .onTapGesture { // view 加事件
      isFaceUp = !isFaceUp
    }
  }
}


































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
