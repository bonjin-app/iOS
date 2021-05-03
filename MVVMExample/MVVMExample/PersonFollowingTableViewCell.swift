//
//  PersonFollowingTableViewCell.swift
//  MVVMExample
//
//  Created by gigas on 2021/04/27.
//

import UIKit

protocol PersonFollowingTableViewCellDelegate: AnyObject {
    func personFollowingTableViewCell(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingTableViewCell: UITableViewCell {
    static let identifier = "PersonFollowingTableViewCell"
    
    weak var delegate: PersonFollowingTableViewCellDelegate?
    
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
        userImageView.image = viewModel.image
        
        if viewModel.currentlyFollowing {
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        } else {
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .link
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(userImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(button)
        contentView.clipsToBounds = true
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapButton() {
        guard let viewModel = viewModel else {
            return
        }
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        delegate?.personFollowingTableViewCell(self, didTapWith: newViewModel)
        
        prepareForReuse()
        configure(with: newViewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size
        userImageView.frame = CGRect(x: 5, y: 5,
                                     width: size.height-10,
                                     height: size.height-10)
        
        nameLabel.frame = CGRect(x: size.height,
                                     y: 0,
                                     width: size.width - size.height-10,
                                     height: size.height/2)
        
        usernameLabel.frame = CGRect(x: size.height,
                                     y: size.height/2,
                                     width: size.width - size.height-10,
                                     height: size.height/2)
        
        button.frame = CGRect(x: size.width-120,
                                     y: 10,
                                     width: 110,
                                     height: size.height-20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        usernameLabel.text = nil
        userImageView.image = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
    }
}
