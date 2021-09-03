import UIKit

protocol NibCreatable: AnyObject {
  
  static var nib: UINib { get }
  static var nibBundle: Bundle? { get }
  static var nibName: String { get }
  
  static func instanceFromNib() -> Self
}
