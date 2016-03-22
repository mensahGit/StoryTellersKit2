//
//  GameViewController.swift
//  STORYTELLERSKIT2
//
//  Created by Mensah on 2/27/16.
//  Copyright (c) 2016 Mensah Moody. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            
            if let scene = Page(fileNamed:"Cover") {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFill
                scene.currentPage = "Cover"
                
                skView.presentScene(scene)
            }
            
        } else {
            
            if let scene = Page(fileNamed:"CoverPhone") {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFill
                scene.currentPage = "Cover"
                
                skView.presentScene(scene)
            }
            
    else if let scene = Page(fileNamed:"Cover") {
            
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFill
                scene.currentPage = "Cover"
                
                skView.presentScene(scene)
            }
            
            
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
