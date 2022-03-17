//
//  Cardify.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/11.
//
import SwiftUI

struct Cardify:ViewModifier {
  var isFaceUp:Bool
  func body(content: Content) -> some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: DrawingConstans.cornerRadius)
      if isFaceUp {
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: DrawingConstans.lineWidth)
//        content // 内容放这里 会有问题，隐式动画只能 为已经存在 于屏幕上的 viewmodifer 的视图添加动画
      } else {
        shape.fill()
      }
//      无论是否 是 faceUp 文本内容都添加到 屏幕上
      // 但需要 isFaceUp 为false 时 看不到 content
      content.opacity(isFaceUp ? 1 : 0)
    }
    .rotation3DEffect(Angle.degrees(isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
    
  }
  
  private struct DrawingConstans {
    static let cornerRadius:CGFloat = 10
    static let lineWidth:CGFloat = 3
  }
  
}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}
