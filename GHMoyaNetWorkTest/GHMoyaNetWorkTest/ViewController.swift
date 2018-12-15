//
//  ViewController.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 3/30/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import SnapKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.backgroundColor = .gray
        tw.tableFooterView = UIView()
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: TMineTitleCell.self)
        return tw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }

    func testZhiHuDailyAPI() {
        NetWorkRequest(.easyRequset) { (responseString) -> (Void) in
            if let daliyItems = [GHItem].deserialize(from: responseString, designatedPath: "stories") {
                daliyItems.forEach({ (item) in
                    print("模型属性--\(item?.title ?? "模型无title")" )
                })
            }
        }
    }
    
    /// 基本使用
    func testAPI() {
        var paraDict: [String:Any] = Dictionary()
        paraDict["app_type_"] = "1"
        paraDict["app_version_no_"] = "1.0.1"
        paraDict["platform_type_"] = "2"
        paraDict["ver_code_value_"] = nil
        NetWorkRequest(.updateAPi(parameters: paraDict)) { (responseString) -> (Void) in
            //后台flag为1000是后台的result code
            print(responseString)
        }
    }
    
    /// muti-form 多表单文件上传，这里使用的是png图片上传--接口地址是我瞎写的， 你按照实际后台地址写就行
    func uploadImage() {
        var para = [String:Any]() //参数按照后台约定就成
        para["token"] = "token"
        para["juid"] = "id"
        para["file_type_"] = "head"
        
        let imageData = UIImageJPEGRepresentation(UIImage(), 0.3) //把图片转换成data
        NetWorkRequest(.uploadHeadImage(parameters: para, imageDate: imageData!)) { (resultString) -> (Void) in
            ///处理后台返回的json字符串
        }
    }
    
    /// 需要获取到网络请求失败，错误数据的情况
    func needsFailedAndErrorCondition() {
        var paraDict: [String:Any] = Dictionary()
        paraDict["app_type_"] = "1"
        paraDict["app_version_no_"] = "1.0.1"
        paraDict["platform_type_"] = "2"
        paraDict["ver_code_value_"] = nil
        NetWorkRequest(.updateAPi(parameters: paraDict), completion: { (resultString) -> (Void) in
            print("网络成功的数据")
        }, failed: { (str) -> (Void) in
            print("网络请求失败的数据(resultCode不为正确时)")
        /*
             也可以把成功和失败写在一个闭包里，获取后统一处理，但大多请求下只需要处理成功的数据，用上面第一个方法就行,数据处理已经在基本方法中处理好了。这种情况用的地方不多。可以根据自己的实际需求改写这个框架
         */
        }) { () -> (Void) in
            print("网络错误了")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 33
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TMineTitleCell.self)
        if indexPath.row == 0 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取优惠、活动、轮播图片"
            cell.contentLabel.text = "mobleWebcomConfig.do"
        }else if indexPath.row == 1 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取公告信息"
            cell.contentLabel.text = "gonggao.do"
        }else if indexPath.row == 2 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"检测登录"
            cell.contentLabel.text = "checklogin.do"
        }else if indexPath.row == 3 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"登录"
            cell.contentLabel.text = "login.do"
        }else if indexPath.row == 4 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取余额"
            cell.contentLabel.text = "User/getBalance"
        }else if indexPath.row == 5 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取Token"
            cell.contentLabel.text = "User/getToken"
        }else if indexPath.row == 6 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"转账到游戏平台"
            cell.contentLabel.text = "User/TransferTo"
        }else if indexPath.row == 7 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"跳转游戏"
            cell.contentLabel.text = "User/forwardGame"
        }else if indexPath.row == 8 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"游戏平台转账到主账户"
            cell.contentLabel.text = "User/TransferFrom"
        }else if indexPath.row == 9 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取用户银行卡列表"
            cell.contentLabel.text = "User/getUserCard"
        }else if indexPath.row == 10 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"提款申请"
            cell.contentLabel.text = "User/selectWithdrawConfig"
        }else if indexPath.row == 11 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"提款"
            cell.contentLabel.text = "User/WithDraw"
        }else if indexPath.row == 12 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取账户信息"
            cell.contentLabel.text = "User/getUserInfo"
        }else if indexPath.row == 13 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"检测是否存在取款密码"
            cell.contentLabel.text = "User/checkQkpwd"
        }else if indexPath.row == 14 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"修改取款密码"
            cell.contentLabel.text = "User/changeQkpwd"
        }else if indexPath.row == 15 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"修改登录密码"
            cell.contentLabel.text = "User/changePassword"
        }else if indexPath.row == 16 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"资金流水列表"
            cell.contentLabel.text = "User/queryByTreasurePage"
        }else if indexPath.row == 17 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"投注记录"
            cell.contentLabel.text = "User/getBetInfo"
        }else if indexPath.row == 18 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"充值记录"
            cell.contentLabel.text = "User/getReChargeInfo"
        }else if indexPath.row == 19 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"转账记录"
            cell.contentLabel.text = "User/getTransferInfo"
        }else if indexPath.row == 20 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"提款记录"
            cell.contentLabel.text = "User/getWithDrawInfo"
        }else if indexPath.row == 21 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"支付列表"
            cell.contentLabel.text = "PlatformPay/getPaymentList"
        }else if indexPath.row == 22 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"scanpay支付"
            cell.contentLabel.text = "PlatformPay/scanPay"
        }else if indexPath.row == 23 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"获取扫码支付信息"
            cell.contentLabel.text = "alipayPaymentScanCode/getQRCode"
        }else if indexPath.row == 24 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"扫码支付"
            cell.contentLabel.text = "alipayPaymentScanCode/getOrder"
        }else if indexPath.row == 25 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"卡列表"
            cell.contentLabel.text = "getBankList.do"
        }else if indexPath.row == 26 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"银行汇款支付"
            cell.contentLabel.text = "bk/BankPay.do"
        }else if indexPath.row == 27 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"退出登录"
            cell.contentLabel.text = "logout.do"
        }else if indexPath.row == 28 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"发送验证码"
            cell.contentLabel.text = "Mobile/sendChangeCode.do"
        }else if indexPath.row == 29 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"绑定手机号码"
            cell.contentLabel.text = "Mobile/changeMobile.do"
        }else if indexPath.row == 30 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"用户注册"
            cell.contentLabel.text = "User/register"
        }else if indexPath.row == 31 {
            cell.titleLabel.text = String(indexPath.row + 1)+"."+"支付渠道数据获取"
            cell.contentLabel.text = "PlatformPay/paymentChannel"
        }else if indexPath.row == 32 {
            cell.titleLabel.text = ""
            cell.contentLabel.text = ""
        }else{
            cell.titleLabel.text = ""
            cell.contentLabel.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["type"] = "2"
            paraDict["cagent"] = "YHH"
            NetWorkRequest(.mobleWebcomConfig(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
            }
        }else if indexPath.row == 1 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["cagent"] = "YHH"
            NetWorkRequest(.gonggao(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
            }
        }else if indexPath.row == 2 {
            let paraDict: [String:Any] = Dictionary()
            NetWorkRequest(.checklogin(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
            }
        }else if indexPath.row == 3 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
            }
        }else if indexPath.row == 4 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["BType"] = "WALLET"
                NetWorkRequest(.getBalance(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 5 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let data = responseString.data(using: String.Encoding.utf8)
                if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    var paraDict2: [String:Any] = Dictionary()
                    paraDict2["userKey"] = dict?["userKey"]
                    NetWorkRequest(.getToken(parameters: paraDict2)) { (responseString) -> (Void) in
                        print(responseString)
                    }
                }
            }
        }else if indexPath.row == 6 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let data = responseString.data(using: String.Encoding.utf8)
                if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    var paraDict2: [String:Any] = Dictionary()
                    paraDict2["userKey"] = dict?["userKey"]
                    NetWorkRequest(.getToken(parameters: paraDict2)) { (responseString) -> (Void) in
                        print(responseString)
                        let data2 = responseString.data(using: String.Encoding.utf8)
                        if let dict2 = try? JSONSerialization.jsonObject(with: data2!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                            var paraDict3: [String:Any] = Dictionary()
                            paraDict3["credit"] = "1"
                            paraDict3["type"] = "MG"
                            paraDict3["imgcode"] = ""
                            paraDict3["uuid"] = dict2?["msg"]
                            paraDict3["isImgCode"] = "0"
                            NetWorkRequest(.transferTo(parameters: paraDict3)) { (responseString) -> (Void) in
                                print(responseString)
                            }
                        }
                    }
                }
            }
        }else if indexPath.row == 7 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["gameType"] = "MG"
                paraDict2["gameID"] = "45611"
                paraDict2["model"] = "MB"
                NetWorkRequest(.forwardGame(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 8 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let data = responseString.data(using: String.Encoding.utf8)
                if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    var paraDict2: [String:Any] = Dictionary()
                    paraDict2["userKey"] = dict?["userKey"]
                    NetWorkRequest(.getToken(parameters: paraDict2)) { (responseString) -> (Void) in
                        print(responseString)
                        let data2 = responseString.data(using: String.Encoding.utf8)
                        if let dict2 = try? JSONSerialization.jsonObject(with: data2!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                            var paraDict3: [String:Any] = Dictionary()
                            paraDict3["credit"] = "1"
                            paraDict3["type"] = "MG"
                            paraDict3["imgcode"] = ""
                            paraDict3["uuid"] = dict2?["msg"]
                            paraDict3["isImgCode"] = "0"
                            NetWorkRequest(.transferFrom(parameters: paraDict3)) { (responseString) -> (Void) in
                                print(responseString)
                            }
                        }
                    }
                }
            }
        }else if indexPath.row == 9 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.getUserCard(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 10 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.selectWithdrawConfig(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 11 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["credit"] = "122"
                paraDict2["password"] = "1234"
                paraDict2["cardid"] = "142084"
                NetWorkRequest(.withDraw(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 12 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.getUserInfo(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 13 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.checkQkpwd(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 14 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["password"] = "1234"
                paraDict2["npassword"] = "1234"
                paraDict2["renpassword"] = "1234"
                NetWorkRequest(.changeQkpwd(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 15 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["password"] = "000000"
                paraDict2["npassword"] = "000000"
                paraDict2["renpassword"] = "000000"
                NetWorkRequest(.changePassword(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 16 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["pageSize"] = "5"
                paraDict2["type"] = "0"
                paraDict2["pageNo"] = "1"
                paraDict2["startTime"] = "2018-08-14 00:00:00"
                paraDict2["endTime"] = "2018-08-14 23:59:59"
                NetWorkRequest(.queryByTreasurePage(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 17 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["pageSize"] = "5"
                paraDict2["type"] = "ALL"
                paraDict2["pageNo"] = "1"
                paraDict2["bdate"] = "2018-08-14 00:00:00"
                paraDict2["edate"] = "2018-08-14 23:59:59"
                NetWorkRequest(.getBetInfo(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 18 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["pageSize"] = "5"
                paraDict2["Type"] = ""
                paraDict2["status"] = ""
                paraDict2["pageNo"] = "1"
                paraDict2["bdate"] = "2018-08-14 00:00:00"
                paraDict2["edate"] = "2018-08-14 23:59:59"
                NetWorkRequest(.getReChargeInfo(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 19 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["pageSize"] = "5"
                paraDict2["Type"] = ""
                paraDict2["Ttype"] = ""
                paraDict2["pageNo"] = "1"
                paraDict2["bdate"] = "2018-08-14"
                paraDict2["edate"] = "2018-08-14"
                NetWorkRequest(.getTransferInfo(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 20 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["pageSize"] = "5"
                paraDict2["status"] = ""
                paraDict2["pageNo"] = "1"
                paraDict2["bdate"] = "2018-08-14"
                paraDict2["edate"] = "2018-08-14"
                NetWorkRequest(.getWithDrawInfo(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 21 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["type"] = "5"
                NetWorkRequest(.getPaymentList(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 22 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["acounmt"] = "111"
                paraDict2["scancode"] = "yl"
                paraDict2["payId"] = "213"
                paraDict2["mobile"] = "mobile"
                NetWorkRequest(.scanPay(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 23 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["type"] = "1"
                NetWorkRequest(.getQRCode(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 24 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["id"] = "19"
                paraDict2["amount"] = "111"
                paraDict2["orderNum"] = "2234"
                paraDict2["transfertime"] = "2018-08-1419:28:12"
                paraDict2["type"] = "1"
                NetWorkRequest(.getOrder(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 25 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.getBankList(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 26 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                var paraDict2: [String:Any] = Dictionary()
                paraDict2["name"] = "张三"
                paraDict2["account"] = "YHHgo1234"
                paraDict2["amount"] = "100"
                paraDict2["ctime"] = "2018-08-14 19:21:36"
                paraDict2["type"] = "1"
                paraDict2["caijin"] = "1"
                NetWorkRequest(.bankPay(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 27 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.logout(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 28 {
            var paraDict2: [String:Any] = Dictionary()
            paraDict2["mobileNo"] = "13800138111"
            paraDict2["cagent"] = "YHH"
            NetWorkRequest(.sendChangeCode(parameters: paraDict2)) { (responseString) -> (Void) in
                print(responseString)
            }
        }else if indexPath.row == 29 {
            var paraDict2: [String:Any] = Dictionary()
            paraDict2["mobileNo"] = "13800138111"
            paraDict2["msgCode"] = "1234"
            paraDict2["cagent"] = "YHH"
            paraDict2["password"] = "000000"
            NetWorkRequest(.changeMobile(parameters: paraDict2)) { (responseString) -> (Void) in
                print(responseString)
            }
        }else if indexPath.row == 30 {
            let paraDict2: [String:Any] = Dictionary()
            NetWorkRequest(.getToken(parameters: paraDict2)) { (responseString) -> (Void) in
                print(responseString)
                let data2 = responseString.data(using: String.Encoding.utf8)
                if let dict2 = try? JSONSerialization.jsonObject(with: data2!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                    var paraDict3: [String:Any] = Dictionary()
                    paraDict3["userName"] = "dd1234"
                    paraDict3["passWord"] = "dd1234"
                    paraDict3["repassWord"] = "dd1234"
                    paraDict3["reguuid"] = dict2?["msg"]
                    paraDict3["mobileNo"] = "13800138098"
                    paraDict3["imgcode"] = ""
                    paraDict3["isImgCode"] = "0"
                    paraDict3["qkpwd"] = ""
                    paraDict3["reqkpwd"] = ""
                    paraDict3["realName"] = "会员"
                    paraDict3["cagent"] = "YHH"
                    paraDict3["isMobile"] = "1"
                    paraDict3["proxyname"] = ""
                    paraDict3["remark"] = ""
                    paraDict3["weixin"] = "12345"
                    NetWorkRequest(.register(parameters: paraDict3)) { (responseString) -> (Void) in
                        print(responseString)
                    }
                }
            }
        }else if indexPath.row == 31 {
            var paraDict: [String:Any] = Dictionary()
            paraDict["tname"] = "YHHgo1234"
            paraDict["tpwd"] = "go1234"
            paraDict["imgcode"] = ""
            paraDict["savelogin"] = "1"
            paraDict["isMobile"] = "1"
            paraDict["isImgCode"] = "0"
            NetWorkRequest(.login(parameters: paraDict)) { (responseString) -> (Void) in
                print(responseString)
                let paraDict2: [String:Any] = Dictionary()
                NetWorkRequest(.paymentChannel(parameters: paraDict2)) { (responseString) -> (Void) in
                    print(responseString)
                }
            }
        }else if indexPath.row == 32 {
            
        }else{
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 10))
        
        return view
    }
}

