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
    MockURLProtocol.mockResponses = [:]
    super.tearDown()
  }

  private func setupMockResponse(for urlString: String, data: Data?, statusCode: Int) {
    let url = URL(string: urlString)!
    let mockResponse = HTTPURLResponse(
      url: url,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil)
    MockURLProtocol.mockResponses[url] = (data, mockResponse, nil)
  }

  func testSuccessfulFetchDataFromURL() {
    let urlString = "https://example.com/success.csv"
    let mockData = "Starbucks Seattle,47.5809,-122.3160".data(using: .utf8)

    setupMockResponse(for: urlString, data: mockData, statusCode: 200)
    let expectation = self.expectation(description: "Completion handler invoked")

    fetchDataFromURL(from: urlString, session: session) { result in
      switch result {
      case .success(let shops):
        XCTAssertEqual(shops.count, 1)
      case .failure:
        XCTFail("Expected success but got failure")
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testFailureFetchDataFromURLNoData() {
    let urlString = "https://example.com/success.csv"

    setupMockResponse(for: urlString, data: nil, statusCode: 200)

    let expectation = self.expectation(description: "Completion handler invoked")

    fetchDataFromURL(from: urlString, session: session) { result in
      switch result {
      case .success:
        XCTFail("Expected failure but got success")
      case .failure(let error):
        XCTAssertEqual(.invalidResponse, error)
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testFailureFetchDataFromURLBadStatusCode() {
    let urlString = "https://example.com/success.csv"

    setupMockResponse(for: urlString, data: nil, statusCode: 400)

    let expectation = self.expectation(description: "Completion handler invoked")

    fetchDataFromURL(from: urlString, session: session) { result in
      switch result {
      case .success:
        XCTFail("Expected failure but got success")
      case .failure(let error):
        XCTAssertEqual(.invalidResponse, error)
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testSuccessfulExtractFromCSV() {
    let mockString = "Starbucks Seattle,47.5809,-122.3160"
    do {
      let shops = try extractFromCSV(data: mockString)
      XCTAssertEqual(shops.count, 1)
    } catch {
      XCTFail("Expected success but got failure")
    }
  }

  func testFailureExtractFromCSVBadCoordinate() {
    let mockString = "Starbucks Seattle,47.5809p,-122.3160"
    do {
      _ = try extractFromCSV(data: mockString)
      XCTFail("Expected failure but got success")
    } catch let error as ExtractionError {
      XCTAssertEqual(.invalidCoordinate(0, "X"), error)
    } catch {
      XCTFail("Unexpected error type: \(error)")
    }
  }

  func testFailureExtractFromCSVTooManyColumns() {
    let mockString = "Starbucks Seattle,47.5809,-122.3160,arg4"
    do {
      _ = try extractFromCSV(data: mockString)
      XCTFail("Expected failure but got success")
    } catch let error as ExtractionError {
      XCTAssertEqual(.invalidEntry(0), error)
    } catch {
      XCTFail("Unexpected error type: \(error)")
    }
  }
}