//
//  RecommendedTrackCollectionViewCell.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/18/23.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    
    private let artistNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init (frame:CGRect){
        super.init(frame: frame)
        //contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        //contentView.backgroundColor = .secondarySystemBackground
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = true
//
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        trackNameLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        
        let imageize = contentView.height - 10
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageize, height: imageize)
        let albumNameSize = trackNameLabel.sizeThatFits(CGSize(width: contentView.width - 10, height: contentView.height - 10))
        
        trackNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: 5,
            width: albumNameSize.width,
            height: 30 )
        
        
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: trackNameLabel.bottom + 2,
            width: contentView.width - albumCoverImageView.right - 10,
            height: min(20, albumNameSize.height)
        )
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
       
    }
    
    func configure(with viewModel:RecommendedTrackCellViewModel){
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artWorkURL,completed: nil)
        
    }
}
