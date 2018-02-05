//
//  ViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/01/30.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
     @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    //送る側の初期値
    var selectedIndex = -1
    
    var category = ["あいさつ","デート","アプローチ","喧嘩","メール","トイレ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    //セルを作るときの関数
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cellオブジェクトの作成
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CustomCell
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        //ラベルに文字表示
        cell.myLabel?.text = category[indexPath.row]
        
        //作成したcellオブジェクトを戻り値として返す
        return cell
    }
    
    //セルをタップした時に発動
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //選択された行番号をメンバ変数に保存
        selectedIndex = indexPath.row
        print("\(category[indexPath.row])")
        //セグエの名前を指定して、画面繊維処理を発動
        performSegue(withIdentifier: "nextSegue", sender: nil)
    }
    //セグエを使って画面遷移してる時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        //移動先の画面のインスタンスを取得
        let svc: secondViewCellViewController = segue.destination as! secondViewCellViewController
        //移動先の画面のプロパティに選択された行番号を代入（これで、DetailViewControllerに選択された行番号が渡せる）
        svc.passedIndex = selectedIndex
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

