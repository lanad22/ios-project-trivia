//
//  ButtonExtension.swift
//  Trivia
//
//  Created by Lana Do on 10/7/23.
//

import UIKit

extension UIButton {
    
    
    
    func highlightCorrect() {
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = frame.height/4
    }
    
    func highlightIncorrect() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = frame.height/4
    }
    
   
}
