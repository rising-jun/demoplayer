//
//  MusicInfoAPI.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/06.
//

import Foundation
import Moya

public enum MusicInfoAPI{
    case getMusicData(lastUrl: String)
}

extension MusicInfoAPI: TargetType, AccessTokenAuthorizable {
    
   
    //public var baseURL: URL { URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com")! }
    public var baseURL: URL { URL(string: "https://ipfs.io")! }
    
    public var path: String {
        let servicePath = "/ipfs"
        switch self {
        case .getMusicData(let lastUrl):
            //return servicePath + "/song.json"
            print("servicePath : \(servicePath + lastUrl)")
            return servicePath + lastUrl
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getMusicData:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getMusicData:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
    
    public var authorizationType: AuthorizationType? {
        return .none
    }
    
    
}
