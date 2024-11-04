//
//  UsersModelDTOTests.swift
//  DemoUsersAppTests

import XCTest

// Test case for UsersModelDTO Codable functionality
class UsersModelDTOTests: XCTestCase {

    // Test decoding of a valid JSON string to UsersModelDTO
    func test_decodeUsersModelDTO_withValidJSON_shouldDecodeSuccessfully() {
        // Given
        let jsonString = """
        {
            "id": 1,
            "name": "John Doe",
            "email": "john.doe@example.com",
            "gender": "male",
            "status": "active"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        do {
            let userDTO = try decoder.decode(UsersModelDTO.self, from: jsonData)

            // Then
            XCTAssertEqual(userDTO.id, 1)
            XCTAssertEqual(userDTO.name, "John Doe")
            XCTAssertEqual(userDTO.email, "john.doe@example.com")
            XCTAssertEqual(userDTO.gender, .male)
            XCTAssertEqual(userDTO.status, .active)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    // Test decoding when some fields are missing
    func test_decodeUsersModelDTO_withMissingFields_shouldDecodeSuccessfullyWithNilValues() {
        // Given
        let jsonString = """
        {
            "id": 2,
            "name": "Jane Doe"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        do {
            let userDTO = try decoder.decode(UsersModelDTO.self, from: jsonData)

            // Then
            XCTAssertEqual(userDTO.id, 2)
            XCTAssertEqual(userDTO.name, "Jane Doe")
            XCTAssertNil(userDTO.email) // Email is missing in JSON
            XCTAssertNil(userDTO.gender) // Gender is missing in JSON
            XCTAssertNil(userDTO.status) // Status is missing in JSON
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    // Test decoding invalid JSON should throw an error
    func test_decodeUsersModelDTO_withInvalidJSON_shouldThrowError() {
        // Given
        let jsonString = """
        {
            "id": "invalid_id", // id should be Int
            "name": "John Doe",
            "email": "john.doe@example.com",
            "gender": "male",
            "status": "active"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        XCTAssertThrowsError(try decoder.decode(UsersModelDTO.self, from: jsonData), "Expected decoding error for invalid id type") { error in
            print("Decoding failed as expected with error: \(error)")
        }
    }

    // Test encoding UsersModelDTO to JSON
    func test_encodeUsersModelDTO_toJSON_shouldEncodeSuccessfully() {
        // Given
        let userDTO = UsersModelDTO(id: 3, name: "Alice", email: "alice@example.com", gender: .female, status: .inactive)

        // When
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(userDTO)
            let jsonString = String(data: jsonData, encoding: .utf8)

            // Then
            XCTAssertNotNil(jsonString)
            XCTAssertTrue(jsonString!.contains("\"id\" : 3"))
            XCTAssertTrue(jsonString!.contains("\"name\" : \"Alice\""))
            XCTAssertTrue(jsonString!.contains("\"email\" : \"alice@example.com\""))
            XCTAssertTrue(jsonString!.contains("\"gender\" : \"female\""))
            XCTAssertTrue(jsonString!.contains("\"status\" : \"inactive\""))
        } catch {
            XCTFail("Encoding failed: \(error)")
        }
    }

    // Test decoding Gender enum with all values
    func test_decodeGenderEnum_shouldDecodeSuccessfully() {
        // Given
        let jsonString = """
        [
            { "gender": "male" },
            { "gender": "female" },
            { "gender": "Unknown" }
        ]
        """
        let jsonData = jsonString.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        do {
            let genders = try decoder.decode([UsersModelDTO].self, from: jsonData)
            
            // Then
            XCTAssertEqual(genders[0].gender, .male)
            XCTAssertEqual(genders[1].gender, .female)
            XCTAssertEqual(genders[2].gender, .unknown)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }

    // Test decoding Status enum with all values
    func test_decodeStatusEnum_shouldDecodeSuccessfully() {
        // Given
        let jsonString = """
        [
            { "status": "active" },
            { "status": "inactive" }
        ]
        """
        let jsonData = jsonString.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        do {
            let statuses = try decoder.decode([UsersModelDTO].self, from: jsonData)
            
            // Then
            XCTAssertEqual(statuses[0].status, .active)
            XCTAssertEqual(statuses[1].status, .inactive)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}
