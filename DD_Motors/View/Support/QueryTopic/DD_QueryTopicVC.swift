//
//  DD_QueryTopicVC.swift
//  DD_Motors
//
//  Created by ADMIN on 26/12/2022.
//

import UIKit
import Lottie
protocol SendTopicDelegate: AnyObject{
    func sendTopicTapped(_ vc: DD_QueryTopicVC)
}
class DD_QueryTopicVC: BaseViewController {

    @IBOutlet weak var queryTopicCollectionView: UICollectionView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderAnimation: LottieAnimationView!
    private var loaderAnimationView : LottieAnimationView?
    
    var selectedTopic = ""
    var selectedTopicId = -1
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var delegate: SendTopicDelegate!
    var VM = DD_QueryTopicVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.loaderView.isHidden = true
        queryTopicCollectionView.delegate = self
        queryTopicCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.bounds.width - 60 - (self.queryTopicCollectionView.contentInset.left + self.queryTopicCollectionView.contentInset.right)) / 2, height: 50)
        layout.minimumLineSpacing = 2.5
        layout.minimumInteritemSpacing = 2.5
        self.queryTopicCollectionView.collectionViewLayout = layout
        self.queryTopicCollectionView.reloadData()
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 36
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        getHelpTopicApi()
        
    }
    func getHelpTopicApi(){
        let parameter = [
            "ActionType": "4",
            "ActorId": "\(self.userID)",
               "IsActive": "true"
        ] as [String: Any]
        self.VM.helpTopiceListAPi(parameter: parameter)
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
extension DD_QueryTopicVC: UICollectionViewDataSource, UICollectionViewDelegate{
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.VM.helpTopicListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DD_QueryTopicCVC", for: indexPath) as! DD_QueryTopicCVC
        cell.topicLbl.text = self.VM.helpTopicListArray[indexPath.row].helpTopicName ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true){
            self.selectedTopic = self.VM.helpTopicListArray[indexPath.row].helpTopicName ?? ""
            self.selectedTopicId = self.VM.helpTopicListArray[indexPath.row].helpTopicId ?? -1
            self.delegate.sendTopicTapped(self)
            NotificationCenter.default.post(name: .navigateToNewQuery, object: nil)
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
