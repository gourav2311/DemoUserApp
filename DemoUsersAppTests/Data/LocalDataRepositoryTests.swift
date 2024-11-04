//
//  LocalDataRepositoryTests.swift
//  DemoUsersAppTests

import XCTest

// Mock JSONLoaderProtocol to control the behavior of loadJSON
class MockJSONLoader: JSONLoaderProtocol {
    var shouldReturnValidData = true
    var mockData: Data?

    func loadJSON(filename: String) -> Data? {
        return shouldReturnValidData ? mockData : nil
    }
}



// Test case for LocalUserDataSource
class LocalUserDataSourceTests: XCTestCase {

    // Test case for successful JSON data loading and decoding
    func test_fetchUser_withValidJSON_shouldReturnSuccess() {
        // Given
        let mockJSONLoader = MockJSONLoader()
        let mockConfiguration = AppConfiguration()
        let localUserDataSource = LocalUserDataSource(jsonLoader: mockJSONLoader, configuration: mockConfiguration)

        // Mock valid JSON data
        let validJSON = """
        [
            { "id": 1, "name": "John Doe", "email": "john.doe@example.com", "gender": "male", "status": "active" }
        ]
        """.data(using: .utf8)!
        
        mockJSONLoader.mockData = validJSON

        // When
        let expectation = self.expectation(description: "Valid JSON data should be successfully decoded")
        localUserDataSource.fetchUser { result in
            switch result {
            case .success(let users):
                // Then
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "John Doe")
                XCTAssertEqual(users.first?.email, "john.doe@example.com")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test case for when JSONLoader fails to load the file
    func test_fetchUser_withMissingFile_shouldReturnFailure() {
        // Given
        let mockJSONLoader = MockJSONLoader()
        let mockConfiguration = AppConfiguration()
        let localUserDataSource = LocalUserDataSource(jsonLoader: mockJSONLoader, configuration: mockConfiguration)

        // Simulate the JSON loader failing to load the file
        mockJSONLoader.shouldReturnValidData = false

        // When
        let expectation = self.expectation(description: "Missing file should return failure")
        localUserDataSource.fetchUser { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                // Then
                XCTAssertEqual((error as NSError).localizedDescription, AppNetworkStringsConstant.localdataloadingfailed)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test case for when the JSON data is invalid and decoding fails
    func test_fetchUser_withInvalidJSON_shouldReturnDecodingError() {
        // Given
        let mockJSONLoader = MockJSONLoader()
        let mockConfiguration = AppConfiguration()
        let localUserDataSource = LocalUserDataSource(jsonLoader: mockJSONLoader, configuration: mockConfiguration)

        // Mock invalid JSON data
        let invalidJSON = """
        {
            "invalid": "data"
        }
        """.data(using: .utf8)!
        
        mockJSONLoader.mockData = invalidJSON

        // When
        let expectation = self.expectation(description: "Invalid JSON should return decoding failure")
        localUserDataSource.fetchUser { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                // Then
                XCTAssertTrue(error is DecodingError, "Expected DecodingError but got \(error)")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 2, handler: nil)
    }
}

