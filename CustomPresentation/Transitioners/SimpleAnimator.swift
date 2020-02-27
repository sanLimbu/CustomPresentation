//
//  SimpleAnimator.swift
//  CustomPresentation
//
//  Created by Jonathan Wong on 5/25/19.
//  Copyright © 2019 Fresh App Factory. All rights reserved.
//

import UIKit

class SimpleAnimator: NSObject,
UIViewControllerAnimatedTransitioning {
  
  var isPresentation = false
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController =
      transitionContext.viewController(
        forKey: UITransitionContextViewControllerKey.from)
    let fromView = fromViewController!.view
    let toViewController =
      transitionContext.viewController(
        forKey: UITransitionContextViewControllerKey.to)
    let toView = toViewController!.view
    
    let containerView = transitionContext.containerView
    if isPresentation {
      containerView.addSubview(toView!)
    }
    
    let animatingViewController =
      isPresentation ? toViewController : fromViewController
    let animatingView = animatingViewController!.view
    
    let appearedFrame = transitionContext.finalFrame(for: animatingViewController!)
    var dismissedFrame = appearedFrame
    dismissedFrame.origin.y += dismissedFrame.size.height
    
    let initialFrame =
      isPresentation ? dismissedFrame : appearedFrame
    let finalFrame =
      isPresentation ? appearedFrame : dismissedFrame
    animatingView?.frame = initialFrame
    
    UIView.animate(
      withDuration: transitionDuration(using: transitionContext),
      delay: 0.0,
      usingSpringWithDamping: 300.0,
      initialSpringVelocity: 5.0,
      options: [UIView.AnimationOptions.allowUserInteraction,
      UIView.AnimationOptions.beginFromCurrentState],
      animations: {
        animatingView?.frame = finalFrame
    },
      completion: { value in
        if !self.isPresentation {
          fromView?.removeFromSuperview()
        }
        transitionContext.completeTransition(true)
    })
  }
  

}

class SimpleTransitioningDelegate: NSObject,
  UIViewControllerTransitioningDelegate {
  
  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController)
    -> UIPresentationController? {
    let presentationController = SimplePresentationController(
      presentedViewController: presented, presenting: presenting)
      return presentationController
  }
  
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
    let animationController = SimpleAnimator()
      animationController.isPresentation = true
      return animationController
  }
  
  func animationController(
    forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
    let animationController = SimpleAnimator()
      animationController.isPresentation = false
      return animationController
  }
}
