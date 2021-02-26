//
//  HCRecipeCardView.swift
//  HomeCook
//
//  Created by Onur Cevik on 26.02.2021.
//

import UIKit

protocol HCRecipeCardViewDelegate: class {
    func onTap()
}

class HCRecipeCardView: UIView {
    var recipe: Recipe {
        didSet {
            
        }
    }
    weak var delegate: HCRecipeCardViewDelegate?
    
    init(recipe: Recipe, delegate: HCRecipeCardViewDelegate? = nil) {
        self.recipe = recipe
        self.delegate = delegate
        super.init(frame: .zero)
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setDropShadow(to: [self], withStyles: [.Card])
    }
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        backgroundColor = .white
        layer.cornerRadius = 25
    
        
//        bgImageView.snp.makeConstraints { (make) in
//            make.top.left.right.bottom.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
