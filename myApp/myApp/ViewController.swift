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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cellオブジェクトの作成
        let cell:CustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        
        //背景色とタイトルの変更
        switch indexPath.row {
            
        case 0:
            
            cell.backgroundColor = .red
            cell.myLabel.text = "あいさつ";
            
        case 1:
            
            cell.backgroundColor = .blue
            cell.myLabel.text = "デート";
            
        case 2:
            
            cell.backgroundColor = .orange
            cell.myLabel.text = "アプローチ";
            
        case 3:
            
            cell.backgroundColor = .yellow
            cell.myLabel.text = "喧嘩";
            
        case 4:
            
            cell.backgroundColor = .gray
            cell.myLabel.text = "メール";
            
        case 5:
            
            cell.backgroundColor = .purple
            cell.myLabel.text = "トイレ";
            
        default:break
        }
        
        //作成したcellオブジェクトを戻り値として返す
        return cell
    }
    
    //ボタンをタップしたとき
    @IBAction func tapBtn(_ sender: UIButton) {
        print("問題を解く")
        performSegue(withIdentifier: "nextSegue", sender: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

