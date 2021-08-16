//
//  ProfileViewController.swift
//  Navigation
//

import UIKit

class ProfileViewController: UIViewController {
    
    let header = ProfileHederView()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
    lazy var  originalCenter = self.header.avatarImageView.center
    lazy var  originalTransform = self.header.avatarImageView.transform
    let closeButton = UIButton()
    let hiddenView = UIView()
    
    
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
        originalCenter = self.header.avatarImageView.center
        originalTransform = self.header.avatarImageView.transform
        
        
        hiddenView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        hiddenView.backgroundColor = .darkGray
        view.addSubview(hiddenView)

        view.insertSubview(header.avatarImageView, aboveSubview: hiddenView)
        //header.avatarImageView.superview?.bringSubviewToFront(header.avatarImageView)

        
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.63) {

                self.header.avatarImageView.center = self.view.center
                let scaleFactor = self.view.bounds.width / self.header.avatarImageView.bounds.width
                self.header.avatarImageView.transform = self.header.avatarImageView.transform.scaledBy(x: scaleFactor, y: scaleFactor)
                self.header.avatarImageView.layer.cornerRadius = 0
                self.hiddenView.alpha = 0.5
            }
            UIView.addKeyframe(withRelativeStartTime: 0.63, relativeDuration: 0.37) {
                self.closeButton.frame = CGRect(x: self.view.frame.width - 30, y: 50, width: 30, height: 30)
                self.closeButton.setTitleColor(UIColor.white, for: .normal)
                self.closeButton.addTarget(self, action: #selector(self.tapCloseButton), for: .touchUpInside)
                self.closeButton.setImage(UIImage(named: "close.png"), for: .normal)
                self.view.addSubview(self.closeButton)
            }
            
        }, completion: { finished in
                print(finished)
        })
        
    }
    
    @objc func tapCloseButton() {

        self.view.willRemoveSubview(header.avatarImageView)
        
        UIView.animate(withDuration: 0.5) {

        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.view.insertSubview(self.hiddenView, aboveSubview: self.header.avatarImageView)
                self.header.avatarImageView.center = self.originalCenter
                self.header.avatarImageView.transform = self.originalTransform
             self.header.avatarImageView.layer.cornerRadius = self.header.avatarImageView.frame.size.width / 2
                self.hiddenView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                self.view.willRemoveSubview(self.hiddenView)
             
                self.closeButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                self.view.willRemoveSubview(self.closeButton)
            }
        }
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
