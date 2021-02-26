//
//  ViewController.swift
//  HomeCook
//
//  Created by Onur Cevik on 22.02.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let recipeCardView: HCRecipeCardView = {
        let view = HCRecipeCardView(
            recipe: .init(id: 1,
                          name: "Recipe 1",
                          ingredients: [ .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon),
                                         .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon)],
                          cook: .init(id: 1,
                                      username: "Onur",
                                      profileImageURL: nil),
                          instructions: "Instructions",
                          duration: 30,
                          difficulty: .Meh))
        return view
    }()
    
    let recipeCardView2: HCRecipeCardView = {
        let view = HCRecipeCardView(
            recipe: .init(id: 1,
                          name: "Recipe 1",
                          ingredients: [ .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon),
                                         .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon)],
                          cook: .init(id: 1,
                                      username: "Onur",
                                      profileImageURL: nil),
                          instructions: "Instructions",
                          duration: 30,
                          difficulty: .Meh))
        return view
    }()
    
    let recipeCardView3: HCRecipeCardView = {
        let view = HCRecipeCardView(
            recipe: .init(id: 1,
                          name: "Recipe 1",
                          ingredients: [ .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon),
                                         .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon)],
                          cook: .init(id: 1,
                                      username: "Onur",
                                      profileImageURL: nil),
                          instructions: "Instructions",
                          duration: 30,
                          difficulty: .Meh))
        return view
    }()
    
    let recipeCardView4: HCRecipeCardView = {
        let view = HCRecipeCardView(
            recipe: .init(id: 1,
                          name: "Recipe 1",
                          ingredients: [ .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon),
                                         .init(id: 1,
                                               name: "Butter",
                                               amount: 2,
                                               unit: .TableSpoon)],
                          cook: .init(id: 1,
                                      username: "Onur",
                                      profileImageURL: nil),
                          instructions: "Instructions",
                          duration: 30,
                          difficulty: .Meh))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(recipeCardView)
        view.addSubview(recipeCardView2)
        view.addSubview(recipeCardView3)
        view.addSubview(recipeCardView4)

        recipeCardView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(200)
        }
        
        recipeCardView2.snp.makeConstraints { (make) in
            make.top.equalTo(recipeCardView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(200)
        }
        
        recipeCardView3.snp.makeConstraints { (make) in
            make.top.equalTo(recipeCardView2.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(200)
        }
        
        recipeCardView4.snp.makeConstraints { (make) in
            make.top.equalTo(recipeCardView3.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(200)
        }
    }


}

