//
//  DD_PromotionsVC.swift
//  DD_Motors
//
//  Created by syed on 16/03/23.
//

import UIKit
import Lottie
import Kingfisher


class DD_PromotionsVC: BaseViewController, UITableViewDelegate, UITableViewDataSource,PromotionsDelegate {
    func didTappedViewDetails(item: DD_PromotionsListTVCell) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_PromotionDetailsVC") as? DD_PromotionDetailsVC
        vc?.PromotionDetails = item.promotionDetails
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    @IBOutlet weak var loadarView: UIView!
    @IBOutlet weak var promotionListTV: UITableView!
    var VM = DD_PromotionsVM()
    var noofelements = 0
    var startindex = 1
    var timmer = Timer()
    private var loaderAnimationView : LottieAnimationView?
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        promotionListTV.delegate = self
        promotionListTV.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DD_IOS_Internet_Check") as! DD_IOS_Internet_Check
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }else{
            loadarView.isHidden = false
            emptyMessage.isHidden = true
            playAnimation2()
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
                self.VM.promotionArrayList.removeAll()
                self.promotionListApi()
            })
        }
    }
    
    @IBAction func didTappedBackBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func promotionListApi(){
        let parameter : [String : Any] = [
                "ActionType":"99",
                "ActorId": userID,
                "StartIndex": startindex,
                "PageSize":"10"
       ]
        self.VM.promotionListApi(parameter: parameter)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.promotionArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "DD_PromotionsListTVCell", for: indexPath) as! DD_PromotionsListTVCell
        cell.delegate = self
        cell.promotionNameLbl.text = self.VM.promotionArrayList[indexPath.row].promotionName
        let promotionImage = self.VM.promotionArrayList[indexPath.row].proImage?.dropFirst(3)
        if promotionImage?.count == 0{
            cell.promotionImage.image = UIImage(named: "ic_default_img")
        }else{
            cell.promotionImage.kf.setImage(with: URL(string: "\(PROMO_IMG1)\(promotionImage ?? "")"), placeholder: UIImage(named: "ic_default_img"))
        }
        cell.promotionDetails = self.VM.promotionArrayList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == VM.promotionArrayList.count - 1{
            if noofelements == 10{
                startindex = startindex + 1
                self.promotionListApi()
            }else if self.noofelements > 10{
                self.startindex = self.startindex + 1
                self.promotionListApi()
            }else if noofelements < 10{
                print("no need to hit API")
                return
            }else{
                print("n0 more elements")
                return
            }
        }
    }
    
    func playAnimation2(){
        loaderAnimationView = .init(name: "loader")
        loaderAnimationView!.frame = loaderAnimation.bounds
          // 3. Set animation content mode
        loaderAnimationView!.contentMode = .scaleAspectFill
          // 4. Set animation loop mode
        loaderAnimationView!.loopMode = .loop
          // 5. Adjust animation speed
        loaderAnimationView!.animationSpeed = 0.5
        loaderAnimation.addSubview(loaderAnimationView!)
          // 6. Play animation
        loaderAnimationView!.play()
    }
}
