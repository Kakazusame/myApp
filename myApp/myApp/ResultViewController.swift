//
//  ResultViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/06.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var percentageLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

    //正答率を表示
        //percentageLabel.text = NSString;; stringWithFormat:@"%d %%", _correctPercentage];
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
