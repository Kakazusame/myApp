//
//  detailsViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/25.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit
import GoogleMobileAds

class detailsViewController: UIViewController {

    @IBOutlet weak var detailText: UITextView!
    
    //値が受け渡されるプロパティ
    var resultArray:[String : String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailText.text = resultArray["detail"]
        detailText.isEditable = false //編集不可(読み取り専用)
        
        admobDisplay()
        
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //広告
    let AdMobID = "ca-app-pub-1548033216312406/2523859590" //バナーのID
    let  TEST_DEVICE_ID = "4bb3b480efde916314b75cca8d881f39" //個別のiphoneのID入れます
    let AdMobTest:Bool = true //切り替えようのフラグ
    let SimulatorTest:Bool = true //切り替えようのフラグ
    
    func admobDisplay(){
        
        var admobView: GADBannerView = GADBannerView()//初期化してる
        admobView = GADBannerView(adSize: kGADAdSizeBanner)//kGADAdSizeBannerでバナーのサイズを
        print("バナーのサイズ",admobView)
        admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - admobView.frame.height)
        
        admobView.frame.size = CGSize(width: self.view.frame.width, height: admobView.frame.height)
        
        admobView.adUnitID = AdMobID
        admobView.rootViewController = self
        
        let admobRequest:GADRequest = GADRequest()
        
        if AdMobTest{
            if SimulatorTest{
                admobRequest.testDevices = [kGADSimulatorID]
            }else{
                admobRequest.testDevices = [TEST_DEVICE_ID]
            }
        }
        admobView.load(admobRequest)
        self.view.addSubview(admobView)
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
