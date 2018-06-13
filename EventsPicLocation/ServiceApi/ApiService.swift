//
//  ApiService.swift
//  EventsPicLocation
//
//  Created by Diego on 11/10/17.
//  Copyright © 2017 Pernambuco da Sorte. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    
    static func getSubjectList(completion: @escaping ([SubjectVO]?) -> Void) {
        
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.LIST_SUBJECT)!
        doRequest(url: url, method: HTTPMethod.post) { (response) in
            if let val = response.result.value as? Array<Dictionary<String, Any>>, response.error == nil {
                var list = Array<SubjectVO>()
                for item:Dictionary<String, Any> in val {
                    if let sub = SubjectVO(JSON: item) {
                        //sub.saveToCoreData()
                        list.append(sub)
                    }
                }
                completion(list)
            } else {
                completion(nil)
            }
        }        
    }
    
    static func saveMedia(media:MediaRequestVO, fileName:String, completion: @escaping (Bool, Media?) -> Void) {
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.SAVE_MEDIA)!
        doRequest(url: url, parameters:media.toJSON(), method: HTTPMethod.post) { (r) in
            if let val = r.result.value as? Dictionary<String, Any>, r.error == nil {
                if let apiId = val["id"] as? Int64 {
                    let media = MediaDAO.saveMediaCore(mediaId: apiId, fileName: fileName, withRequest: media)
                    completion(true, media)
                    return
                }
            }
            
            completion(false, nil)
        }
    }
    
    static func getFile(mediaId:Int, completion: @escaping (Bool) -> Void) {
//        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.SAVE_MEDIA)!
//        doRequest(url: url, parameters:media.toJSON(), method: HTTPMethod.post) { (r) in
//            completion(r.response != nil && r.response!.statusCode == 200)
//        }
    }
    
    static func saveFile(mediaId:Int64, imageData:Data, completion: @escaping (Bool) -> Void) {
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.SAVE_FILE + "\(mediaId)")!
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        //manager.request(url, method: HTTPMethod.post, parameters: [], encoding: ParameterEncoding., headers: <#T##HTTPHeaders?#>)
        
//        manager.request(url
//            , method: .Post
//            , parameters: parameters
//            , encoding: ParameterEncoding..default
//            , headers: userHeader).validate().responseJSON { (response) in
//
//                completion(response)
//        }
        
        Alamofire.upload(imageData, to: url.absoluteString).responseJSON { (response) in
            let n = response            
            completion(true)
        }
    }
    
    static func doLogin(login: String, password: String, completion: @escaping (Bool) -> Void) {
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.LOGIN)!
        let header = ["Authorization": EPLHelper.createBasicAuthString(login: login, password: password)]
        doRequest(url: url, parameters: nil, method: HTTPMethod.post, userHeader: header) { (r) in
            completion(r.response != nil && r.response!.statusCode == 200)
        }
    }
    
    static func changePassword(password:String, newPassword:String, completion: @escaping (Bool) -> Void) {
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.CHANGE_PASSWORD)!
        doRequest(url: url, parameters: ["senha" : password, "novaSenha" : newPassword], method: HTTPMethod.post) { (r) in
            completion(r.response != nil && r.response!.statusCode == 200)
        }
    }
    
    static func recoverPassword(login:String, email:String, completion: @escaping (Bool) -> Void) {
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.RECOVER_PASSWORD)!
        doRequest(url: url, parameters: ["login" : login, "email" : email], method: HTTPMethod.post, userHeader: nil) { (r) in
            completion(r.response != nil && r.response!.statusCode == 200)
        }
    }
    
    static func getLotteryAndSubjectList(completion: @escaping (LotterySubjectListsVO?) -> Void) {
        let url = ServiceApiUtil.getUrl(urlStr: ServiceApiUtil.LIST_LOTTERY_SUBJECT)!
        doRequest(url: url, method: HTTPMethod.post) { (response) in
            if let val = response.result.value as? Dictionary<String, Any>, response.error == nil {
                let lsList = LotterySubjectListsVO(JSON: val)
                completion(lsList)
            } else {
                completion(nil)
            }
        }
    }
    
    public static func doRequest(url:URL, parameters:[String: Any]?, method:HTTPMethod
        , completion: @escaping (DataResponse<Any>) -> Void) {
        let header = ["Authorization": EPLUserPreferencesHelper.getUserAuth()!]
        doRequest(url: url, parameters: parameters, method: method, userHeader: header, completion: completion)
    }
    
    public static func doRequest(url:URL, method:HTTPMethod, completion: @escaping (DataResponse<Any>) -> Void) {
        let header = ["Authorization": EPLUserPreferencesHelper.getUserAuth()!]
        doRequest(url: url, parameters: nil, method: method, userHeader: header, completion: completion)
    }
    
    public static func doRequest(url:URL, parameters:[String: Any]?, method:HTTPMethod, userHeader:HTTPHeaders?, completion: @escaping (DataResponse<Any>) -> Void) {
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        manager.request(url
            , method: method
            , parameters: parameters
            , encoding: JSONEncoding.default
            , headers: userHeader).validate().responseJSON { (response) in

                completion(response)
        }
    }        
}
