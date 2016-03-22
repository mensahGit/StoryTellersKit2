//
//  Page.swift
//  STORYTELLERSKIT2
//
//  Created by Mensah on 2/28/16.
//  Copyright © 2016 Mensah Moody. All rights reserved.
//

import SpriteKit
import UIKit

class Page: SKScene {
    
    var sceneWidth:CGFloat = 0
    var sceneHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    var isPhone:Bool = false
    
    var currentPage:String = ""
    
    var dict:NSDictionary?
    var currentPageDict:NSDictionary?
    var pageSettingsDict:NSDictionary?
    var elementsDictInRoot:NSDictionary?
    var elementsDict:NSDictionary?
    
    var currentCamera:String = ""
    
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            isPhone = false
            
        }else{
            
            isPhone = true
        }
        
        screenWidth = self.view!.bounds.size.width
        screenHeight = self.view!.bounds.size.height
        
        sceneWidth = scene!.size.width
        sceneHeight = scene!.size.height
        
        print("Scene width is \(sceneWidth)")
        print("Scene height is \(sceneHeight)")
        
        print("Screen width is \(screenWidth)")
        print("Screen height is \(screenHeight)")
        
        print(currentPage)
        
        parseList()
        
        setUpSceneAfterPropertyListLoaded()
        
        addOnPropertyFromList()
    }
    
    
    func parseList(){
        
        let path = NSBundle.mainBundle().pathForResource("List", ofType:"plist")
        
        dict = NSDictionary(contentsOfFile: path!)
        
        let pagesDict = dict!.objectForKey("Pages") as? NSDictionary
        
        if (dict?.objectForKey("Elements") != nil) {
            
            
            elementsDictInRoot = dict?.objectForKey("Elements") as? NSDictionary
        }
        
        
        
        if (pagesDict?.objectForKey(currentPage) != nil){
            
            currentPageDict = pagesDict?.objectForKey(currentPage) as? NSDictionary
            pageSettingsDict = currentPageDict?.objectForKey("Settings") as? NSDictionary
            
            if (currentPageDict?.objectForKey("Elements") != nil) {
                
                
                elementsDict = currentPageDict?.objectForKey("Elements") as? NSDictionary
            }
            
            
            if (pageSettingsDict?.objectForKey("InitialCameraPhone") != nil && isPhone == true) {
                
                currentCamera = pageSettingsDict?.objectForKey("InitialCameraPhone") as! String
                
            }else if (pageSettingsDict?.objectForKey("InitialCamera") != nil){
                
                currentCamera = pageSettingsDict?.objectForKey("InitialCameraPhone") as! String
            }
        }
    }
    
    func setUpSceneAfterPropertyListLoaded() {
        
        self.enumerateChildNodesWithName("//*") {
            
            node, stop in
            
            if let element:Element = node as? Element {
                self.setUpElement(element)
            }
            else if let camera:SKCameraNode = node as? SKCameraNode{
                
                if (self.currentPage != ""){
                    
                    if (camera.name == self.currentCamera){
                        
                        self.camera = camera
                    }
                } else {
                    self.camera = camera
                }
            }
        }
        
    }
    
    func setUpElement(theElement:Element){
        
        theElement.sceneWidth = self.sceneWidth
        theElement.sceneHeight = self.sceneHeight
        
        theElement.createElement()
    }
    
    
    //enumerate through all children in node, including .sks files
    func addOnPropertyFromList() {
        
        self.enumerateChildNodesWithName("//*") {
            
            node, stop in
            
            if let element:Element = node as? Element {
                self.pairElementToDictionaries(element)
            }
            
        }
    }
    
    
    func pairElementToDictionaries(checkElement:Element){
        
        var paired:Bool = false
        
        if elementsDict != nil{
            
            for item in self.elementsDict!{
                //loop throught data in elementsDict
                if (checkElement.name == item.key as? String) {
                    
                    let theDictToPass:NSDictionary = item.value as! NSDictionary
                    
                    checkElement.usePlistProperties(theDictToPass)
                    
                    paired = true
                    break
                }
                
            }
        }
        
        if elementsDictInRoot != nil && paired == false {
            
            for item in self.elementsDictInRoot!{
                //loop throught data in elementsDict
                if (checkElement.name == item.key as? String) {
                    
                    let theDictToPass:NSDictionary = item.value as! NSDictionary
                    
                    checkElement.usePlistProperties(theDictToPass)
                    
                    break
                }
                
            }
            
            func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
                /* Called when a touch begins */
                
                for touch in touches {
                    let location = touch.locationInNode(self)
                    
                    var highestZ:CGFloat = -100000
                    var highestElement:Element?
                    
                    let rect:CGRect = CGRectMake(location.x, location.y, 2, 2)
                    
                    self.enumerateChildNodesWithName("//*") {
                        
                        node, stop in
                        
                        if let elementNode:Element = node as? Element {
                            
                            let elementRect:CGRect = CGRectMake(elementNode.position.x - (elementNode.size.width/2), elementNode.position.y - (elementNode.size.height / 2), elementNode.size.width,
                            elementNode.size.height)
                            
                            if (CGRectIntersectsRect(elementRect, rect)) {
                                
                                if (elementNode.zPosition >= highestZ) {
                                    
                                    highestZ = elementNode.zPosition
                                    highestElement = elementNode
                                }
                            }
                            
                        }
                        
                    } //ends enumeration
                    
                    if (highestElement != nil) {
                        
                        highestElement?.touched()
                    }
                }
                
                func update(currentTime: CFTimeInterval) {
                    /* Called before each frame is rendered */
                }
            }
        }
}
}