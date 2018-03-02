//
//  ViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/01/30.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

//値を渡すために使うメソッドを宣言します
@objc protocol senderDelegate{
    func wordsCategory(message:NSString)
    @objc optional func receiveWordsCategory(message:NSString)
}

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
     @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    //送る側の初期値
    var selectedIndex = -1
    
    //単語一覧に送る値
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.questionCategory = selectedIndex
    }
    
    var category = ["ミス問題"," デート ","アプローチ","喧嘩","メール","略語"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CustomCell
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        
        cell.myLabel?.text = category[indexPath.row]

        
        return cell
    }
    
    //セルをタップした時に発動
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "nextSegue", sender: nil)
    }
    
    //セルをデバイスサイズに合わせて調整
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 例えば端末サイズの半分の width と height にして 2 列にする場合
        let width: CGFloat = (UIScreen.main.bounds.width - margin*3) / 2
        let height = width
        return CGSize(width: width, height: height)
    }
    
    let margin:CGFloat = 8.0
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    //セグエを使って画面遷移してる時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let qvc: questionViewController = segue.destination as! questionViewController
            qvc.passedIndex = selectedIndex

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func insetFor


}

