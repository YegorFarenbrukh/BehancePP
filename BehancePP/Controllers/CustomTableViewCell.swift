//
//  CustomTableViewCell.swift
//  BehancePP
//
//  Created by apple on 7/31/20.
//  Copyright © 2020 GQt. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomCell()
    }
    
    // MARK: - Custom Cell setup
    private func setupCustomCell() {
        nameLabel.textColor = .white
        nameLabel.adjustsFontSizeToFitWidth = true
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.clipsToBounds = true
        
    }
}
