//
//  ViewController.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/01/30.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

//値を渡すために使うメソッドを宣言します
@objc protocol senderDelegate{
    func wordsCategory(message:NSString)
    @objc optional func receiveWordsCategory(message:NSString)
}

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
     @IBAction func goBack(_ segue:UIStoryboardSegue) {}
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    //送る側の初期値
    var selectedIndex = -1
    
    var testList:[NSDictionary] = []
    var category:[String] = []
    var imageNames:[String] = []

    
    //単語一覧に送る値
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.questionCategory = selectedIndex
    }
    
    //既に存在するデータの読み込み処理
    func read(){
        let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appD.persistentContainer.viewContext
        //データを取得するエンティティの指定　検索の準備ができました
        let query: NSFetchRequest<MissWords> = MissWords.fetchRequest()
        
        testList = []
        
        do {
            //データの一括取得
            let fetchResults = try viewContext.fetch(query)
            //取得したデータを、デバックエリアにループで表示
            for result: AnyObject in fetchResults {
                let question : String = result.value(forKey: "question") as! String
                let answer : String = result.value(forKey: "answer") as! String
                let detail : String = result.value(forKey: "detail") as! String
                //必要なものリスト
                let testinfo:NSDictionary = ["answer":answer,"question":question,"detail":detail]
                
            testList.append(testinfo)
            }
            
            if testList.count == 0 {
                category = ["Goodスラング","Badスラング","恋愛系","日常会話","略語",]
                imageNames = ["goodwords.jpeg","badwords.jpg","couple.jpeg","talk.jpeg","words.jpeg"]
            }else{
                category = ["Goodスラング","Badスラング","恋愛系","日常会話","略語","ミス問題"]
                imageNames = ["goodwords.jpeg","badwords.jpg","couple.jpeg","talk.jpeg","words.jpeg","misswords.jpeg"]
            }
        }catch {
            print("エラーがあります")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        categoryCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        admobDisplay()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        read()
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CustomCell
        
        
        cell.myLabel?.text = category[indexPath.row]
        cell.categoryImage.image = UIImage(named: imageNames[indexPath.row])

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "nextSegue", sender: nil)
        
    }
    
    //セルをデバイスサイズに合わせて調整
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - margin*3) / 2
        let height = width
        return CGSize(width: width, height: height)
    }
    
    let margin:CGFloat = 25.0
    
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
    
    //広告
    let AdMobID = "ca-app-pub-3940256099942544/6300978111" //バナーのID
    let  TEST_DEVICE_ID = "4bb3b480efde916314b75cca8d881f39" //個別のiphoneのID入れます
    let AdMobTest:Bool = true //切り替えようのフラグ
    let SimulatorTest:Bool = true //切り替えようのフラグ
    
    func admobDisplay(){
        
        var admobView: GADBannerView = GADBannerView()//初期化してる
        admobView = GADBannerView(adSize: kGADAdSizeBanner)//kGADAdSizeBannerでバナーのサイズを
        print("バナーのサイズ",admobView)
        admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - admobView.frame.height)
        
        admobView.frame.size = CGSize(width: self.view.frame.width, height: admobView.frame.height)
        
        admobView.adUnitID = AdMobID
        admobView.rootViewController = self
        
        let admobRequest:GADRequest = GADRequest()
        
        if AdMobTest{
            if SimulatorTest{
                admobRequest.testDevices = [kGADSimulatorID]
            }else{
                admobRequest.testDevices = [TEST_DEVICE_ID]
            }
        }
        admobView.load(admobRequest)
        self.view.addSubview(admobView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func insetFor


}

