//
//  Pie.swift
//  Memorize
//  自定义图形 拓展 协议 shape
//  Created by 曹光耀 on 2022/3/9.
//

import SwiftUI

struct Pie: Shape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool = false
  
  var animatableData: AnimatablePair<Double, Double> {
    get {
      AnimatablePair(startAngle.radians, endAngle.radians)
    }
    set {
      startAngle = Angle.radians(newValue.first)
      endAngle = Angle.radians(newValue.second)
    }
  }
  
  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let start = CGPoint(
      x: center.x + radius * cos(startAngle.radians),
      y: center.y + radius * sin(startAngle.radians)
    )
    
    var p = Path()
    p.move(to: center)
    p.addLine(to: start)
    // clockwise 需要取反 ，程序中的坐标系 与 真实的物理坐标系 是不一致的
    p.addArc(
      center: center,
      radius: radius,
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: !clockwise
    )
    p.addLine(to: center)
    
    return p
  }
  
  
}
