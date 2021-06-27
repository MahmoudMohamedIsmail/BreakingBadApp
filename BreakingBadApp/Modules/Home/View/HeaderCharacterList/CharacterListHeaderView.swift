//
//  CharacterListHeaderView.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/26/21.
//

import UIKit

class CharacterListHeaderView: UIView {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        let title_lbl = Helper.createLabel(text: "BREAKING BAD", font: DesignSystem.Typography.footnote.font, textColor: .white)
        let discription_lbl = Helper.createLabel(text: "CHARACTER LIST", font: DesignSystem.Typography.headline.font, textColor: DesignSystem.Colors.primaryYellow.color)
        
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.addArrangedSubview(title_lbl)
        containerStackView.addArrangedSubview(discription_lbl)
        
        
        self.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }

}
