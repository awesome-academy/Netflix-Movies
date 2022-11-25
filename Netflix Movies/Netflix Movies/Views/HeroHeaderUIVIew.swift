//
//  HeroHeaderUIVIew.swift
//  Netflix Movies
//
//  Created by Khanh on 16/11/2022.
//

import UIKit

final class HeroHeaderUIVIew: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "enola-holmes-2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton: UIButton = {
       let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 3
        playButton.layer.cornerRadius = 5
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private let infoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.setBackgroundImage(UIImage(systemName: "info.circle"), for: .selected)
        infoButton.isSelected = true
        infoButton.tintColor = .white
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        return infoButton
    }()
    
    private let myListButton: UIButton = {
        let myListButton = UIButton()
        myListButton.setBackgroundImage(UIImage(systemName: "plus"), for: .selected)
        myListButton.isSelected = true
        myListButton.tintColor = .white
        myListButton.translatesAutoresizingMaskIntoConstraints = false
        return myListButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        
        addGradient()
        addSubview(playButton)
        addSubview(infoButton)
        addSubview(myListButton)
        applyContraints()
    }
    
    func applyContraints() {
        let playButtonConstrains = [
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let infoButtonConstrains = [
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            infoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            infoButton.widthAnchor.constraint(equalToConstant: 35),
            infoButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let myListButtonConstrains = [
            myListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            myListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            myListButton.widthAnchor.constraint(equalToConstant: 35),
            myListButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        NSLayoutConstraint.activate(playButtonConstrains)
        NSLayoutConstraint.activate(infoButtonConstrains)
        NSLayoutConstraint.activate(myListButtonConstrains)
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
