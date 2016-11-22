import UIKit

//@objc protocol SwipeDismissViewControllerDelegate {
//  @objc optional func willDismiss()
//}

open class SwipeDismissViewController: UIViewController {
  
  @IBOutlet public var swipeView: UIView!
  
  public var swipeAmount: CGFloat = 300
  
  public var startLocation: CGPoint!
  
//  weak var delegate: SwipeDismissViewControllerDelegate?
  
  override open func viewDidLoad() {
    view.backgroundColor = .black
    view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.8)
    view.addSubview(swipeView)
  
    print(startLocation)
    print(swipeView.center)
    super.viewDidLoad()
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(swipe(pan:)))
    swipeView.addGestureRecognizer(pan)
  }
  
  func swipe(pan: UIPanGestureRecognizer) {
    
    let dragDistance = swipeView.center.distance(toPoint: startLocation)
    let dragPercent = dragDistance/swipeAmount
    
    let translation = pan.translation(in: self.view)
    pan.view!.center.y = pan.view!.center.y + translation.y
    pan.setTranslation(CGPoint.zero , in: self.view)
    
    swipeView.alpha = 1 - dragPercent
    view.backgroundColor = view.backgroundColor?.withAlphaComponent(0.8 - (dragPercent * 1.4))
    
    if pan.state == .ended {
      if dragPercent > 1 {
        remove()
      } else {
        reset()
      }
    }
  }
  
  func remove() {
    view.removeFromSuperview()
    removeFromParentViewController()
  }
  
  func reset() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [unowned self] in
      self.swipeView.center.y = self.startLocation.y
      self.swipeView.alpha = 1
      self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0.8)
    }, completion: nil)
  }
  
}
