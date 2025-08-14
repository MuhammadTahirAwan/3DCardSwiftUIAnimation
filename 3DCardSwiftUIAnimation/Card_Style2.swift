//
//  Card_Style2.swift
//  3DCardSwiftUIAnimation
//
//  Created by Tahir Awan on 13/08/2025.
//

import SwiftUI

struct Card_Style2: View {
    
    let images = (1...15)
    let angle: Angle = .degrees(45)
    let offset: Int = -20
    @State private var dragTranslation: CGSize = .zero
    
    var rotationX: Double {
        Double(dragTranslation.height / 5)
    }
    
    var rotationY: Double {
        Double(dragTranslation.width / 5)
    }
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged { value in
                dragTranslation = value.translation
            }
            .onEnded { _ in
                withAnimation(.spring()) {
                    dragTranslation = .zero
                }
            }
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10.0)
            //                .fill(.black)
                .foregroundStyle(
                    MeshGradient(
                        width: 3,
                        height: 3,
                        points: [
                            [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                            [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                            [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                        ], colors: [
                            .white,
                            .gray.opacity(0.8),
                            .gray.opacity(0.6),
                            .gray.opacity(0.4),
                            .gray.opacity(0.7),
                            .white,
                            .gray.opacity(0.9),
                            .gray.opacity(0.5),
                            .white
                        ]
                    ).shadow(
                        .inner(color: .black, radius: 10, x: 0, y: 0)
                    )
                    
                )
                .padding()
                .frame(width: 300, height: 400)
            
            
            VStack{
                
                
                HStack{
                    
                    Text("7")
                        .foregroundStyle(.white)
                        .font(.system(size: 40, weight: .light, design: .default))
                        .frame(alignment: .leading)
                        .padding(.leading, 100)
                    
                    
                    VStack(alignment: .leading){
                        
                        Text("System")
                            .foregroundStyle(.white)
                            .font(.system(size: 15, weight: .light, design: .default))
                            .padding(.leading, 0)
                        
                        Text("Coordinates")
                            .foregroundStyle(.gray)
                            .font(.system(size: 15, weight: .light, design: .default))
                            .padding(.leading, 0)
                    }
                    
                    Spacer()
                }
                
                
                ZStack{
                    ForEach(images, id: \.self) { index in
                        
                        let depthMultiplier = CGFloat(index)
                        
                        let xOffset = depthMultiplier * CGFloat(rotationY / 45) * 20
                        let yOffset = depthMultiplier * CGFloat(rotationX / 45) * 20
                        
                        Image("pentagono-2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .scaleEffect(1 - CGFloat(index) * 0.06)
                            .opacity(1 - Double(index) * 0.08)
                        //.offset(y: CGFloat(index) * 5)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                            .offset(x: -xOffset, y: yOffset)
                        
                    }
                    
                }
                
                
                
                
                HStack{
                    
                    VStack(alignment: .leading){
                        
                        Text("Orientation")
                            .foregroundStyle(.white)
                            .font(.system(size: 13, weight: .light, design: .default))
                            .padding(.leading, 0)
                        
                        Text("Orbit around to see the depth of the card.")
                            .foregroundStyle(.black)
                            .font(.system(size: 13, weight: .light, design: .default))
                            .padding(.leading, 0)
                            .padding(.top, 2)
                    }
                    
                    Spacer()
                    
                }.padding(.leading, 80)
                    .padding(.top, 25)
                    .offset(y: -20)
            }
            
            
            
            
            
            
            
        }.mask(RoundedRectangle(cornerRadius: 10.0)
            .padding()
            .frame(width: 300, height: 400))
        .rotation3DEffect(
            .degrees(rotationX),
            axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(
            .degrees(rotationY),
            axis: (x: 0, y: 1, z: 0))
        // Rotating Stack / Card with drag Gesture
        .offset(x: dragTranslation.width * 0.05, y: dragTranslation.height * 0.05)
        .gesture(dragGesture)
        .background(GrayMeshBackground().frame(height: 950))
    }
}

#Preview {
    Card_Style2()
}
