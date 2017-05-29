//
//  NavigationController.swift
//  Test3
//
//  Created by Chloe Hutchings on 29/05/2017.
//  Copyright © 2017 Chloe Hutchings. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        
        let image = UIImage()
        
        //self.navigationBar.setBackgroundImage(‌​image, for: .default)
        self.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationBar.shadowImage = image
        self.navigationBar.isTranslucent = true
    }
}
