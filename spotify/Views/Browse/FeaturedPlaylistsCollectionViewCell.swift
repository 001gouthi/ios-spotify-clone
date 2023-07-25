//
//  FeaturedPlaylistsCollectionViewCell.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/18/23.
//

import UIKit

//struct FeaturedPlaylistsViewModel {
//    let name: String
//    let artWorkURL: URL?
//    let creatorName: String
//}

class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistsCollectionViewCell"

    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    
    private let creatorNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init (frame:CGRect){
        super.init(frame: frame)
        //contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistNameLabel.sizeToFit()
        creatorNameLabel.sizeToFit()
        
        let imageize = contentView.height - 10
        
        playlistCoverImageView.frame = CGRect(x: 5, y: 5, width: imageize, height: imageize)
        let albumNameSize = playlistNameLabel.sizeThatFits(CGSize(width: contentView.width - 10, height: contentView.height - 10))
        
        playlistNameLabel.frame = CGRect(
            x: playlistCoverImageView.right + 10,
            y: 5,
            width: albumNameSize.width,
            height: 30)
        
        
        creatorNameLabel.frame = CGRect(
            x: playlistCoverImageView.right + 10,
            y: playlistNameLabel.bottom + 5,
            width: contentView.width - playlistCoverImageView.right - 10,
            height: 30
        )
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
       
    }
    
    func configure(with viewModel:FeaturedPlaylistsViewModel){
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artWorkURL,completed: nil)
        
    }
}
