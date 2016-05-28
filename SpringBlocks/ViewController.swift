//
//  ViewController.swift
//  SpringBlocks
//
//  Created by Nick Perkins on 5/28/16.
//  Copyright © 2016 Nick Perkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var greenBoxView: UIView?
    var redBoxView: UIView?
    var animator: UIDynamicAnimator?
    var currentLocation: CGPoint?
    var attachment: UIAttachmentBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frameRect = CGRectMake(10, 20, 80, 80)
        greenBoxView = UIView(frame: frameRect)
        greenBoxView?.backgroundColor = UIColor.greenColor()
        
        frameRect = CGRectMake(150, 20, 60, 60)
        redBoxView = UIView(frame: frameRect)
        redBoxView?.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(greenBoxView!)
        self.view.addSubview(redBoxView!)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravity = UIGravityBehavior(items: [greenBoxView!,
            redBoxView!])
        let vector = CGVectorMake(0.0, 1.0)
        gravity.gravityDirection = vector
        
        let collision = UICollisionBehavior(items: [greenBoxView!,
            redBoxView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        let behavior = UIDynamicItemBehavior(items: [greenBoxView!,
            redBoxView!])
        behavior.elasticity = 0.5
        
        let boxAttachment = UIAttachmentBehavior(item: greenBoxView!,
                                                 attachedToItem: redBoxView!)
        boxAttachment.frequency = 4.0
        boxAttachment.damping = 0.0
        
        animator?.addBehavior(boxAttachment)
        animator?.addBehavior(behavior)
        animator?.addBehavior(collision)
        animator?.addBehavior(gravity)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let theTouch = touches.first! as UITouch
        currentLocation = theTouch.locationInView(self.view)
        
        attachment = UIAttachmentBehavior(item: greenBoxView!,
                                          attachedToAnchor: currentLocation!)
        
        animator?.addBehavior(attachment!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        let theTouch = touches.first! as UITouch
        
        currentLocation = theTouch.locationInView(self.view)
        attachment?.anchorPoint = currentLocation!
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        animator?.removeBehavior(attachment!)
    }
    
}
