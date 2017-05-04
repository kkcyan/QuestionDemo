//
//  ViewController.swift
//  QuestionDemo
//
//  Created by 范玉杰 on 2017/5/4.
//  Copyright © 2017年 范玉杰. All rights reserved.
//


import UIKit

class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var views = [UIView]()
    let imgArr = ["IMG_0812.JPG","IMG_0813.JPG","IMG_0814.JPG","IMG_0815.JPG","IMG_0816.JPG"]
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv: UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (self.view.bounds.height)), collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.isDirectionalLockEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ///regist
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        //CollectionView Customization
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.view.addSubview(self.collectionView)
        
        for title in imgArr {
            let bgView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            
            let imgV : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            imgV.image = UIImage.init(named: title)
            bgView.addSubview(imgV)
            
            views .append(bgView)
        }
        
        let jumpB: UIButton = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.width-60, y: 20, width: 40, height: 40))
        jumpB.setTitle("跳过", for: .normal)
        jumpB.setTitleColor(UIColor.lightGray, for: .normal)
        jumpB.layer.masksToBounds = true
        jumpB.layer.cornerRadius = 20
        jumpB.layer.borderColor = UIColor.lightGray.cgColor
        jumpB.backgroundColor = UIColor.white
        jumpB.addTarget(self, action: #selector(ViewController.clickJumpBtn), for: .touchUpInside)
        jumpB.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        jumpB.titleLabel?.textAlignment = .center
        self.view.addSubview(jumpB)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func clickJumpBtn(){
        let nav: UINavigationController = UINavigationController.init(rootViewController: Find_QuestionNewViewController.init())
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
    
    //MARK: CollectionView DataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.addSubview(views[indexPath.row])
        return cell
    }
    
    //MARK: CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height ))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == imgArr.count-1 {
            
            let nav: UINavigationController = UINavigationController.init(rootViewController: Find_QuestionNewViewController.init())
            UIApplication.shared.keyWindow?.rootViewController = nav
        }
    }
}
