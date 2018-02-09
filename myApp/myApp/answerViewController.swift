//
//  answerViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/08.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

class answerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var listView: UITableView!
    
    //プロパティリストから読み込んだデータを格納する配列
    var wordsList:[NSDictionary] = []
    
    //選択された行番号が受け渡されるプロパティ
    var passedIndex = -1
    
    //テーブルビューの選択不可

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("渡された問題番号：\(passedIndex)")
        
        var filePath = ""
        //ファイルパスを取得
        if passedIndex == 0{
            filePath = Bundle.main.path(forResource:"Test01List", ofType:"plist")!
            
        }else if passedIndex == 1{
            filePath = Bundle.main.path(forResource:"Test02List", ofType:"plist")!
        }
        
        //let filePath = Bundle.main.path(forResource:"Test01List", ofType:"plist")
        //プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath)
        
        for (key,quiz) in dic! {
            //必要なものリスト
            let testdic:NSDictionary = quiz as! NSDictionary
            let testinfo:NSDictionary = ["question":key,"answer":testdic["answer"]!]
            //リストを追加
            wordsList.append(testinfo)
        }
        
    }
    
    //行数のカウント
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsList.count
    }
    
    //一行に表示する文字列の作成、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wordCell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! customWordCellTableViewCell
        
        //表示したい文字・画像の設定
        var wordsinfo = wordsList[indexPath.row] as! NSDictionary
        print(wordsinfo["question"] as! String)
        print(wordsinfo["answer"] as! String)
        
        //文字の表示
        wordCell.questionLabel.text = wordsinfo["question"] as? String
        wordCell.answerLabel.text = wordsinfo["answer"] as? String
        
        //文字を設定したセルを返す
        return wordCell
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
