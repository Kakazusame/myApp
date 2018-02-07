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
    
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var testList:[NSDictionary] = []
    
    //問題数をカウント
    var count = 0
    
    //正解ボタン
    var CorrectAnswer = String()
    
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
        RandomNumber += 1
        
        //問題数の表示
        count += 1
        
        //ファイルパスを取得
        let filePath = Bundle.main.path(forResource:"Test01List", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        
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
            print(incorrectRandomNumber, 1)
            print(incorrectRandomNumber, 2)
            print(incorrectRandomNumber, 3)
            print(incorrectRandomNumber, 4)
            print(detailInfo["answer"] as! String)
            selectBtn[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
            
            //オブジェクトを削除、1回使用した選択肢を削除する
            //QList.remove(at: detailInfo)
            
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



    }
    
    ///////ここまで画面//////////

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


