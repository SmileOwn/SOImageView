//
//  ViewController.swift
//  SOImgaeView
//
//  Created by 董家祎 on 2017/12/21.
//  Copyright © 2017年 董家祎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var soImageView: SOImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func buttonAction(_ sender: Any) {
        
        let storeboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storeboard.instantiateViewController(withIdentifier: "SecondController") as! SecondController
        controller.image  = soImageView.test()
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

