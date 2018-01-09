//
//  SecondController.swift
//  SOImgaeView
//
//  Created by 董家祎 on 2018/1/8.
//  Copyright © 2018年 董家祎. All rights reserved.
//

import UIKit

class SecondController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     imageView.image  = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
