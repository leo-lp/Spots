public class SpotFactory {

  public static var DefaultSpot: Spotable.Type = GridSpot.self

  private static var spots: [String: Spotable.Type] = [
    "carousel": CarouselSpot.self,
    "list" : ListSpot.self,
    "grid": GridSpot.self
  ]

  public static func register<T: Spotable>(kind: String, spot: T.Type) {
    spots[kind] = spot
  }

  public static func resolve(component: Component) -> Spotable {
    let spot: Spotable.Type = spots[component.kind] ?? DefaultSpot
    return spot.init(component: component)
  }
}