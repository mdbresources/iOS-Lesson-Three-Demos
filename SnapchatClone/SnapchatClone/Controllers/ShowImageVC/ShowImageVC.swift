
//
//  ShowImageVC.swift
//  SnapchatClone
//
//  Created by Max Miranda on 9/18/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class ShowImageVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var snapImage: SnapImage!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
        imageView.image = snapImage.image
        nameLabel.text = snapImage.sender
    }
    
    @objc func done() {
        self.navigationController?.popViewController(animated: true)
    }
 
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 188, b: 255)
        navigationItem.title = ""
        navigationController?.navigationBar.barTintColor = UIColor(r: 0, g: 188, b: 255)
        navigationItem.setHidesBackButton(true, animated:true);
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
}
