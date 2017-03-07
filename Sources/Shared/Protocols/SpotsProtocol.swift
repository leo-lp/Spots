#if os(OSX)
  import Foundation
#else
  import UIKit
#endif

import Cache

public protocol SpotsProtocol: class {

  /// A closure that is called when the controller is reloaded with components
  static var spotsDidReloadComponentModels: ((_ controller: Controller) -> Void)? { get set }
  /// A StateCache object
  var stateCache: StateCache? { get set }
  /// The internal SpotsScrollView
  var scrollView: SpotsScrollView { get }
  /// A delegate that conforms to ComponentDelegate
  var delegate: ComponentDelegate? { get }
  /// A collection of CoreComponent objects
  var spots: [CoreComponent] { get set }
  /// An array of refresh position to avoid calling multiple refreshes
  var refreshPositions: [CGFloat] { get set }
  /// A view controller view
  #if os(OSX)
  var view: View { get }
  #else
  var view: View! { get }
  #endif

  /// The first spotable object in the controller.
  var spot: CoreComponent? { get }

  /// A dictionary representation of the controller
  var dictionary: [String : Any] { get }

  #if os(iOS)
  var refreshDelegate: RefreshDelegate? { get set }
  #endif

  #if DEVMODE
  /// A dispatch queue is a lightweight object to which your application submits blocks for subsequent execution.
  var fileQueue: DispatchQueue { get }
  /// An identifier for the type system object being monitored by a dispatch source.
  var source: DispatchSourceFileSystemObject? { get set }
  #endif

  /// Set up CoreComponent objects.
  ///
  /// - parameter animated: An optional animation closure that is invoked when setting up the spot.
  func setupSpots(animated: ((_ view: View) -> Void)?)

  /// Set up Spot at index
  ///
  /// - parameter index: The index of the CoreComponent object
  /// - parameter spot:  The spotable object that is going to be setup
  func setupComponent(at index: Int, spot: CoreComponent)

  ///  A generic look up method for resolving spots based on index
  ///
  /// - parameter index: The index of the spot that you are trying to resolve.
  /// - parameter type: The generic type for the spot you are trying to resolve.
  ///
  /// - returns: An optional CoreComponent object of inferred type.
  func spot<T>(at index: Int, ofType type: T.Type) -> T?

  /// A generic look up method for resolving spots using a closure
  ///
  /// - parameter closure: A closure to perform actions on a spotable object
  ///
  /// - returns: An optional CoreComponent object
  func resolve(spot closure: (_ index: Int, _ spot: CoreComponent) -> Bool) -> CoreComponent?

  #if os(OSX)
  init(spots: [CoreComponent], backgroundType: ControllerBackground)
  #else
  /// A required initializer for initializing a controller with CoreComponent objects
  ///
  /// - parameter spots: A collection of CoreComponent objects that should be setup and be added to the view hierarchy.
  ///
  /// - returns: An initalized controller.
  init(spots: [CoreComponent])
  #endif
}
