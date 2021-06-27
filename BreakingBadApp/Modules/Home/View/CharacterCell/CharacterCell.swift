//
//  CharacterCell.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/26/21.
//

import UIKit
import SDWebImage


class CharacterCell: UITableViewCell {

    var characterModel:Character?{
        didSet{
            configure()
        }
    }
    @IBOutlet weak var contentBackground_View: DesignableUIView!{
        didSet{
            contentBackground_View.addBlurEffect()  
        }
    }
    
    @IBOutlet weak var characterImage_ImgView: DesignableUIImageView!
    
    @IBOutlet weak var characterName_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    private func configure(){
        guard let charcter = characterModel, let charcterImagPath = charcter.img, let characterName = charcter.name else {return}
        characterImage_ImgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        characterImage_ImgView.sd_setImage(with: URL(string: charcterImagPath), completed: nil)
        characterImage_ImgView.sd_imageTransition = .fade
        setup_lbl(with: characterName.uppercased())
    }
    
    private func setup_lbl(with characterName:String){
        let compontetsStr = characterName.components(separatedBy: " ")
        let boldIndex = ((compontetsStr.count - 1 ) / 2) * 2
        guard boldIndex >= 0 && boldIndex < compontetsStr.count  else {return}
        characterName_lbl.attributedText = nil
        characterName_lbl.attributedText = characterName.makePartOfStringBold(boldString: compontetsStr[boldIndex], font: characterName_lbl.font)
    }
}
