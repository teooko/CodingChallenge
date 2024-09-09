import Foundation
import FoundationNetworking

class MockURLProtocol: URLProtocol {
  static var mockResponses: [URL: (Data?, URLResponse?, Error?)] = [:]
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  override func startLoading() {
        if let response = MockURLProtocol.mockResponses[request.url!] {
            if let data = response.0 {
                client?.urlProtocol(self, didLoad: data)
            }
            if let urlResponse = response.1 {
                client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
            }
            if let error = response.2 {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }

        client?.urlProtocolDidFinishLoading(self)
    }

  override func stopLoading() {
  }
}