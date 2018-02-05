//
//  secondViewCellViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/01/31.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

//回答した番号の識別用enum
enum Answer: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
}

//ゲームに関係する定数
struct QuizStruct {
    static let timerDuration: Double = 10 //タイマーの時間
    static let dataMaxCount: Int = 5 //問題数
    static let limitTimer: Double = 10.000 //タイマーのリミット時間
    static let defaultCounter: Int = 10 //初期設定カウンター
}

class secondViewCellViewController: UIViewController,UINavigationBarDelegate,UITextViewDelegate{
    //戻る
    @IBOutlet weak var backButton: UIButton!
    //カウント
    @IBOutlet weak var countLabel: UILabel!
    //タイマー
    @IBOutlet weak var timerLabel: UILabel!
    //問題
    @IBOutlet weak var problemText: UITextField!
    //回答ボタン
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    
    //タイマー関連のメンバ変数
    var pastCounter: Int = 10
    var perSecTimer: Timer? = nil
    var doneTimer: Timer? = nil
    
    //問題関連のメンバ変数
    var counter: Int = 0
    
    //正解数と経過した時間
    var correctProblemNumber: Int = 0
    var totalSeconds: Double = 0.000
    
    //問題の内容を入れておくメンバ変数（今は計5問）
    var problemArray: NSMutableArray = []
    
    //選択された行番号が受け渡されるプロパティ
    var passedIndex = -1
    
    //問題毎の回答時間を算出するための時間を一時的に格納するためのメンバ変数
    var tmpTimerCount: Double!
    
    //タイム表示用のメンバ変数
    var timeProblemSolvedZero: Date!  //画面表示時点の時間
    var timeProblemSolvedOne: Date!   //第1問回答時点の時間
    var timeProblemSolvedTwo: Date!   //第2問回答時点の時間
    var timeProblemSolvedThree: Date! //第3問回答時点の時間
    var timeProblemSolvedFour: Date!  //第4問回答時点の時間
    var timeProblemSolvedFive: Date!  //第5問回答時点の時間
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
