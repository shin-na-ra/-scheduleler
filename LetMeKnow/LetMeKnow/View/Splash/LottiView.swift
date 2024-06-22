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
    
    typealias UIViewType = UIView
    
    var filename: String
    
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        
//        animationView.backgroundBehavior = .pauseAndRestore
        
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
