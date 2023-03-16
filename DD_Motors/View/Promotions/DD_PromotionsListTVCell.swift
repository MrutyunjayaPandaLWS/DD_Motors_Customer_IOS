//
//  DD_PromotionsListTVCell.swift
//  DD_Motors
//
//  Created by syed on 16/03/23.
//

import UIKit


protocol PromotionsDelegate{
    func didTappedViewDetails(item: DD_PromotionsListTVCell)
}

class DD_PromotionsListTVCell: UITableViewCell {

    @IBOutlet weak var promotionNameLbl: UILabel!
    @IBOutlet weak var promotionImage: UIImageView!
    var delegate: PromotionsDelegate?
    var promotionDetails: LstPromotionJsonList?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didTappedViewBtn(_ sender: UIButton) {
        delegate?.didTappedViewDetails(item: self)
    }
}
