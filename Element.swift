//
//  Element.swift
//  STORYTELLERSKIT2
//
//  Created by Mensah on 2/28/16.
//  Copyright © 2016 Mensah Moody. All rights reserved.
//



import Foundation
import SpriteKit


class Element: SKSpriteNode {
    
    var sceneWidth:CGFloat = 0
    var sceneHeight:CGFloat = 0
    
    var positionPercentageWidth:CGFloat = 0
    var positionPercentageHeight:CGFloat = 0
    
    var touchEvent:String = ""
    var touchEventValue:String = ""
    var touchEventDict:NSDictionary?
    
    
    func createElement(){
        
        print("Element created with name of \(self.name).")
    }
    
    func usePlistProperties(theDict:NSDictionary) {
        
        print(theDict)
        
        if (theDict.objectForKey("SizeWidthToSceneWidth") != nil) {
            
            let sizeWidthToSceneWidth:Bool = theDict.objectForKey("SizeWidthToSceneWidth") as! Bool
            if (sizeWidthToSceneWidth == true) {
                
                self.size = CGSizeMake(sceneWidth, self.size.height)
            }
        }
        
        if (theDict.objectForKey("SizeHeightToSceneWidth") != nil) {
            
            let sizeHeightToSceneWidth:Bool = theDict.objectForKey("SizeHeightToSceneWidth") as! Bool
            if (sizeHeightToSceneWidth == true) {
                
                self.size = CGSizeMake(self.size.width, sceneHeight)
            }
        }
        
        if (theDict.objectForKey("PositionPercentageWidth") != nil) {
            
            let positionPercentageWidth = theDict.objectForKey("PositionPercentageWidth") as! CGFloat
            
            
            self.position = CGPointMake(sceneWidth * positionPercentageWidth, self.position.y)
        }
        
        if (theDict.objectForKey("PositionPercentageHeight") != nil) {
            
            let positionPercentageHeight = theDict.objectForKey("PositionPercentageHeight") as! CGFloat
            
            self.position = CGPointMake(self.position.x, sceneHeight * positionPercentageHeight)
        }
        
        if (theDict.objectForKey("TouchEvent") != nil) {
            
            if let theString:String = theDict.objectForKey("TouchEvent") as? String{
                
                touchEvent = theString
                touchEventValue = "none"
                
                
            } else if let eventDict:NSDictionary = theDict.objectForKey("TouchEvent") as? NSDictionary {
                
                touchEventDict = eventDict
            }
            
            
        }
    }
    
    func touched() {
        
        if (touchEventDict != nil){
            
            doEventWithDict(touchEventDict!)
        } else if (touchEvent != "") {
            
            doEvent(touchEvent, eventValue: touchEventValue)
        }
    }
    
    func doEventWithDict (eventDict:NSDictionary) {
        
        for item in eventDict {
            
            if let theKey:String = item.key as? String {
                
                if let theValue:String = item.value as? String {
                    
                    doEvent(theKey, eventValue: theValue)
                } else if let theValue:CGFloat = item.value as? CGFloat {
                    doEvent(theKey, eventValue: String(theValue) )
                } else if let theValue:Bool = item.value as? Bool {
                    doEvent(theKey, eventValue: String(theValue) )
                    
                }
            }
        }
    }
    
    func doEvent (eventName:String, eventValue:String) {
        
        print(eventName)
        print(eventValue)
    }
}