//
//  ViewController.swift
//  Demo
//
//  Created by ElitechMBPi502 on 25/12/17.
//  Copyright © 2017 ElitechMBPi502. All rights reserved.
//


//https://medium.com/@wasinwiwongsak/uicollectionview-with-autosizing-cell-using-autolayout-in-ios-9-10-84ab5cdf35a2

import UIKit


struct Article :Codable{
    let title: String
    let description: String
}
class collCell: UICollectionViewCell{
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var widthCell: NSLayoutConstraint!
    var numberInd:Int!{
        didSet{
            awakeFromNib()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screen = UIScreen.main.bounds.size.width - 25

        if numberInd != nil{
            if numberInd%3 == 0{
                widthCell.constant = screen
            }else{
                widthCell.constant = screen / 2
            }
        }
       
        
        
        print(numberInd)
    }
    
}


class ViewController: UIViewController {

    var items: Int = 0 {
        didSet {
            print(items)
        }
        
//        didSet {
//            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
//        }
    }
    @IBOutlet weak var CollDataList: UICollectionView!
    var dataList:[String] = ["His flowing robe by falchion torn , And crimson as those clouds of mom That , streak'd wieh dusky red , portend The day shall have a storruy end? (;) (*) « Kom , kom , » interrompeerde nu Jagtmans , een gepensioneerd artillerie-officier, die veel van de zwaar* moedige en met hevige natuurtooneelen doorspekte dichtkunst ..",
                             "RED CROSS.SALES DEPOT. The committee of the Red Cross Sales Depot wish to thank the following donors of gifts received during the past week:— Mr...",
                             "in after years of the storruy days of the civil war? If the soldier is still living it is possible that this item may in souie way be brouirht to his atteution, aud it may be of iuterest to hini to know tlie fale of the monument to his arniy serv","His flowing robe by falchion torn , And crimson as those clouds of mom That , streak'd wieh dusky red , portend The day shall have a storruy end? (;) (*) « Kom , kom , » interrompeerde nu Jagtmans , een gepensioneerd artillerie-officier, die veel van de zwaar* moedige en met hevige natuurtooneelen doorspekte dichtkunst ..",
                             "RED CROSS.SALES DEPOT. The committee of the Red Cross Sales Depot wish to thank the following donors of gifts received during the past week:— Mr...",
                             "in after years of the storruy days of the civil war? If the soldier is still living it is possible that this item may in souie way be brouirht to his atteution, aud it may be of iuterest to hini to know tlie fale of the monument to his arniy serv"]
    
    
    var person = ("S","B")
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = CollDataList.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        LoadApi()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func LoadApi()
    {
        let urlString = "https://swift.mrgott.pro/blog.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            
            do {
                
                let articlesData = try JSONDecoder().decode([Article].self, from: data)
                //Get back to the main queue
                DispatchQueue.main.async {
                    //print(articlesData)
                    print(articlesData)
                    
                }
            }
            catch let josnerror{
                print(josnerror)
            }
            
            }.resume()
    }
 

}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collCell", for: indexPath) as! collCell
        cell.numberInd = indexPath.row
        cell.lblData.text = dataList[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        items += 1
    }
    
    
}
