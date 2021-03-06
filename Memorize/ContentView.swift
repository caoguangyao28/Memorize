//
//  ContentView.swift
//  Memorize
//
//  Created by ๆนๅ่ on 2022/3/5.
//

import SwiftUI

struct ContentView: View {
  var emojis = ["๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ฒ", "๐จ", "๐", "๐", "๐", "๐", "๐ ", "๐", "๐", "๐", "๐"]
  @State var emojiCount = 20
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
  //        HStack {
            // ๅพช็ฏ ้่ฆ id ๆ ่ฏ ่ฟ้ๅฐๅญ็ฌฆไธฒๆฌ่บซไฝไธบๅฏไธๆ ่ฏ ๆๅไธไธช ๅๆฐๆฏๅฝๆฐ-้ญๅ ๅฏไปฅ็ฎๅ
            ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
              CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
            }
  //        }
        }
        
      }
      .foregroundColor(.red)
      Spacer()// ไผ็ซๅฏ่ฝ็ๅ ๆ ไธๆน ไธๆน ็ฉบ้ด
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
  
  // ่งๅพๅๅฒ -- ็ปไปถๅ๏ผ
  var add: some View {
    Button(action: { // button ็ไบไปถ
      emojiCount += 1
    }) {
      Image(systemName: "plus.circle") // ็ณป็ปๅพๆ 
    }
  }
}

// ่งๅพๆๅ  swiftui ็ปไปถๅๅบ็ก
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
    .onTapGesture { // view ๅ ไบไปถ
      isFaceUp = !isFaceUp
    }
  }
}


































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
