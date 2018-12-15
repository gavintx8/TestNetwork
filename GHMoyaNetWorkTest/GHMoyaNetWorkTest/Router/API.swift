//
//  API.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 3/30/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md

import Foundation
import Moya

enum API{
    case updateAPi(parameters:[String:Any])
//    case register(email:String,password:String)
    //上传用户头像
    case uploadHeadImage(parameters: [String:Any],imageDate:Data)
    case easyRequset
    case mobleWebcomConfig(parameters:[String:Any])
    case gonggao(parameters:[String:Any])
    case checklogin(parameters:[String:Any])
    case login(parameters:[String:Any])
    case getBalance(parameters:[String:Any])
    case getToken(parameters:[String:Any])
    case transferTo(parameters:[String:Any])
    case forwardGame(parameters:[String:Any])
    case transferFrom(parameters:[String:Any])
    case getUserCard(parameters:[String:Any])
    case selectWithdrawConfig(parameters:[String:Any])
    case withDraw(parameters:[String:Any])
    case getUserInfo(parameters:[String:Any])
    case checkQkpwd(parameters:[String:Any])
    case changeQkpwd(parameters:[String:Any])
    case changePassword(parameters:[String:Any])
    case queryByTreasurePage(parameters:[String:Any])
    case getBetInfo(parameters:[String:Any])
    case getReChargeInfo(parameters:[String:Any])
    case getTransferInfo(parameters:[String:Any])
    case getWithDrawInfo(parameters:[String:Any])
    case getPaymentList(parameters:[String:Any])
    case scanPay(parameters:[String:Any])
    case getQRCode(parameters:[String:Any])
    case getOrder(parameters:[String:Any])
    case getBankList(parameters:[String:Any])
    case bankPay(parameters:[String:Any])
    case logout(parameters:[String:Any])
    case sendChangeCode(parameters:[String:Any])
    case changeMobile(parameters:[String:Any])
    case register(parameters:[String:Any])
    case paymentChannel(parameters:[String:Any])
}

extension API:TargetType{
    var baseURL: URL {
        switch self {
        case .easyRequset:
            return URL.init(string:"http://news-at.zhihu.com/api/")!
        default:
            return URL.init(string:(Moya_baseURL))!
        }
    }
    
    var path: String {
        switch self {
        case .easyRequset:
            return "4/news/latest"
        case .updateAPi:
            return "versionService.getAppUpdateApi"
        case .uploadHeadImage( _):
            return "/file/user/upload.jhtml"
        case .mobleWebcomConfig:
            return "mobleWebcomConfig.do"
        case .gonggao:
            return "gonggao.do"
        case .checklogin:
            return "checklogin.do"
        case .login:
            return "login.do"
        case .getBalance:
            return "User/getBalance"
        case .getToken:
            return "User/getToken"
        case .transferTo:
            return "User/TransferTo"
        case .forwardGame:
            return "User/forwardGame"
        case .transferFrom:
            return "User/TransferFrom"
        case .getUserCard:
            return "User/getUserCard"
        case .selectWithdrawConfig:
            return "User/selectWithdrawConfig"
        case .withDraw:
            return "User/WithDraw"
        case .getUserInfo:
            return "User/getUserInfo"
        case .checkQkpwd:
            return "User/checkQkpwd"
        case .changeQkpwd:
            return "User/changeQkpwd"
        case .changePassword:
            return "User/changePassword"
        case .queryByTreasurePage:
            return "User/queryByTreasurePage"
        case .getBetInfo:
            return "User/getBetInfo"
        case .getReChargeInfo:
            return "User/getReChargeInfo"
        case .getTransferInfo:
            return "User/getTransferInfo"
        case .getWithDrawInfo:
            return "User/getWithDrawInfo"
        case .getPaymentList:
            return "PlatformPay/getPaymentList"
        case .scanPay:
            return "PlatformPay/scanPay"
        case .getQRCode:
            return "alipayPaymentScanCode/getQRCode"
        case .getOrder:
            return "alipayPaymentScanCode/getOrder"
        case .getBankList:
            return "getBankList.do"
        case .bankPay:
            return "bk/BankPay.do"
        case .logout:
            return "logout.do"
        case .sendChangeCode:
            return "Mobile/sendChangeCode.do"
        case .changeMobile:
            return "Mobile/changeMobile.do"
        case .register:
            return "User/register"
        case .paymentChannel:
            return "PlatformPay/paymentChannel"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .easyRequset:
            return .get
        default:
            return .post
        }
    }
    

    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    //    该条请API求的方式,把参数之类的传进来
    var task: Task {
//        return .requestParameters(parameters: nil, encoding: JSONArrayEncoding.default)
        switch self {
        case .easyRequset:
            return .requestPlain
        case let .updateAPi(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        //图片上传
        case .uploadHeadImage(let parameters, let imageDate):
            ///name 和fileName 看后台怎么说，   mineType根据文件类型上百度查对应的mineType
            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
                                              fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case let .mobleWebcomConfig(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .gonggao(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .checklogin(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .login(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getBalance(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getToken(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .transferTo(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .forwardGame(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .transferFrom(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getUserCard(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .selectWithdrawConfig(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .withDraw(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getUserInfo(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .checkQkpwd(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .changeQkpwd(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .changePassword(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .queryByTreasurePage(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getBetInfo(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getReChargeInfo(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getTransferInfo(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getWithDrawInfo(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getPaymentList(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .scanPay(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getQRCode(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getOrder(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getBankList(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .bankPay(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .logout(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .sendChangeCode(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .changeMobile(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .register(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .paymentChannel(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        //可选参数https://github.com/Moya/Moya/blob/master/docs_CN/Examples/OptionalParameters.md
//        case .users(let limit):
//        var params: [String: Any] = [:]
//        params["limit"] = limit
//        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
 
    
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded","referer":Moyah5_baseURL]
    }
 
}
