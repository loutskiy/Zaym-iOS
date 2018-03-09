//
//  LoadVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class LoadVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserCache.isLogin() {
            if UserCache.isClient() {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientVC")
                self.present(vc!, animated: true, completion: nil)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserVC")
                self.present(vc!, animated: true, completion: nil)
            }
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC")
            self.present(vc!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
