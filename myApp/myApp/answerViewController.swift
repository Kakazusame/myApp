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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //plistを参照
        let filePath = Bundle.main.path(forResource: "Test01List", ofType: "plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        for (key,quiz) in dic! {
            //必要なものリスト
            let testdic:NSDictionary = quiz as! NSDictionary
            let testinfo:NSDictionary = ["question":key,"answer":testdic["answer"]!]
            //リストを追加
            wordsList.append(testinfo)
            //print(wordsList)
        }
        
    }
    
    //行数のカウント
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsList.count
    }
    
    //一行に表示する文字列の作成、表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wordCell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        //表示したい文字の設定
        //indexPath.row 今表示しようとしている行の行番号。0からスタート
        //cell.textLabel?.text = "\(indexPath.row)行目"
        wordCell.textLabel?.text = wordsList[indexPath.row] as! String
        
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
