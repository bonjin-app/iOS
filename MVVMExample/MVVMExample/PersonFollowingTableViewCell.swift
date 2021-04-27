//
//  PersonFollowingTableViewCell.swift
//  MVVMExample
//
//  Created by gigas on 2021/04/27.
//

import UIKit

class PersonFollowingTableViewCell: UITableViewCell {
    static let identifier = "PersonFollowingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
