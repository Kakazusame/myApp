//
//  questionViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/05.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit



class questionViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate{
    

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    
    @IBOutlet weak var resultImage: UIImageView!
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておく配列
    var testList:[NSDictionary] = []
    //問題数
    var quiznum = 1
    //問題数をカウント
    var count = 0
    //正解ボタン
    var CorrectAnswer = String()
    //正解数
    var correctQuestionNumber: Int = 0
    //何番目のボタンを押したのかを代入するメンバ変数
    var pushBtn:String! //ストリング型のメンバ変数
    //問題の解答を判断
    var wordsJudgment:[String] = []

    
    
    // Timerクラスのインスタンス
    var timer = Timer()
    // Startボタンを押した時刻
    var startTime:Double = 0.0
    
    
    //選択された行番号が受け渡されるプロパティ
    var passedIndex = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("渡された行番号：\(passedIndex)")
        //問題を表示
        RandomQuestions()
    }
    
    
    ///////ここから問題画面///////

    func  RandomQuestions(){
        
        var RandomNumber:Int = Int(arc4random() % 4)
        
        //問題数の表示
        count += 1
        
        var filePath = ""
        //ファイルパスを取得
        if passedIndex == 0{
            filePath = Bundle.main.path(forResource:"Test01List", ofType:"plist")!
        }else if passedIndex == 1{
            filePath = Bundle.main.path(forResource:"Test02List", ofType:"plist")!
        }
        
        //プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath)
        
        for (key,quiz) in dic! {
            //必要なものリスト
            let testdic:NSDictionary = quiz as! NSDictionary
            let testinfo:NSDictionary = ["question":key,"answer":testdic["answer"]!]
            //リストを追加
            testList.append(testinfo)
        }
        
        //今画面に表示したいデータの取得
        let detailInfo = testList[RandomNumber] as! NSDictionary
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["question"] as! String)
        print(detailInfo["answer"] as! String)
        
        let wordsAnswer:NSDictionary = ["question":detailInfo["question"] as! String, "answer":detailInfo["answer"] as! String]
        print(wordsAnswer)
        //問題を毎回wordsAnswerに入れる（append）
        //消える前に飛ばす処理
        
        for(key,data) in dic!{
            var _:NSDictionary = data as! NSDictionary
        }
        
        //問題文
        questionLabel.text = "Q\(count).\(detailInfo["question"]!)"
        
        //4択を表示（不正解）
        //正解の取得
        var correctSlang = testList[RandomNumber]
        //正解を4択から除外
        testList.remove(at: RandomNumber)
        
        var QList:[NSDictionary] = []
        
        for correct in testList {
            if correctSlang != correct {
                //print(correct["answer"] as! String)
                QList.append(correct)
            }
        }
        
        var selectBtn = [answerButtonOne,answerButtonTwo,answerButtonThree,answerButtonFour]
        for i in 0...3{
            
            let incorrectRandomNumber = Int(arc4random()) % QList.count
            
            let detailInfo = QList[incorrectRandomNumber]
            selectBtn[i]?.setTitle(detailInfo["answer"] as? String, for: UIControlState())
            
            //オブジェクトを削除、1回使用した選択肢を削除する
            QList.remove(object: detailInfo)
            
        }

        //正解とボタンを一致させる
        var correctNumber:Int = Int(arc4random() % 4)
        correctNumber += 1
        CorrectAnswer = String(correctNumber)
        //print(CorrectAnswer)
        
        if CorrectAnswer == "1" {
            answerButtonOne.setTitle(detailInfo["answer"] as? String, for: UIControlState())
        }else if CorrectAnswer == "2"{
            answerButtonTwo.setTitle(detailInfo["answer"] as? String, for: UIControlState())
        }else if CorrectAnswer == "3"{
            answerButtonThree.setTitle(detailInfo["answer"] as? String, for: UIControlState())
        }else if CorrectAnswer == "4"{
            answerButtonFour.setTitle(detailInfo["answer"] as? String, for: UIControlState())
        }else{
        }
    }
    
    //問題数を初期化する
    func resetproblemCount(){
        quiznum = 1
    }
    
    ///////ここまで画面//////////
    
    
    @IBAction func pushBtn(_ sender: UIButton) {
        // 開始した時刻を記録
        startTime = Date().timeIntervalSince1970
        
        //タップされたボタンの番号を取得
        let b:UIButton = sender
        //print(b.tag)
        var btn: String = String(b.tag)
        pushBtn = btn

            switch CorrectAnswer{
                case pushBtn:
                    resultImage.image = #imageLiteral(resourceName: "yes.png")
                    resultImage.alpha = 0.7
                    correctQuestionNumber += 1
                    wordsJudgment.append("Good")
                default:
                    resultImage.image = #imageLiteral(resourceName: "no.png")
                    resultImage.alpha = 0.7
                    wordsJudgment.append("Bad")
            }
        
        // 0.01秒ごとにupdateLabel()を呼び出す
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        // タイマーが完了するまでボタンを非活性にする
        allAnswerBtnDisabled()
        
    }

    @objc func updateLabel() {
        // 経過した時間を、現在の時刻-開始時刻で算出(秒)
        let elapsedTime = Date().timeIntervalSince1970 - startTime
        // 小数点以下を切り捨てる
        let flooredErapsedTime = Int(floor(elapsedTime))
        // 残り時間
        let leftTime = 2 - flooredErapsedTime
        UnHide()
        
        // 残り0秒になった時の処理
        if leftTime == 0 {
            // タイマーを止める
            timer.invalidate()
           
            //3問終わったらscore画面へ遷移
            if quiznum == 15{
                quiznum += 1
               
                //次のコントローラーへ遷移する
                self.performSegue(withIdentifier: "toResultView", sender: nil)
                
                //ゲーム画面→結果表示画面のViewControllerにプロパティの値を渡す
                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let newVC = segue.destination as! ResultViewController
                    newVC.correctQuestionNumber = self.correctQuestionNumber
                    print(correctQuestionNumber)
                }
                
            }else{
                //問題数までのアクション
                quiznum += 1
                RandomQuestions()
                // ボタンを押せるようにする
                allAnswerBtnEnabled()
                //画像を非表示にする
                Hide()
            }
        }
        
    }
    
    //セグエを呼び出したときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //セグエ名で判定を行う
        if segue.identifier == "toResultView" {
            //遷移先のコントローラーの変数を用意する
            let ResultViewController = segue.destination as! ResultViewController
            //遷移先のコントローラーに渡したい変数を格納（型を合わせる）
            ResultViewController.correctQuestionNumber = correctQuestionNumber as Int
        }
    }

    //単語一覧に送る値(消える前(別のコントローラーに移動する前)に実行する処理)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.Judgment = wordsJudgment
    }
    
    
    ///////ここからタイマー///////
    
    
    ///////ここまでタイマー///////
    
    //非表示にする関数
    func Hide(){
        resultImage.isHidden = true
    }
    func UnHide(){
        resultImage.isHidden = false
    }
    
    //全ボタンを非活性にする
    func allAnswerBtnDisabled() {
        answerButtonOne.isEnabled = false
        answerButtonTwo.isEnabled = false
        answerButtonThree.isEnabled = false
        answerButtonFour.isEnabled = false
    }
    //全ボタンを活性にする
    func allAnswerBtnEnabled() {
        answerButtonOne.isEnabled = true
        answerButtonTwo.isEnabled = true
        answerButtonThree.isEnabled = true
        answerButtonFour.isEnabled = true
    }

}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//重複を回避するためのエクステンション
extension Array where Element: Equatable {
    
    // すべてのオブジェクトを削除
    mutating func remove(object: Element) {
        if let index = index(of: object){
            self.remove(at: index)
            self.remove(object: object)
        }
    }
    
}


