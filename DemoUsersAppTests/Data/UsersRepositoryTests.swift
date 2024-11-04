//
//  UserRepositoryTests.swift

import XCTest
@testable import DemoUsersApp

class UserRepositoryTests: XCTestCase {
    var apiClient: MockAPIClient!
    var userRepository: UserRepositoryImpl!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        let appConfiguration = AppConfiguration()
        let apiConfiguration = UserAPIConfiguration(configuration: appConfiguration)
        let remoteDataSource = RemoteUserDataSource(apiClient: apiClient, apiConfiguration: apiConfiguration)
        userRepository = UserRepositoryImpl(dataSource: remoteDataSource)
    }

    override func tearDown() {
        apiClient = nil
        userRepository = nil
        super.tearDown()
    }

    func testFetchUserSuccess() {
        let expectation = XCTestExpectation(description: "Fetch users successfully")

        userRepository.fetchUser() { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 1)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
    func testLocalFetchUserSuccess() {
        let appConfiguration = AppConfiguration()
        let jsonLoader = JSONLoader()
        let localDataSource = LocalUserDataSource(jsonLoader: jsonLoader, configuration: appConfiguration)
        userRepository = UserRepositoryImpl(dataSource: localDataSource)
        let expectation = XCTestExpectation(description: "Fetch users successfully")

        
        userRepository.fetchUser() { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 10)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchUserFailure() {
        apiClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch users with error")

        userRepository.fetchUser() { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Test Error")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock API Client
class MockAPIClient: APIClient {
    var shouldReturnError = false

    override func request<T>(urlRequest:URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])))
        } else {
            let data = [UsersModelDTO(id: 000001, name: "John doe", email: "johndoe@gmail.com", gender: .male, status: .active)]
            completion(.success(data as! T))
        }
    }

}

