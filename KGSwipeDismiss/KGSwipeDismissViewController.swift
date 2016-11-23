import UIKit

@objc protocol SwipeDismissViewControllerDelegate {
  @objc optional func willDismiss()
}

open class SwipeDismissViewController: UIViewController {
  
  @IBOutlet public var swipeView: UIView!
  
  public var swipeAmount: CGFloat = 300
  public var backgroundFadeSpeed: CGFloat = 0.6
  
  public var startLocation: CGPoint!
  
  weak var delegate: SwipeDismissViewControllerDelegate?
  
  override open func viewDidLoad() {
    navigationController?.setNavigationBarHidden(true, animated: true)
    
    view.backgroundColor = .black
    view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.8)
    view.addSubview(swipeView)
    
    swipeView.layer.cornerRadius = 10
    super.viewDidLoad()
    
    view.alpha = 0
    
    UIView.animate(withDuration: 0.4, animations: { [unowned self] in
      self.view.alpha = 1.0
    })
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(swipe(pan:)))
    swipeView.addGestureRecognizer(pan)
    
    startLocation = view.center
  }
  
  func swipe(pan: UIPanGestureRecognizer) {
    
    let dragDistance = swipeView.center.distance(toPoint: startLocation)
    let dragPercent = dragDistance/swipeAmount
    
    let translation = pan.translation(in: self.view)
    pan.view!.center.y = pan.view!.center.y + translation.y
    pan.setTranslation(CGPoint.zero , in: self.view)
    
    swipeView.alpha = 1 - dragPercent
    view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.8 - (dragPercent * backgroundFadeSpeed))
    
    if pan.state == .ended {
      if dragPercent > 1 {
        remove()
      } else {
        reset()
      }
    }
  }
  
  public func remove() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    view.removeFromSuperview()
    removeFromParentViewController()
  }
  
  public func reset() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [unowned self] in
      self.swipeView.center.y = self.startLocation.y
      self.swipeView.alpha = 1
      self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0.8)
    }, completion: nil)
  }
  
}
