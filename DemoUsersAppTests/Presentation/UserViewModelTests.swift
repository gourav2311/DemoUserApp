//
//  UserViewModelTests.swift

import XCTest
@testable import DemoUsersApp

class UserViewModelTests: XCTestCase {
    var userRepository: MockUserRepository!
    var fetchUserUseCase: FetchUserUseCase!
    var userViewModel: UserViewModel!

    override func setUp() {
        super.setUp()
        userRepository = MockUserRepository()
        fetchUserUseCase = FetchUserUseCase(repository: userRepository)
        userViewModel = UserViewModel(fetchUserUseCase: fetchUserUseCase)
    }

    override func tearDown() {
        userRepository = nil
        fetchUserUseCase = nil
        userViewModel = nil
        super.tearDown()
    }

    func testFetchUserSuccess() {
        let expectation = XCTestExpectation(description: "Fetch User successfully")

        userViewModel.fetchUser()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.userViewModel.users)
            XCTAssertEqual(self.userViewModel.users?.count, 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchUserFailure() {
        userRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch User with error")

        userViewModel.fetchUser()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertNotNil(self.userViewModel.errorMessage)
            XCTAssertEqual(self.userViewModel.errorMessage, "Test Error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

