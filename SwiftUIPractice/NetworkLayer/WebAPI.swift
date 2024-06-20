//
//  WebAPI.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation

extension WebAPI {
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
}

//MARK: - Prepare URL REQUEST
class WebAPI {
    
    var requestHttpHeaders: [String:String] = [:]

    private func prepareRequest(withURL url: String, params: [String:Any], httpMethod: HttpMethod, specialPUTParams: String? = nil, specialGETParams: String? = nil) -> URLRequest? {
        
        guard let apiURL = URL(string: url) else { return nil }
        var urlRequest = URLRequest(url: apiURL) // initialize with url
        urlRequest.httpMethod = httpMethod.rawValue // set http method
        
        /*set http body*/
        switch httpMethod {
        case .post, .put, .delete:
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            
            if let params = specialPUTParams {
                let newParams = "\(params)"
                let urlString = urlRequest.url!.absoluteString + newParams
                urlRequest.url = URL(string: urlString)
            } else if let getParams = specialGETParams {
                let urlString = urlRequest.url!.absoluteString + getParams
                urlRequest.url = URL(string: urlString)
            }
        case .get:
            
            if let params = specialGETParams {
                let newParams = "\(params)"
                let urlString = urlRequest.url!.absoluteString + newParams
                urlRequest.url = URL(string: urlString)
            }
            
            var queryParameters = "?"
            let sortedKeys = params.keys.sorted(by: { $0 < $1 })
            
            for k in sortedKeys {
                if let v = params[k] {
                    var stringValue = v as? String
                    stringValue = stringValue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.replacingOccurrences(of: ":", with: "%3A")
                    queryParameters += k + "=\(stringValue ?? v)"
                    queryParameters += "&"
                }
            }
            
            queryParameters.removeLast()
            var urlString = urlRequest.url!.absoluteString + queryParameters
            urlRequest.url = URL(string: urlString)
        default:
            break
        }
        
        /*set authorization header*/
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        for (header, value) in requestHttpHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: header)
        }
        
        
        if url.contains("users"){
            if let token : String = UserDefaultsManager.authToken
            {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
        
        return urlRequest
    }
}

//MARK: - Authentication Request
extension WebAPI{
    
    enum AuthRequest
    {
        case token
        case register
        case forgotPassword
        case getProfile
        case customerProfile
        case updateAddress
    }
    
    public func auth(params: [String:Any] = [:], type : AuthRequest, specialPUTParams: String? = nil, specialGETParams: String? = nil) -> URLRequest? {
        
        var requestURL : String?
        var httpMethod : HttpMethod = .post
        
        switch type {
        case .token:
            requestURL = RequestUrl.token.tokenURL
        case .register:
            requestURL = RequestUrl.user.userURL
        case .getProfile:
            requestURL = RequestUrl.getProfile.profile
        case .forgotPassword:
            requestURL = RequestUrl.resetPassword.userURL
        case .updateAddress:
            httpMethod = .put
            requestURL = RequestUrl.customerProfile.products
        case .customerProfile:
            httpMethod = .get
            requestURL = RequestUrl.customerProfile.products
        }
        
        guard let request = self.prepareRequest(withURL: requestURL!, params: params, httpMethod: httpMethod, specialPUTParams: specialPUTParams, specialGETParams: specialGETParams) else {
            return nil
        }

        return request
    }
}


//MARK: - Products Request
extension WebAPI{
    
    enum ProductRequest
    {
        case productList
        case catagory
    }
    
    public func productRequest(params: [String:Any] = [:], type : ProductRequest, specialPUTParams: String? = nil, specialGETParams: String? = nil) -> URLRequest? {
        
        var requestURL : String?
        var httpMethod : HttpMethod = .post
        
        switch type {
        case .productList:
            httpMethod = .get
            requestURL = RequestUrl.products.products
        case .catagory:
            httpMethod = .get
            requestURL = RequestUrl.subMenus.menu
        }
        
        guard let request = self.prepareRequest(withURL: requestURL!, params: params, httpMethod: httpMethod, specialPUTParams: specialPUTParams, specialGETParams: specialGETParams) else {
            return nil
        }

        return request
    }
}
