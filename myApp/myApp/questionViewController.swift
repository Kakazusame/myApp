//
//  questionViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/05.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData 

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
    //結果のArray
    var resultArray:[NSDictionary] = []
    //ミスした問題
    var missQ = ""
    var missA = ""
    var missD = ""
    
    //ミスした問題、答えを入れる配列
    var missWords: [NSManagedObject] = []
    
    //ダミーのための配列
    var dummy = ""
    //ミス問題を出題するためのダミーの答えを入れる配列
    var dummyA:[NSDictionary] = []
    
    //空の配列を作成
    var contentQ:[String] = []
    var contentA:[String] = []
    var contentD:[String] = []
    
    // Timerクラスのインスタンス
    var timer = Timer()
    // Startボタンを押した時刻
    var startTime:Double = 0.0
    
    //正解音
    var correctAudioPlayer: AVAudioPlayer! = nil
    //不正解音
    var mistakeAudioPlayer: AVAudioPlayer! = nil
    
    //選択された行番号が受け渡されるプロパティ
    var passedIndex = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("渡された行番号：\(passedIndex)")
        //問題を表示
        readQuestion()
        RandomQuestions()
        //音を鳴らす
        correctSound()
        mistakeSound()
    }
    
    
    ///////ここから問題画面///////
    func readQuestion(){
            var filePath = ""
            //ファイルパスを取得
            if passedIndex == 0{
                read()
            }else if passedIndex == 1{
                filePath = Bundle.main.path(forResource:"Test01List", ofType:"plist")!
            }else if passedIndex == 2{
                filePath = Bundle.main.path(forResource:"Test02List", ofType:"plist")!
            }else if passedIndex == 5{
                filePath = Bundle.main.path(forResource:"acronym", ofType:"plist")!
            }
        
            if passedIndex == 0 {
                //プロパティリストからデータを取得（Dictionary型）
                //ミス問題がない時、今エラー出てるからそれを画像にする！！！！！！！！！！！
                let dic = NSDictionary(contentsOfFile: dummy)
                for (key,quiz) in dic!{
                    //必要なものリスト
                    let testdic:NSDictionary = quiz as! NSDictionary
                    let dummyAnswer:NSDictionary = ["answer":testdic["answer"]]
                    //リストを追加
                    dummyA.append(dummyAnswer)
                }
            } else {
                //プロパティリストからデータを取得（Dictionary型）
                let dic = NSDictionary(contentsOfFile: filePath)
                //let dic02 = NSDictionary(contentsOfFile: dummy)
                for (key,quiz) in dic! {
                    //必要なものリスト
                    let testdic:NSDictionary = quiz as! NSDictionary
                    let testinfo:NSDictionary = ["num":key,"answer":testdic["answer"],"question":testdic["question"],"detail":testdic["detail"]!]
                    //リストを追加
                    testList.append(testinfo)
                    //print(testList)
                }
            }
    }
    
    
    func  RandomQuestions(){
        
        //問題数の表示
        count += 1
        
        var RandomNumber:Int = Int(arc4random()) % testList.count
        //ミス問題がなかった時は押せないか画像出すかする。
        
        //今画面に表示したいデータの取得
        let detailInfo = testList[RandomNumber] as! NSDictionary
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["question"] as! String)
        print(detailInfo["answer"] as! String)
        print(detailInfo["detail"] as! String)
        
        let wordsAnswer:NSDictionary = ["question":detailInfo["question"] as! String, "answer":detailInfo["answer"] as! String, "detail":detailInfo["detail"] as! String]
        
        missQ = detailInfo["question"] as! String
        missA = detailInfo["answer"] as! String
        missD = detailInfo["detail"] as! String
        
        //問題を毎回resultArrayに入れる
        resultArray.append(wordsAnswer)
        
        //問題文
        questionLabel.text = "Q\(count).\(detailInfo["question"]!)"
        
        //正解の取得
        var correctSlang = testList[RandomNumber]
        //正解を4択から除外
        testList.remove(at: RandomNumber)
        
        var QList:[NSDictionary] = []
        
        for correct in testList {
            if correctSlang != correct {
                QList.append(correct)
            }
        }
        
        
        var selectBtn = [answerButtonOne,answerButtonTwo,answerButtonThree,answerButtonFour]
        if passedIndex == 0{
            for i in 0...3{
                let incorrectRandomNumber = Int(arc4random()) % dummyA.count
                let detailInfo = dummyA[incorrectRandomNumber]
                selectBtn[i]?.setTitle(detailInfo["answer"] as? String, for: UIControlState())
                //オブジェクトを削除、1回使用した選択肢を削除する
                //dummyA.remove(object: detailInfo)
            }
        }else {
            for i in 0...3{
                let incorrectRandomNumber = Int(arc4random()) % QList.count
                let detailInfo = QList[incorrectRandomNumber]
                selectBtn[i]?.setTitle(detailInfo["answer"] as? String, for: UIControlState())
                //オブジェクトを削除、1回使用した選択肢を削除する
                QList.remove(object: detailInfo)
            }
            //オブジェクトを削除、1回使用した選択肢を削除する
//            QList.remove(object: detailInfo)
        }

        //正解とボタンを一致させる
        var correctNumber:Int = Int(arc4random() % 4)
        correctNumber += 1
        CorrectAnswer = String(correctNumber)
        
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
        var btn: String = String(b.tag)
        pushBtn = btn

            switch CorrectAnswer{
                case pushBtn:
                    for (index, value) in contentQ.enumerated(){
                        if  value == missQ && passedIndex == 0 {

                            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                            let viewContext = appDelegate.persistentContainer.viewContext
                            let request: NSFetchRequest<MissWords> = MissWords.fetchRequest()


                            
                            let predicate = NSPredicate(format:"%K = %@","question",missQ)
                            request.predicate = predicate
                                do {
                                    let fetchResults = try viewContext.fetch(request)
                                    for result: AnyObject in fetchResults {
                                    let record = result as! NSManagedObject
                                    viewContext.delete(record)
                                    }
                                    try viewContext.save()
                                } catch let error as NSError {
                                    print("DBへの削除に失敗しました")
                                }
                        }
                    }
                    resultImage.image = #imageLiteral(resourceName: "yes.png")
                    resultImage.alpha = 0.7
                    correctQuestionNumber += 1
                    wordsJudgment.append("Good")
                    correctAudioPlayer.play()
                
                default:
                    resultImage.image = #imageLiteral(resourceName: "no.png")
                    resultImage.alpha = 0.7
                    wordsJudgment.append("Bad")
                    mistakeAudioPlayer.play()
                
                    
                    //AppDelegateを使う準備をしておく
                    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    //エンティティを操作するためのオブジェクトを作成
                    let viewContext = appD.persistentContainer.viewContext
                    let MissWords = NSEntityDescription.entity(forEntityName: "MissWords", in: viewContext)
                    //エンティティにレコード(行)を挿入するためのオブジェクトを作成
                    let mistakeWord = NSManagedObject(entity: MissWords!, insertInto: viewContext)
                    //レコードオブジェクトに値のセット
                    mistakeWord.setValue(missQ, forKeyPath: "question")
                    mistakeWord.setValue(missA, forKeyPath: "answer")
                    mistakeWord.setValue(missD, forKeyPath: "detail")
                    //レコード(行)の即時保存
                    do {
                        try viewContext.save()
                        missWords.append(mistakeWord)
                    } catch let error as NSError {
                        print("DBへの保存に失敗しました")
                    }
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
            if passedIndex > 0 &&  quiznum == 2{
                quiznum += 1
                //次のコントローラーへ遷移する
                self.performSegue(withIdentifier: "toResultView", sender: nil)
                //ゲーム画面→結果表示画面のViewControllerにプロパティの値を渡す
                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let newVC = segue.destination as! ResultViewController
                    newVC.correctQuestionNumber = self.correctQuestionNumber
                }
            }else if testList.count == 0{
                //次のコントローラーへ遷移する
                self.performSegue(withIdentifier: "toResultView", sender: nil)
                //ゲーム画面→結果表示画面のViewControllerにプロパティの値を渡す
                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let newVC = segue.destination as! ResultViewController
                    newVC.correctQuestionNumber = self.correctQuestionNumber
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
        
        //Good,Bad
        appDelegate.Judgment = wordsJudgment
        //問題解いた順
        appDelegate.Answer = resultArray
        
    }
    
    
    ///////ここから音///////
   
    //正解音の作成
    func correctSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "correct_answer3", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            correctAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        correctAudioPlayer.volume = 0.3
        correctAudioPlayer.prepareToPlay()
    }
    
    //不正解音の作成
    func mistakeSound() {
        // サウンドファイルのパスを生成
        let soundFile = Bundle.main.path(forResource: "mistake_answer", ofType: "mp3")! as NSString
        let soundClear = URL(fileURLWithPath: soundFile as String)
        //AVAudioPlayerのインスタンス化
        do {
            mistakeAudioPlayer = try AVAudioPlayer(contentsOf: soundClear as URL, fileTypeHint:nil)
        }catch{
            print("AVAudioPlayerインスタンス作成失敗")
        }
        mistakeAudioPlayer.volume = 0.5
        mistakeAudioPlayer.prepareToPlay()
    }
    
    ///////ここまで音///////
    
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

    //////////CoreData/////////

    //既に存在するデータの読み込み処理
    func read(){

        //配列の初期化
        contentQ = []
        contentA = []
        
        //AppDelegateを使う準備をしておく
        let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appD.persistentContainer.viewContext
        //データを取得するエンティティの指定　検索の準備ができました
        let query: NSFetchRequest<MissWords> = MissWords.fetchRequest()

        do {
            //データの一括取得
            let fetchResults = try viewContext.fetch(query)
            //取得したデータを、デバックエリアにループで表示
            for result: AnyObject in fetchResults {
                let question : String = result.value(forKey: "question") as! String
                let answer : String = result.value(forKey: "answer") as! String
                let detail : String = result.value(forKey: "detail") as! String

                contentQ.append(question)
                contentA.append(answer)
                
                //必要なものリスト
                //let testdic:NSDictionary = result as! NSDictionary
                let testinfo:NSDictionary = ["answer":answer,"question":question,"detail":detail]
                //リストを追加
                testList.append(testinfo)
                
                //plistを取得
                 dummy = Bundle.main.path(forResource:"Test01List", ofType:"plist")!
            }
            
        } catch {
            print("エラーがあります")
        }
    }

    /////ここまでCoreData///////
    
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


