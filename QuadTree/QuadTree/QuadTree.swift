/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import Foundation
import CoreGraphics.CGBase // CGPoint

struct QuadTree {
  private(set) var count = 0
  
  init(region: CGRect) {
  }
  
  @discardableResult
  mutating func insert(_ point: CGPoint) -> Bool {
    false
  }
  
  func find(in searchRegion: CGRect) -> [CGPoint] {
    []
  }
  
  func points() -> [CGPoint] {
    []
  }
  
  func regions() -> [CGRect] {
    []
  }
  
  private final class Node {
    let maxItemCapacity = 4
    var region: CGRect
    var points: [CGPoint] = []
    var quad: Quad?
    
    init(region: CGRect, points: [CGPoint] = [], quad: Quad? = nil) {
      self.region = region
      self.quad = quad
      self.points = points
      self.points.reserveCapacity(maxItemCapacity)
      precondition(points.count <= maxItemCapacity)
    }
    
    struct Quad {
      var northWest: Node
      var northEast: Node
      var southWest: Node
      var southEast: Node
      
      var all: [Node] { [northWest, northEast, southWest, southEast] }
      
      init(region: CGRect) {
        let halfWidth = region.size.width * 0.5
        let halfHeight = region.size.height * 0.5
        
        northWest = Node(region: CGRect(x: region.origin.x,
                                        y: region.origin.y,
                                        width: halfWidth,
                                        height: halfHeight))
        northEast = Node(region: CGRect(x: region.origin.x + halfWidth,
                                        y: region.origin.y,
                                        width: halfWidth,
                                        height: halfHeight))
        southWest = Node(region: CGRect(x: region.origin.x,
                                        y: region.origin.y + halfHeight,
                                        width: halfWidth,
                                        height: halfHeight))
        southEast = Node(region: CGRect(x: region.origin.x + halfWidth,
                                        y: region.origin.y + halfHeight,
                                        width: halfWidth,
                                        height: halfHeight))
      }
      
      init(northWest: Node, northEast: Node,
           southWest: Node, southEast: Node) {
        self.northEast = northEast
        self.northWest = northWest
        self.southWest = southWest
        self.southEast = southEast
      }
      
      func copy() -> Quad {
        Quad(northWest: northw, northEast: <#T##QuadTree.Node#>, southWest: <#T##QuadTree.Node#>, southEast: <#T##QuadTree.Node#>)
      }
    }
  }
}
