import XCTest
@testable import CodingChallenge

final class YourModuleTests: XCTestCase {
    func testExample() {
        let shop = Shop(name: "Starbucks Seattle2", coordX: 47.5869, coordY: -122.3368)
        XCTAssertEqual(calcDistance(from: shop, to: (47.6, -122.4)), 0.0645)
    }
}