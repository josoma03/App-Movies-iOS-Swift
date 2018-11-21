//
//  VideoViewCell.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 20/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit


protocol VideoDelegate{
    func showVideo(_ keyVideo: String)
}
class VideoViewCell: UITableViewCell {
    
    @IBOutlet weak var lblIso_639_1: UILabel!
    @IBOutlet weak var lblIso_3166_1: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSite: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    var delegate : VideoDelegate?
    var objVideo = VideoMovie()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func initWithEntity()
    {
        lblIso_639_1.text = objVideo.Iso_639_1
        lblIso_3166_1.text = objVideo.Iso_3166_1
        lblName.text = objVideo.Name
        lblSite.text = objVideo.Site
        lblSize.text = objVideo.Size.description
        lblType.text = objVideo.TypeVideo
        
        btnPlay.setTitle(Utils.stringNamed("Play"), for: .normal)
        btnPlay.backgroundColor = Utils.getColorFontBranding()
        btnPlay.layer.cornerRadius = 4
        btnPlay.layer.masksToBounds = true
    }
    
    
    @IBAction func playVideoAction(_ sender: Any) {
        self.delegate?.showVideo(objVideo.Key)
    }

}


