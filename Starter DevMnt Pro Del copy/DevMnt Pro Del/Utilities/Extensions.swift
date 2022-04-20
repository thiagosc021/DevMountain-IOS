//
//  Extensions.swift
//  DevMnt Pro Del
//
//  Created by Thiago Costa on 3/24/22.
//

import UIKit

extension UIView {
    func shake() {
        let translateRight = CGAffineTransform(translationX: 4.0, y: 0)
        let translateLeft = CGAffineTransform(translationX: -4.0, y: 0)

        self.transform = translateRight
        UIView.animate(withDuration: 0.07, delay: 0.01, options: [.autoreverse, .repeat], animations: {
            UIView.setAnimationRepeatCount(2.5)
            self.transform = translateLeft
        }) { finished in
            if finished {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
