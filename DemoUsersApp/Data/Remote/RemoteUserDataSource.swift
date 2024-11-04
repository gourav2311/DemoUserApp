
import Foundation


public class RemoteUserDataSource:UserDataSource {
    private let apiClient: APIClientProtocol
    private let apiConfiguration:UserAPIConfiguration
    
     init(apiClient: APIClientProtocol, apiConfiguration:UserAPIConfiguration) {
        self.apiClient = apiClient
        self.apiConfiguration = apiConfiguration
    }
    
     func fetchUser(completion: @escaping (Result<[UsersModelDTO], Error>) -> Void) {
        guard let url = apiConfiguration.makeUserURL() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: AppNetworkStringsConstant.invalidUrl])))
            return
        }
        
         var request = URLRequest(url: url)
         request.httpMethod = HTTPMethod.get.rawValue
        apiClient.request(urlRequest: request, completion: completion)
    }
}


