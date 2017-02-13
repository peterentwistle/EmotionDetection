import XCTest
@testable import OpenCVTest

class OpenCVTestTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(OpenCVTest().text, "Hello, World!")
    }


    static var allTests : [(String, (OpenCVTestTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
