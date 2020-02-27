//
//  SimplePresentationController.swift
//  CustomPresentation
//
//  Created by Jonathan Wong on 5/25/19.
//  Copyright © 2019 Fresh App Factory. All rights reserved.
//

import UIKit

class SimplePresentationController: UIPresentationController , UIAdaptivePresentationControllerDelegate{
  
  var selectedObject: SelectionObject?
  var dimmingView = UIView()
  var flagImageView = UIImageView(
    frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 160.0, height: 93.0)))
  var isAnimating = false
  
  override init(
    presentedViewController: UIViewController,
    presenting presentingViewController: UIViewController?) {
    super.init(
      presentedViewController: presentedViewController,
      presenting: presentingViewController)
    dimmingView.backgroundColor = UIColor.clear
    flagImageView.contentMode = UIView.ContentMode.scaleAspectFill
    flagImageView.clipsToBounds = true
    flagImageView.layer.cornerRadius = 4.0
  }
  
  override func presentationTransitionWillBegin() {
    guard let containerView = containerView else {
      return
    }
    dimmingView.frame = containerView.bounds
    dimmingView.alpha = 0.0
    containerView.insertSubview(dimmingView, at: 0)
    
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(
        alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
          self.dimmingView.alpha = 1.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 1.0
    }
  }
  
  override func dismissalTransitionWillBegin() {
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate(
        alongsideTransition: {
          (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
          self.dimmingView.alpha = 0.0
      }, completion: nil)
    } else {
      dimmingView.alpha = 0.0
    }
  }
  
  override func containerViewWillLayoutSubviews() {
    guard let containerView = containerView else {
      return
    }
    dimmingView.frame = containerView.bounds
    presentedView?.frame = containerView.bounds
  }
  
  override var shouldPresentInFullscreen: Bool {
    return true
  }
  
  func adaptivePresentationStyle(
    for controller: UIPresentationController)
    -> UIModalPresentationStyle {
    return UIModalPresentationStyle.overFullScreen
  }
}
