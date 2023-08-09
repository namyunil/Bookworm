//
//  BookWormAssignmentTableViewCell.swift
//  Bookworm
//
//  Created by NAM on 2023/08/10.
//

import UIKit

class BookWormAssignmentTableViewCell: UITableViewCell {

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        contentLabel.font = .systemFont(ofSize: 13)
        contentLabel.numberOfLines = 0
        
        infoLabel.numberOfLines = 0
        infoLabel.font = .boldSystemFont(ofSize: 13)
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        bookImageView.contentMode = .scaleToFill
    }

    
}
