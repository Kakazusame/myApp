//
//  secondViewCellViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/01/31.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

class secondViewCellViewController: UIViewController{

    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var myText: UITextField!
    
    //選択された行番号が受け渡されるプロパティ
    var passedIndex = -1 //渡されていないことを判別するために-1を代入

    override func viewDidLoad() {
        super.viewDidLoad()
        print("渡された行番号：\(passedIndex)")
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
