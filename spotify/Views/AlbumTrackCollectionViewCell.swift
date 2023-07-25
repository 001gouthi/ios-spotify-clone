//
//  AlbumTrackCollectionViewCell.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/19/23.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "AlbumTrackCollectionViewCell"
    
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
        
        let albumNameSize = trackNameLabel.sizeThatFits(CGSize(width: contentView.width - 10, height: contentView.height - 10))
        
        trackNameLabel.frame = CGRect(
            x: 10,
            y: 5,
            width: albumNameSize.width,
            height: 30 )
        
        
        
        artistNameLabel.frame = CGRect(
            x: 10,
            y: trackNameLabel.bottom + 2,
            width: contentView.width - 10,
            height: min(20, albumNameSize.height)
        )
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        
       
    }
    
    func configure(with viewModel:RecommendedTrackCellViewModel){
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        
    }
}

