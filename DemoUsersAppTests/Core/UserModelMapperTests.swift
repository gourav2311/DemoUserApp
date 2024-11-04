//
//  UserModelMapperTests.swift
//  DemoUsersAppTests


import XCTest

// Test class for UserModelMapper
class UserModelMapperTests: XCTestCase {

    // Test mapping when all values are present
    func test_toDomain_withValidDTO_shouldReturnCorrectUserModel() {
        // Given
        let dto = UsersModelDTO(
            id: 1,
            name: "John Doe",
            email: "john.doe@example.com",
            gender: .male,
            status: .active
        )

        // When
        let domainModel = UserModelMapper.toDomain(userDTO: dto)

        // Then
        XCTAssertEqual(domainModel.id, 1)
        XCTAssertEqual(domainModel.name, "John Doe")
        XCTAssertEqual(domainModel.email, "john.doe@example.com")
        XCTAssertEqual(domainModel.gender, "Male")
        XCTAssertTrue(domainModel.isActive)
    }

    // Test mapping when some values are nil
    func test_toDomain_withNilValues_shouldReturnDefaultValues() {
        // Given
        let dto = UsersModelDTO(
            id: nil,
            name: nil,
            email: nil,
            gender: nil,
            status: nil
        )

        // When
        let domainModel = UserModelMapper.toDomain(userDTO: dto)

        // Then
        XCTAssertEqual(domainModel.id, 0) // Default ID
        XCTAssertEqual(domainModel.name, "") // Default empty string for name
        XCTAssertEqual(domainModel.email, "") // Default empty string for email
        XCTAssertEqual(domainModel.gender, "Unknown") // Default gender
        XCTAssertFalse(domainModel.isActive) // Default inactive status
    }

    // Test mapping when status is inactive
    func test_toDomain_withInactiveStatus_shouldReturnIsActiveFalse() {
        // Given
        let dto = UsersModelDTO(
            id: 2,
            name: "Jane Doe",
            email: "jane.doe@example.com",
            gender: .female,
            status: .inactive
        )

        // When
        let domainModel = UserModelMapper.toDomain(userDTO: dto)

        // Then
        XCTAssertEqual(domainModel.id, 2)
        XCTAssertEqual(domainModel.name, "Jane Doe")
        XCTAssertEqual(domainModel.email, "jane.doe@example.com")
        XCTAssertEqual(domainModel.gender, "Female")
        XCTAssertFalse(domainModel.isActive) // Should be inactive
    }
}

