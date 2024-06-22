//
//  Lottie.swift
//  LetMeKnow
//
//  Created by 신나라 on 6/22/24.
//

import Foundation
import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    
    var name: String
    var loopMode: LottieLoopMode
    
    init(jsonName: String = "", loopMode: LottieLoopMode = .loop) {
        self.name = jsonName
        self.loopMode = loopMode
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(name)
        animationView.animation = animation
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        animationView.backgroundBehavior = .pauseAndRestore
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
            // Update the view if necessary
        }
}
