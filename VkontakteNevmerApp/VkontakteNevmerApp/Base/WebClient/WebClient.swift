//
//  WebClient.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import Alamofire
import ObjectMapper

final class WebClient<T: BaseMappable> {
    
    // MARK: Private properties
    
    private var baseUrl: String
//    private let interceptor = RequestInterceptor(KeychainStorage())
    
    // MARK: Init
    
    init() {
        baseUrl = "https://api.vk.com/method"
    }
    
    init(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }

    // MARK: Public methods
    
    @discardableResult func request(path: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (T?, BaseServiceError?) -> Void) -> DataRequest? {
        return AF.request(baseUrl + path, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: nil)
            .validate(statusCode: 200..<401)
            .responseString { response in
            debugPrint(response)
            if let _ = response.error {
                completion(nil, .connectionError)
            }
            else {
                switch response.result {
                case .success:
                    if let value = response.value,
                        let result = Mapper<T>().map(JSONString: value) {
                        if let response = result as? BaseResponse,
                            let error = response.error {
                            completion(nil, .custom(error.code ?? 1))
                        }
                        else {
                            completion(result, nil)
                        }
                    }
                    else {
                        completion(nil, .connectionError)
                    }
                case .failure( _):
                    completion(nil, .connectionError)
                }
            }
        }
    }
}
