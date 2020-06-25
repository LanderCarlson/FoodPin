//
//  NavigationController.swift
//  FoodPin
//
//  Created by Adrian Koo on 25/06/20.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import Foundation
class NavigationController {

override var preferredStatusBarStyle : UIStatusBarStyle {

if let topVC = viewControllers.last {
    //return the status property of each VC, look at step 2
    return topVC.preferredStatusBarStyle
}
    return .default
}

