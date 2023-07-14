//
//  DD_NotificationTVC.swift
//  DD_Motors
//
//  Created by ADMIN on 29/12/2022.
//

import UIKit

protocol NotificationDelegate{
    func didTappedImageBtn(imageName: String)
    
}
class DD_NotificationTVC: UITableViewCell {

    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var thickMarkImager: UIImageView!
    @IBOutlet weak var notificationMessageLbl: UILabel!
    @IBOutlet weak var notificationTitleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    var delegate: NotificationDelegate?
    var imageName: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didTappedImageBtn(_ sender: Any) {
        if imageName != ""{
        delegate?.didTappedImageBtn(imageName: imageName)
        }
    }
}
