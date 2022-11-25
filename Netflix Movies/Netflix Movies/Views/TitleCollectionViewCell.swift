//
//  TitleCollectionViewCell.swift
//  Netflix Movies
//
//  Created by Khanh on 18/11/2022.
//

import UIKit
import SDWebImage

final class TitleCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private let network = APICaller.shared
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configuge(title: Title) {
        print(title.posterPath)
        if let logoURL = title.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/" + logoURL) {
            self.posterImageView.loadFrom(from: url)
        }
    }
}
