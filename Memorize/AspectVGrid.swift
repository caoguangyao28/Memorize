//
//  AspectVGrid.swift
//  Memorize
//  自定义 view 组合器 这是个 swiftui
//  Created by 曹光耀 on 2022/3/8.
//

import SwiftUI

struct AspectVGrid<Item,ItemView>: View where ItemView: View,Item: Identifiable {
  var items:[Item]
  var aspectRatio: CGFloat
  var content: (Item) -> ItemView
  
  // content 传过来的闭包如果不符合view 限定 需要告诉 swiftui 该函数 转换 viewbuilder
  // 同时需要自定义 struct 的init
  
  init(items:[Item], aspectRatio:CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) { // @escaping 防止闭包逃离 struct self
    self.items = items
    self.aspectRatio = aspectRatio
    self.content = content
  }
  
  var body: some View {
    GeometryReader { geometry in
      // geometry 拿到最外层容器 大小 计算合适的 卡片容器 grid 的 width
      VStack { // 确保占有整个容器到顶部
        let width:CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
        LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
          ForEach(items) { itme in
            // 交给传入闭包函数 生成 card content
            content(itme).aspectRatio(aspectRatio, contentMode: .fit)
            
          }
        }
        Spacer(minLength: 0)// 灵活占据垂直方向剩余空间
      }
    }

  }
  // 去除GridItem 的间隙 返回 GridItem
  private func adaptiveGridItem(width: CGFloat) -> GridItem {
    var gridItme = GridItem(.adaptive(minimum: width))
    gridItme.spacing = 0
    return gridItme
  }
  
//  这里计算时  没有考虑到 卡片之间的间隙  所以 上面 lazyVgrid spaceing 需要为0
  private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
    var columnCount = 1
    var rowCount = itemCount
    repeat {
      let itemWidth = size.width / CGFloat(columnCount)
      let itemHeight = itemWidth / itemAspectRatio
      if CGFloat(rowCount) * itemHeight < size.height {
        break
      }
      columnCount += 1
      // 这里需要搞明白一下 为啥 columnCount - 1  确保根据列数 得到的行数是对的
      rowCount = (itemCount + (columnCount - 1)) / columnCount
      
    } while columnCount < itemCount
    if columnCount > itemCount {
      columnCount = itemCount
    }
    
    return floor(size.width / CGFloat(columnCount))
  }
  
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
