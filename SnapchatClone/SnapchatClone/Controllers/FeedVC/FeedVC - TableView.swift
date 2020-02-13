//
//  FeedVC - TableViewFunctions.swift
//  SnapchatClone
//
//  Created by Max Miranda on 9/18/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSnaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath[1]
        // look at DateFormatter documentation to figure out how to convert a SnapImage.timeSent to a label's text
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
            as! FeedTableViewCell

        cell.senderLabel?.text = arrayOfSnaps[index].sender
        cell.dateSentLabel?.text = formatter.string(from: arrayOfSnaps[index].timeSent)
        if (arrayOfSnaps[index].opened) {
            cell.hasBeenOpenedSquare.layer.borderColor = UIColor.red.cgColor
        } else {
            cell.hasBeenOpenedSquare.layer.backgroundColor = UIColor.red.cgColor
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath[1]
        let cellSelected = arrayOfSnaps[index]
        let snapImage = SnapImage.init(sentBy: cellSelected.sender, sentTo: cellSelected.sentTo, timeSent: cellSelected.timeSent, image: cellSelected.image)
        arrayOfSnaps[index].opened = true
        selectedImage = snapImage
        performSegue(withIdentifier: "toShowImage", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
