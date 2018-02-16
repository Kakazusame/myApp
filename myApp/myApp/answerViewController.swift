//
//  answerViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/08.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit
import AVFoundation

class answerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var listView: UITableView!
    
    //選択された行番号が受け渡されるプロパティ
    var passedIndex = -1
    
    //値が受け渡されるプロパティ
    var wordsJudgment:[String] = []
    var resultArray:[NSDictionary] = []

    //グローバル変数での値受け取り
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        passedIndex = appDelegate.questionCategory!
        wordsJudgment = appDelegate.Judgment! as! [String]
        resultArray = appDelegate.Answer as! [NSDictionary]
        print(wordsJudgment)
        print(resultArray)
        
        
        //ファイルパスを取得
        var filePath = ""
        if passedIndex == 0{
            filePath = Bundle.main.path(forResource:"Test01List", ofType:"plist")!
            print("0番目の問題が読み込まれました")
            
        }else if passedIndex == 1{
            filePath = Bundle.main.path(forResource:"Test02List", ofType:"plist")!
            print("1番目の問題が読み込まれました")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //行数のカウント
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    //一行に表示する文字列の作成、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セルの選択不可
        self.listView.allowsSelection = false
        
        //セルの高さを変更
        self.listView.rowHeight = 70
        
        let wordCell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! customWordCellTableViewCell
        
        //表示したい文字・画像の設定
        var wordsinfo = resultArray[indexPath.row] as! NSDictionary
        //文字の表示
        wordCell.questionLabel.text = wordsinfo["question"] as? String
        wordCell.answerLabel.text = wordsinfo["answer"] as? String
        wordCell.judgeLabel.text = wordsJudgment[indexPath.row]
        
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
