//
//  ConfigurationProtocol.swift


import Foundation

public protocol ConfigurationProtocol {
    var baseURL: String { get }
    var apiKey: String { get }
    var localUserDataFilename: String { get }
}

