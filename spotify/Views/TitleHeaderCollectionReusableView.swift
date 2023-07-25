//
//  TitleHeaderCollectionReusableView.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/19/23.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
     static let identifier = "TitleHeaderCollectionReusableView"

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize:22,weight: .semibold)
        return label
    }()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 15, width: width - 30, height: 30)
        
    }
    
    func configure(with title: String){
        label.text = title
    }
}
