//
//  ContentView.swift
//  MuvingCardsSwiftUI
//
//  Created by Gleb Zadonskiy on 24.06.2020.
//  Copyright © 2020 Gleb Zadonskiy. All rights reserved.
//  https://www.youtube.com/watch?v=S9DOdX178ms&list=WL&index=33&t=3s

import SwiftUI
enum DragState{
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isActive: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
    
    
}
struct ContentView: View {
    
    @GestureState var dragState: DragState = .inactive
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .updating($dragState){
                (value, state, transc) in
                state = .dragging(translation: value.translation)
        }
        return ZStack {
            Card(title: "Three Card")
                .rotation3DEffect(Angle(degrees: dragState.isActive ? 0 : 60), axis: (x: 10, y: 10, z: 10))
                .blendMode(.hardLight)
                .padding(dragState.isActive ? 32 : 64)
                .padding(.bottom, dragState.isActive ? 32 : 64)
                .animation(.spring())
            Card (title: "Second Card")
                .rotation3DEffect(Angle(degrees: dragState.isActive ? 0 : 30), axis: (x: 10, y: 10, z: 10))
                .blendMode(.hardLight)
                .padding(dragState.isActive ? 16 : 32)
                .padding(.bottom, dragState.isActive ? 0 : 32)
                .animation(.spring())
            MainCard(title: "Main Card")
                .rotationEffect(Angle(degrees: Double(dragState.translation.width / 10)))
                .offset(
                    x: self.dragState.translation.width,
                    y: self.dragState.translation.height
                )
            .gesture(dragGesture)
            .animation(.spring())
        }
    }
}

struct Card: View {
    var title: String
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Color.init(red: 68 / 255, green: 41 / 255, blue: 182 / 255))
                .frame(height: 230)
                .cornerRadius(10)
                .padding(16)
            
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct MainCard: View {
    var title: String
    var body: some View{
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(height: 230)
                .cornerRadius(10)
                .padding(16)
            
            Text(title)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .bold()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
