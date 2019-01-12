//
//  MainViewController.swift
//  Snake
//
//  Created by User08 on 2019/1/6.
//  Copyright © 2019 AutumnCAT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 2.0)
        var myImageView = UIImageView(
            frame: CGRect(
                x: 0, y: 0, width: 50, height: 50))
        
        // 使用 UIImage(named:) 放置圖片檔案
        myImageView.image = UIImage(named: "2.jpg")
        self.view.addSubview(myImageView)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
