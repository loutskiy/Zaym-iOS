//
//  HideKeyboard.swift
//  Zachetka
//
//  Created by Mikhail Lutskiy on 16.02.2018.
//  Copyright © 2018 BigBadBird. All rights reserved.
//

import UIKit

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
