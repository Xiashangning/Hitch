//
//  User.swift
//  Hitch
//
//  Created by Oliver Lau on 8/12/17.
//  Copyright © 2017 geek. All rights reserved.
//

import UIKit
import ASIHTTPRequest

class User {
    var id:Int!
    var name:String!
    var password:String!
    var info:String!
    //缓存策略
    private var photoCache:UIImage? = nil
    var photo:UIImage!{
        get{
            if let cache = photoCache{
                return cache
            }else{
                //请求图片
                return UIImage(named: "defaultUser")
            }
        }
        set{
            photoCache = newValue
            //通知view刷新
            
        }
    }
    private var eventsCache:[String:[Event]] = [:]
    var favoriteEvent:[Event]!{
        get{
            if let cache = eventsCache["favorite"]{
                return cache
            }else{
                //请求
                
                //应返回event(正在加载中。。。)
                return [Event()]
            }
        }
        set{
            eventsCache["favorite"] = newValue
            //通知view刷新
            
        }
    }
    var registeredEvent:[Event]!{
        get{
            if let cache = eventsCache["registered"]{
                return cache
            }else{
                //请求
                
                //应返回event(正在加载中。。。)
                return [Event()]
            }
        }
        set{
            eventsCache["registered"] = newValue
            //通知view刷新
            
        }
    }
    var joinedEvent:[Event]!
    {
        get{
            if let cache = eventsCache["joined"]{
                return cache
            }else{
                //请求
                
                //应返回event(正在加载中。。。)
                return [Event()]
            }
        }
        set{
            eventsCache["joined"] = newValue
            //通知view刷新
            
        }
    }
    var postedEvent:[Event]!{
        get{
            if let cache = eventsCache["posted"]{
                return cache
            }else{
                //请求
                
                //应返回event(正在加载中。。。)
                return [Event()]
            }
        }
        set{
            eventsCache["posted"] = newValue
            //通知view刷新
            
        }
    }
    
    //验证用户名密码
    static func login(name: String, password: String)->Result{
        //网络请求
        
        let u = User()
        //初始化user
        
        HitchManager.manager.user = u
        //用户名错误或密码错误
        return (true,"")
    }
    //登出
    func logout()->Result{
        
        return (true,"")
    }
}
