//
//  ViewController.swift
//  KTSS
//
//  Created by tangling on 16/5/10.
//  Copyright © 2016年 tangling. All rights reserved.
//

import UIKit
import SwiftHTTP

class ViewController: UIViewController {
    
    func toJSONString(dict:NSDictionary!)->NSData{
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
//        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
//        print(strJson)
//        return strJson!
        return data
        
    }
    
    func login(username: String, password: String, youName: String, url: String) -> Void {
        

        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        // 请求方式
        request.HTTPMethod = "POST"
        // 请求所使用的协议
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // 发送的数据
        request.HTTPBody = "username=\(username)&password=\(password)&yourName=\(youName)".dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            let string = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print (string)
            if string!.containsString("输入不能为空") {
                print ("请输入用户名和密码")
            }else if string!.containsString("登陆失败") {
                print("登陆失败")
            } else {
                print("登陆成功")
            }
        })
        task.resume()
    }
    
    @IBAction func button(sender: UIButton) {
        print("登陆按钮点击！")
        
        let username = userNameTextField.text!
        let password = passwordTextField.text!
        let youName = "1"
        
        login(username, password: password, youName: youName, url: "http://202.202.5.145:8080/plant/login.do")
    }
    
    @IBAction func regest(sender: UIButton) {
        print ("注册按钮点击")
//        print (userNameTextField.text)
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
}

