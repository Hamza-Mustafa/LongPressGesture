//
//  ViewController.swift
//  LongPressGesture
//
//  Created by Hamza Mustafa on 18/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let longPress = UILongPressGestureRecognizer()
    var originalSizeImg : CGAffineTransform?
    
    var timeInSecs = 0.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.originalSizeImg = imageView.transform
    }
    
    func setupUI() {
        imageView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        imageView.image = #imageLiteral(resourceName: "bgImg")
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
        imageView.center = view.center
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imageView.addGestureRecognizer(longPress)
        longPress.addTarget(self, action: #selector(longPressTapped))
    }
    
    func startTimer(){
        timeInSecs = 0.0
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.timeInSecs += 0.1
        }
    }
    
    func stopTimer(){
        self.timer?.invalidate()
    }
    
    @objc func longPressTapped() {
        print("long pressed working")
        if longPress.state == .began {
            startTimer()
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = self.imageView.transform.scaledBy(x: 10, y: 10)
            }
        }
        
        if longPress.state == .ended {
            stopTimer()
            print(self.timeInSecs)
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = self.originalSizeImg!
            }
        }
    }
}
