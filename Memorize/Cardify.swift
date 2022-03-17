//
//  Cardify.swift
//  Memorize
//
//  Created by 曹光耀 on 2022/3/11.
//
// AnimatableModifier 具备 Animatable, ViewModifier 两个协议
import SwiftUI

struct Cardify:AnimatableModifier {
  
  
  var rotation:Double // in degress
  
  // 通过初始化函数 isFaceUp 与 rotation 关联
  init(isFaceUp:Bool) {
    rotation = isFaceUp ? 0 : 180
  }
  
  //  计算属性 根据 rotation 的变化 动画属性进行相应的动画
  var animatableData:Double {
    get {
      rotation
    }
    set {
      rotation = newValue
    }
  }
  
  
  func body(content: Content) -> some View {
    ZStack {
      let shape = RoundedRectangle(cornerRadius: DrawingConstans.cornerRadius)
      if rotation < 90 {
        shape.fill().foregroundColor(.white)
        shape.strokeBorder(lineWidth: DrawingConstans.lineWidth)
//        content // 内容放这里 会有问题，隐式动画只能 为已经存在 于屏幕上的 viewmodifer 的视图添加动画
      } else {
        shape.fill()
      }
//      无论是否 是 faceUp 文本内容都添加到 屏幕上
      // 但需要 isFaceUp 为false 时 看不到 content
      content.opacity(rotation < 90 ? 1 : 0)
    }
    .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    
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
