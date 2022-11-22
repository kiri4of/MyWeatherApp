//
//  ParticalsView.swift
//  WeatherApp
//
//  Created by Kiri4of on 19.11.2022.
//

import UIKit
import SpriteKit

class ParticalsView: SKView {
    
    override func didMoveToSuperview() {
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = .clear
        self.presentScene(scene)
        
        self.allowsTransparency = true //разрешить прозрачность
        self.backgroundColor = UIColor.clear
        
        if let particles = SKEmitterNode(fileNamed: "ParticleScene.sks") {
            particles.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height) //Тк появляется в левой нижней части экрана, двигаем на пол ширины тошо view появляется на половину, а остальная часть за экраном и высоту на фулл Тк view снизу.
            particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
            scene.addChild(particles)
        }
        
    }
    
}
