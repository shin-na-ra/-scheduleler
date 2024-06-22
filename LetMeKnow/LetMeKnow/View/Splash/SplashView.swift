//
//  SplashView.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/22/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack(content: {
            ZStack(content: {
                LottieView(filename: "Loading2")
                    .frame(width: 400, height: 400)
                
                Spacer()
            })
        })
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation{
                    self.isActive = true
                }
            }
        }
        //메인화면으로 이동
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}

#Preview {
    SplashView()
}
