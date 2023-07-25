//
//  NewReleasesColelctionViewCell.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/18/23.
//

import UIKit
import SDWebImage

//struct NewReleasesCellViewModel {
//    let name: String
//    let artworkURL: URL?
//    let numberOfTracks: Int
//    let artistName: String
//}

class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"

    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberOfTracksLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14,weight: .thin)
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
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        albumNameLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        let imageize = contentView.height - 10
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageize, height: imageize)
        let albumNameSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width - 10, height: contentView.height - 10))
        
        albumNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: 5,
            width: albumNameSize.width,
            height: 30)
        
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: albumNameLabel.bottom + 5,
            width: contentView.width - albumCoverImageView.right - 10,
            height: 30
        )
        

        numberOfTracksLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: contentView.bottom - 30,
            width: contentView.width - albumCoverImageView.right - 10,
            height: 30)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
        numberOfTracksLabel.text = nil
       
    }
    
    func configure(with viewModel:NewReleasesCellViewModel){
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL,completed: nil)
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        
    }
}
