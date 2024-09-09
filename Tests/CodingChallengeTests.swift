import Foundation
import FoundationNetworking
import XCTest
@testable import CodingChallenge

final class CodingChallengeTests: XCTestCase {
    func testSuccessfulCalcDistance() {
        let shop = Shop(name: "Starbucks Seattle2", coordX: 47.5869, coordY: -122.3368)
        XCTAssertEqual(calcDistance(from: shop, to: (47.6, -122.4)), 0.0645)
    }

    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()

    override func tearDown() {
        //MockURLProtocol.request = nil
        MockURLProtocol.mockResponses = [:]
        super.tearDown()
    }

    func testFetchDataFromURLSuccess() {
        // Given
        let urlString = "https://example.com/success.csv"
        let mockData = "Starbucks Seattle,47.5809,-122.3160".data(using: .utf8)
        let mockResponse = HTTPURLResponse(url: URL(string: urlString)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        MockURLProtocol.mockResponses[URL(string: urlString)!] = (mockData, mockResponse, nil)

        let expectation = self.expectation(description: "Completion handler invoked")

        // When
        fetchDataFromURL(from: urlString, session: session) { result in
            // Then
            switch result {
            case .success(let shops):
                XCTAssertEqual(shops.count, 1)
            case .failure(let error):
                XCTFail("Expected success but got failure \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}