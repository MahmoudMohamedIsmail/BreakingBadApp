//
//  UIAlertController+Extension.swift

import UIKit

extension UIAlertController{
    
    func set(title: String = "", font: DesignSystem.Typography?, color: UIColor? ){
        let attributes = [NSAttributedString.Key.font: font?.font ?? DesignSystem.Typography.bigButton.font,
                          NSAttributedString.Key.foregroundColor: color ?? .black]
        let titleAttriburedString = NSMutableAttributedString(string: title, attributes: attributes)
        self.setValue(titleAttriburedString, forKey: "attributedTitle")
    }
    
    func set(message: String = "", font: DesignSystem.Typography?, color: UIColor?){
        let attributes = [NSAttributedString.Key.font: font?.font ?? DesignSystem.Typography.callout.font,
                          NSAttributedString.Key.foregroundColor: color ?? .black]
        let titleAttriburedString = NSMutableAttributedString(string: message, attributes: attributes)
        self.setValue(titleAttriburedString, forKey: "attributedMessage")
    }
    
    func addAction(name: String, style: UIAlertAction.Style, action: ((UIAlertAction)->Void)?, color: UIColor?, imageName:String? = nil) {
        
        if let imageName = imageName {
            let vc = ActionSheetContentViewController(title: name, imageName: imageName)
            let action = UIAlertAction(title: "", style: style, handler: action)
            action.setValue(vc, forKey: "contentViewController")
            self.addAction(action)
        }
        else{
            let action = UIAlertAction(title: name, style: style, handler: action)
            if let color = color {
                action.setValue(color, forKey: "titleTextColor")
            }
            
            self.addAction(action)
            
        }
    }
    
    //Set background color of UIAlertController
    func setBackgroudColor(color: UIColor) {
        if let bgView = self.view.subviews.first,
           let groupView = bgView.subviews.first,
           let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
}

class ActionSheetContentViewController: UIViewController {
    
    private var title_lbl:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private var image_ImgView:UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = DesignSystem.Colors.primaryGray.color
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        return imageView
    }()
    
    init(title:String, imageName:String, alignment:UIStackView.Alignment = .leading) {
        super.init(nibName: nil, bundle: nil)
        self.title_lbl.text = title
        self.image_ImgView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        self.containerStackView.alignment = alignment
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var containerStackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return stack
    }()
    
    func setupView() {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(image_ImgView)
        stackView.addArrangedSubview(title_lbl)
        
        containerStackView.arrangedSubviews.forEach{$0.removeFromSuperview()}
        containerStackView.addArrangedSubview(stackView)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
        ])
        
        view.layoutIfNeeded()
    }
    
    
}
