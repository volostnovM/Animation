//
//  ProfileViewController.swift
//  Navigation
//
//  Created by TIS Developer on 21.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let header = ProfileHederView()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
    
    private var tempStorage: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tempStoragePhoto: [Photo] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerID = String(describing:ProfileHederView.self)
    private let cellID = "cellID"
    private let cellPhoto = "cellPhoto"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        setupTableView()
        setupConstraints()
        
        self.tempStorage = Storage.arrayPost
        self.tempStoragePhoto = StoragePhoto.arrayPhoto
        
        header.avatarImageView.addGestureRecognizer(tapGesture)
        header.avatarImageView.isUserInteractionEnabled = true
    }

    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellPhoto)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func setupConstraints() {
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tapAvatar() {
        print("tap avatar")
        
        NSLayoutConstraint.deactivate(self.header.avatarConstraints)
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                       
                //self.header.avatarImageView.frame = CGRect(x: 0, y: self.view.bounds.height/2 - self.view.bounds.width/2, width: self.view.bounds.width, height: self.view.bounds.width)
                
                let avatarConstraints = [
                    self.header.avatarImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                    self.header.avatarImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                    self.header.avatarImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.bounds.width/2),
                    self.header.avatarImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -self.view.bounds.width/2),
                    self.header.avatarImageView.heightAnchor.constraint(equalToConstant: self.view.bounds.width),
                    self.header.avatarImageView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
                ]
                
                NSLayoutConstraint.activate(avatarConstraints)
                
            }
        }, completion: { finished in
                print(finished)
        })
    }
}



extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let openVC = PhotosViewController()
            navigationController?.isNavigationBarHidden = false
            openVC.title = "Photo Gallery"
            navigationController?.pushViewController(openVC, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return header
    }
}

extension ProfileViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard section == 1 else { return 1 }
        return tempStorage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhoto, for: indexPath) as! PhotosTableViewCell
            
            cell.contentPhoto = StoragePhoto.arrayPhoto[indexPath.row]
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
            
            cell.content = Storage.arrayPost[indexPath.row]
            
            return cell
        }
    }
}
