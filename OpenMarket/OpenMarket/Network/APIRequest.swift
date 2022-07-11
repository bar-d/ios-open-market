//
//  APIRequest.swift
//  OpenMarket
//
//  Created by NAMU on 2022/07/11.
//

import Foundation

protocol APIRequest {
    func performRequest()
}

extension APIRequest {
    func performRequest(urlString: String) -> Data {
        var taskData: Data?
        var task: URLSessionDataTask?
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            task = session.dataTask(with: url) { (data, reponse, error) in
                if error != nil{
                    return
                }
                taskData = data
            }
        }
        task?.resume()
        return taskData ?? Data()
    }
}
