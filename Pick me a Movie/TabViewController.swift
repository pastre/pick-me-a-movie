//
//  TabViewController.swift
//  Pick me a Movie
//
//  Created by Bruno Pastre on 03/05/19.
//  Copyright © 2019 Bruno Pastre. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = tabBar.items?.firstIndex(of: item)!
        if index == 1{
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
