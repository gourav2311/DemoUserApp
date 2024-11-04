//
//  FetchUserUseCaseTests.swift


import XCTest
@testable import DemoUsersApp

class FetchUserUseCaseTests: XCTestCase {
    var userRepository: MockUserRepository!
    var fetchuserUseCase: FetchUserUseCase!

    override func setUp() {
        super.setUp()
        userRepository = MockUserRepository()
        fetchuserUseCase = FetchUserUseCase(repository: userRepository)
    }

    override func tearDown() {
        userRepository = nil
        fetchuserUseCase = nil
        super.tearDown()
    }

    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "Fetch users successfully")

        fetchuserUseCase.execute() { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, 1)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testExecuteFailure() {
        userRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch users with error")

        fetchuserUseCase.execute() { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Test Error")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock users Repository
class MockUserRepository: UserRepository {
    var shouldReturnError = false

    func fetchUser( completion: @escaping (Result<[UserModel], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])))
        } else {
            let data = [UsersModelDTO(id: 000001, name: "John doe", email: "johndoe@gmail.com", gender: .male, status: .active)]
            completion(.success(data.map {UserModelMapper.toDomain(userDTO: $0)}))
        }
    }

    func updateUser(for city: String, with data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not needed for this test
    }

    func deleteUser(for city: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not needed for this test
    }
}

