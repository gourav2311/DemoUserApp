//
//  JsonLoaderTests.swift
//  DemoUsersAppTests

import XCTest
@testable import DemoUsersApp

class JSONLoaderTests: XCTestCase {
    
    var jsonLoader: JSONLoader!
    
    override func setUp() {
        super.setUp()
        jsonLoader = JSONLoader()
    }
    
    override func tearDown() {
        jsonLoader = nil
        super.tearDown()
    }
    
    // Test 1: Loading a valid JSON file successfully
    func testLoadJSONSuccess() {
        // Assuming a valid JSON file "valid_user.json" exists in the test bundle
       
        let filename = "users_data" // Replace with the actual JSON filename
        
        guard let jsonData = jsonLoader.loadJSON(filename: filename) else {
            XCTFail("Expected valid JSON data, but got nil")
            return
        }
        
        XCTAssertNotNil(jsonData, "JSON data should not be nil for a valid file.")
        
        // Optionally, decode the data to check if the JSON structure is valid
        do {
            let user = try JSONDecoder().decode([UsersModelDTO].self, from: jsonData)
            XCTAssertEqual(user.first?.name, "Chandrani Agarwal DDS", "Expected name to be 'Chandrani Agarwal DDS'.")
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    // Test 2: Loading a JSON file that doesn't exist
    func testLoadJSONFileNotFound() {
        // Attempt to load a non-existent JSON file
        let filename = "non_existent_file"
        
        let jsonData = jsonLoader.loadJSON(filename: filename)
        
        XCTAssertNil(jsonData, "Expected nil for a non-existent file, but got data.")
    }
    
    // Test 3: JSON loading failure (e.g., corrupted JSON file)
    func testLoadJSONFileCorrupted() {
        // Assuming "corrupted_user.json" is a corrupted or invalid file in the test bundle
        let filename = "corrupted_user" // Replace with the actual corrupted file
        
        let jsonData = jsonLoader.loadJSON(filename: filename)
        
        XCTAssertNil(jsonData, "Expected nil when loading a corrupted file, but got data.")
    }
}
