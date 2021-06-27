
//
//  CharacterDetailsCell.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/27/21.
//

import UIKit
import SDWebImage


class CharacterDetailsCell: UICollectionViewCell {
    var characterModel:Character? {
        didSet{
            configure()
        }
    }

    @IBOutlet weak var characterImge_ImgView: UIImageView!
    
    @IBOutlet weak var characterName_lbl: UILabel!
    @IBOutlet weak var characterNickName_lbl: UILabel!
    
    @IBOutlet weak var characterAge_lbl: UILabel!
    @IBOutlet weak var characterOccupation_lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func configure(){
        guard let charcter = characterModel, let charcterImagPath = charcter.img else {return}
        characterImge_ImgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        characterImge_ImgView.sd_setImage(with: URL(string: charcterImagPath), completed: nil)

        characterName_lbl.text = charcter.name
        characterNickName_lbl.text = charcter.nickname?.uppercased()
        characterAge_lbl.text = charcter.birthday
        var occupation = ""
        charcter.occupation?.forEach({ (value) in
            occupation.append(value)
            occupation.append("\n")
        })
        characterOccupation_lbl.text = occupation
    
        
        // to make nickName Yellow and bold in case the character is jessy
        if charcter.nickname == "Cap n' Cook"{
            characterNickName_lbl.textColor = DesignSystem.Colors.primaryYellow.color
            characterNickName_lbl.font = UIFont(name: "Montserrat-Bold", size: 32)
        }
    }
    
}
