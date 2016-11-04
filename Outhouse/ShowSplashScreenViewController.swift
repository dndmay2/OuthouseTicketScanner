//
//  ShowSplashScreenViewController.swift
//  Outhouse
//
//  Created by Derek May on 8/22/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import UIKit

class ShowSplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
print("spot 1")
        // Do any additional setup after loading the view.
        perform(#selector(ShowSplashScreenViewController.showNavController), with: nil, afterDelay: 2)
    }
    
    func showNavController()
    {
print("spot 2")
        performSegue(withIdentifier: "showSplashScreen", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
