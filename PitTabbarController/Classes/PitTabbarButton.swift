//
//  PitTabbarButton.swift
//  Walsh

import UIKit

class PitTabbarButton: UIControl {

	/// perporties
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    private lazy var textLabel: UILabel = {
        let l = UILabel()
		l.alpha = 0
		l.textColor = .white
        l.textAlignment = .center
		l.font = UIFont.systemFont(ofSize: 11)
        return l
    }()
    
	///
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = layoutMarginsGuide
        
        imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        textLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		textLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -1).isActive = true
    }
    
    override var isSelected: Bool {
        get { return super.isSelected }
        set {
            super.isSelected = newValue
            
            if newValue {
                self.textLabel.alpha = 0
                self.textLabel.transform = CGAffineTransform(translationX: 0, y: 20)
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseInOut) {
                    self.imageView.transform = CGAffineTransform(translationX: 0, y: -20)
                    self.textLabel.alpha = 1
					self.textLabel.transform = UIDevice.current.isNotch ? CGAffineTransform(translationX: 0, y: 10)
												: .identity
                }

            }
            else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseInOut) {
                    self.imageView.transform = .identity
                    self.textLabel.alpha = 0
                    self.textLabel.transform = CGAffineTransform(translationX: 0, y: 20)
                }
            }
        }
    }
}
