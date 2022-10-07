//
//  BottomSheetPopViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import SnapKit
import Then
import UIKit

open class BottomSheetPopViewController: UIViewController {
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.transitioningDelegate = self
    self.modalPresentationStyle = .custom
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}

extension BottomSheetPopViewController: UIViewControllerTransitioningDelegate {
  
  public func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {
    let controller = PresentationController(presentedViewController: presented, presenting: presenting)
    
    return controller
  }
  
  public func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return ShowAnimation()
  }
  
  public func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    return DismissAnimation()
  }
}

public class ShowAnimation: NSObject, UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let toViewController = transitionContext.viewController( forKey: .to),
        let toView = transitionContext.view( forKey: .to)
    else {
      return
    }

    let containerView = transitionContext.containerView
    toView.frame = transitionContext.finalFrame(for: toViewController)
    containerView.addSubview(toView)


    toView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)


    UIView.animate(withDuration: 0.3,
             delay: 0,
             usingSpringWithDamping: 1.0,
             initialSpringVelocity: 1.0,
             options: .curveEaseInOut, animations: {
      toView.transform = CGAffineTransform(translationX: 0, y: 0)
    }, completion: { finished in
      transitionContext.completeTransition(finished)
    })
  }
}

public class DismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {

  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromView = transitionContext.view( forKey: UITransitionContextViewKey.from)
    else {
      return
    }

    UIView.animate(withDuration: 0.3,
             delay: 0,
             options: .curveEaseInOut,
             animations: {
      fromView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
      fromView.alpha = 0.0
    }, completion: { finished in
      fromView.transform = CGAffineTransform(translationX: 0, y: 0)
      fromView.alpha = 1.0
      transitionContext.completeTransition(finished)
    })
  }
}

public class PresentationController: UIPresentationController {
  
  public lazy var backgroundView = UIView().then {
    $0.backgroundColor = .black.withAlphaComponent(0.5)
  }
  
  public override func presentationTransitionWillBegin() {
    if let containerView = containerView {
      containerView.insertSubview(self.backgroundView, at: 0)
      self.backgroundView.snp.makeConstraints {
        $0.edges.equalTo(containerView).inset(UIEdgeInsets.zero)
      }
      
      self.excuteBackgroundAnimation()
    }
  }
  
  public override func dismissalTransitionWillBegin() {
    self.excuteBackgroundDismissAnimation()
  }
  
  public override var shouldRemovePresentersView: Bool {
    return false
  }
  
  private func excuteBackgroundAnimation() {
    self.backgroundView.alpha = 0
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate { _ in
        self.backgroundView.alpha = 1
      }
    }
  }
  
  @objc private func excuteBackgroundDismissAnimation() {
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate { _ in
        self.backgroundView.alpha = 0
      }
    }
  }
}
