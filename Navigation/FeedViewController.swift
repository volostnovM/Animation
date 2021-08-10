//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let postOldButton = UIButton()
    let postNewButton = UIButton()
    
    let feedStack = UIStackView()
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        postOldButton.backgroundColor = .green
        postOldButton.setTitle("old post", for: .normal)
        postOldButton.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        postNewButton.backgroundColor = .black
        postNewButton.setTitle("new post", for: .normal)
        postNewButton.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        
        feedStack.addArrangedSubview(postOldButton)
        feedStack.addArrangedSubview(postNewButton)
        
        feedStack.axis = .vertical
        feedStack.spacing = 10
        feedStack.backgroundColor = .darkGray
        feedStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(feedStack)
        
        [
            feedStack.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor
            ),
            feedStack.centerYAnchor.constraint(
                equalTo: self.view.centerYAnchor
            )
        ]
        .forEach {
            $0.isActive = true
        }
    }
    
    @objc func buttonPress(sender: UIButton!) {
       print("Button Перейти tapped")
        let openVC = PostViewController()
        navigationController?.pushViewController(openVC, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
