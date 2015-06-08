//
//  PassbookCell.swift
//  PassbookLayout
//
//  Created by 田程元 on 15/3/23.
//  Copyright (c) 2015年 田程元. All rights reserved.
//

import UIKit

class PassbookCell: UICollectionViewCell {
    @IBOutlet weak var labelTitle: UILabel! 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let names = ["card","card"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setStyle(style:Int){
        imageView.image = UIImage(named: "card")
        labelTitle.text = CatDic[style].name
    } 
}
