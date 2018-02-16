//
//  ResultViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/06.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
     var audioPlayerClear : AVAudioPlayer! = nil //クリア時用
    
    //questionViewControllerより引き渡される値を格納する
    var correctQuestionNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //正答率を表示
        resultLabel.text = String(correctQuestionNumber)
        //音を鳴らす
        resultSound()
        self.audioPlayerClear.play()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
