//
//  TableViewCell.swift
//  To-do-list
//
//  Created by ineta.magone on 03/03/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    @IBOutlet weak var commonView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initView() {
        Bundle.main.loadNibNamed("cell", owner: self, options: nil)
        addSubview(commonView)
        NSLayoutConstraint.activate([
            commonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            commonView.topAnchor.constraint(equalTo: topAnchor),
            commonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        commonView.backgroundColor = .black
    }
    
}
