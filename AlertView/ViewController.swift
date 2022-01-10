//
//  ViewController.swift
//  AlertView
//
//  Created by 徐倩岚 on 2021/12/30.
//

import UIKit
import Photos

class ViewController: UIViewController {
    var oneview: UIView!
    private var btn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.yellow
        btn.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        return btn
    }()
    
    var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
            // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
            // Get its associated windows
                .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
                .first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn)
    
        //方式1：异步执行+主队列
        // viewDidload关于ui的操作都是在主队列主线程中运行
        // 异步闭包在当前runloop完成之后排队等待运行.在主线程运行
        //将安排闭包中包含的代码以异步方式在主调度队列上运行.主队列具有最高优先级，通常保留用于更新UI以最大程度地提高App响应速度.
        
       // 在主队列添加任务，
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {//等待当前runloop执行完当前任务viewdidload,viewwillappear之后,下一个runloop循环会执行这个任务
            print("start new thread")
            let view = UIView()
            view.backgroundColor = UIColor.red
            view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.keyWindow?.addSubview(view)
        }
        print("end thread")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 方式2：在viewDidload之后调用
//        oneview = UIView()
//        oneview.backgroundColor = UIColor.red
//        oneview.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        keyWindow?.addSubview(oneview)
    }
    
    @objc func btnAction() {
        oneview.removeFromSuperview()
    }
}

