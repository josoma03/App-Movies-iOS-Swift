//
//  ShowVideoViewController.swift
//  TestRappi
//
//  Created by Jhonattan Solarte Martinez on 21/11/18.
//  Copyright © 2018 Rappi. All rights reserved.
//

import Foundation
import UIKit
import XCDYouTubeKit

class ShowVideoViewController:UIViewController
{
    @IBOutlet weak var videoContainerView: UIView!
    var keyVideo = ""
    var videoPlayerViewController = XCDYouTubeVideoPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showVideo()
    }
    override func viewDidDisappear(_ animated: Bool) {
        videoPlayerViewController.moviePlayer.stop()
    }
    
    func showVideo()
    {
        if(keyVideo != ""){
            videoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: keyVideo)
            let defaultCenter = NotificationCenter.default
            defaultCenter.addObserver(self, selector: #selector(self.videoPlayerViewControllerDidReceiveVideo(_:)), name: NSNotification.Name.XCDYouTubeVideoPlayerViewControllerDidReceiveVideo, object: videoPlayerViewController)
           /* defaultCenter.addObserver(self, selector: #selector(self.moviePlayerPlaybackDidFinish(_:)), name: .MPMoviePlayerPlaybackDidFinish, object: videoPlayerViewController.moviePlayer)*/
        }
    }
    
   /* @objc func moviePlayerPlaybackDidFinish(_ notification: Notification?) {
        let error = notification?.userInfo![XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey] as? Error
        if error != nil {
            //self.lblError.text = error?.localizedDescription
        }
    }*/
    
    @objc func videoPlayerViewControllerDidReceiveVideo(_ notification: Notification?) {
       /* let thumbnailURL: URL? = video?.thumbnailURL
        if let url = thumbnailURL {
            let request = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
                if let imageData = data as Data? {
                    DispatchQueue.main.async {
                        videoPlayerViewController.present(in: self.videoContainerView)
                        self.videoPlayerViewController.moviePlayer.play()
                    }
                }
            });
            task.resume()
        }*/
        DispatchQueue.main.async {
            self.videoPlayerViewController.present(in: self.videoContainerView)
            self.videoPlayerViewController.moviePlayer.play()
        }
    }
}
