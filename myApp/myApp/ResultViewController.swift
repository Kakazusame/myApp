//
//  ResultViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/06.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var resultImage: UIImageView!
    var audioPlayerClear : AVAudioPlayer! = nil //クリア時用
    
    @IBOutlet weak var homeConstraint: NSLayoutConstraint!
    @IBOutlet weak var answerConstraint: NSLayoutConstraint!
    
    //questionViewControllerより引き渡される値を格納する
    var correctQuestionNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultImage.image = #imageLiteral(resourceName: "Slug.jpg")
        //正答率を表示
        resultLabel.text = String(correctQuestionNumber)
        //音を鳴らす
        resultSound()
        self.audioPlayerClear.play()
        
        homeConstraint.constant = UIScreen.main.bounds.width * 90/414
        answerConstraint.constant = UIScreen.main.bounds.width * 260/414
        
        admobDisplay()
    }
    
    // MARK: サウンドファイル作成
    func resultSound() {
        //Clear音作る。
        //音声ファイルのパスを作る。
        let soundFilePathClear : NSString = Bundle.main.path(forResource: "result02", ofType: "mp3")! as NSString
        let soundClear : NSURL = NSURL(fileURLWithPath: soundFilePathClear as String)
        //AVAudioPlayerのインスタンス化
        do{
            audioPlayerClear = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("Failed AVAudioPlayer Instance")
        }
        //出来たインスタンスをバッファに保持する。
        audioPlayerClear.prepareToPlay()
    }
    
    //広告
    let AdMobID = "ca-app-pub-1548033216312406/2523859590" //バナーのID
    let  TEST_DEVICE_ID = "4bb3b480efde916314b75cca8d881f39" //個別のiphoneのID入れます
    let AdMobTest:Bool = false //切り替えようのフラグ
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
