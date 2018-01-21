//
//  LoginViewController.swift
//  Hitch
//
//  Created by ios11 on 2017/10/14.
//  Copyright © 2017年 geek. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var visit: UIButton!
    @IBOutlet weak var regist: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: ImageButton!
    private let waiting = UIActivityIndicatorView(activityIndicatorStyle: .white)
    override func viewDidLoad() {
        super.viewDidLoad()
        waiting.center = CGPoint(x: loginButton.frame.width/2-30, y: loginButton.frame.height/2)
        waiting.hidesWhenStopped = true
        loginButton.addSubview(waiting)
        username.delegate = self
    }

    @IBAction func touchBackground(_ sender: Any) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    @IBAction func login(_ sender: ImageButton) {
        waiting.startAnimating()
        loginButton.isEnabled = false
        visit.isEnabled = false
        regist.isEnabled = false
        if username.text != "" && password.text != ""{
            let parameters:Parameters = [
                "username":username.text ?? "",
                "password":password.text ?? ""
            ]
            Alamofire.request("http://172.20.10.3:8000/login.php", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                dump(response)
                switch(response.result){
                case .success(let json):
                    let data = json as! [String:Any]
                    if(data["code"] as! Int != 200){
                        let ac = UIAlertController(title: "对不起", message: "用户名和密码not correct", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                        self.present(ac, animated: true, completion: nil)
                    }else{
                        UserDefaults.standard.set(data["token"], forKey: "token")
                        self.performSegue(withIdentifier: "next", sender: self)
                    }
                default:
                    break
                }
                self.loginButton.isEnabled = true
                self.visit.isEnabled = true
                self.regist.isEnabled = true
                self.waiting.stopAnimating()
            })
        }else{
            let ac = UIAlertController(title: "对不起", message: "请输入用户名和密码", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
            loginButton.isEnabled = true
            visit.isEnabled = true
            regist.isEnabled = true
            waiting.stopAnimating()
        }
    }
    
    @IBAction func visit(_ sender: UIButton) {
        let u = User()
        u.id = -1
        u.name = "游客"
        u.photo = UIImage(named: "defaultUser")
        HitchManager.manager.user = u
        
        self.performSegue(withIdentifier: "next", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        return true
    }

}
