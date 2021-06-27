//
//  BannerCell.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/25/21.
//

import UIKit

class BannerCell: UICollectionViewCell {

    var model:String?{
        didSet{
            configure()
        }
    }
    @IBOutlet weak var bannerImage_ImgView: DesignableUIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func configure(){
        guard let imageStr = model else {return}
        self.bannerImage_ImgView.image = UIImage(named: imageStr)
    }
}
