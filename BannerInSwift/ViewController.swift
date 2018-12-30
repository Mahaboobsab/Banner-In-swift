//
//  ViewController.swift
//  BannerInSwift
//
//  Created by Meheboob MacBook on 12/29/18.
//  Copyright © 2018 Suveechi. All rights reserved.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet weak var scrollViewTap: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var Images_Array: NSArray = NSArray()
    var Banner_array: [AnyHashable] = []
    var BannerImg_Url = ""
    var timer: Timer?
    var currentPage: Int = 0
    var banner_id: Int = 0
    var Banner_Tap: UITapGestureRecognizer?
    
    var pageIndex: Int = 0
    var decideToday: Int = 0
    var storeType = ""
    @IBOutlet var scrollView_tap: UIScrollView!
    @IBOutlet var image_tap: UIImageView!
    @IBOutlet var mall_map: UIImageView!
    @IBOutlet var sideBar: UIBarButtonItem!
    @IBOutlet var nav_Title: UILabel!
    @IBOutlet var imgChangeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Images_Array = ["http://www.beee2c.com/shopqatar/app/images/banners/ban_6.png?time=1546065101","http://www.beee2c.com/shopqatar/app/images/banners/ban_7.png?time=1546065101","http://www.beee2c.com/shopqatar/app/images/banners/ban_9.png?time=1546065101","http://www.beee2c.com/shopqatar/app/images/banners/ban_10.png?time=1546065101","http://www.beee2c.com/shopqatar/app/images/banners/ban_12.png?time=1546065101"]
        
        
        
        self.setupScrollViewImages()
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView_tap.frame.size.width // you need to have a **iVar** with getter for scrollView
        let fractionalPage = Float(scrollView_tap.contentOffset.x / pageWidth)
        let page = lround(Double(fractionalPage))
        if page == Images_Array.count {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage = page
        }
        
    }
    
    @objc func banner_Click(_ recognizer: UITapGestureRecognizer?) {
        
        let view: UIView? = recognizer?.view
        Banner_array = [Images_Array[view?.tag ?? 0]] as! [AnyHashable]
        print("Banner Tapped at index :\(String(describing: view?.tag)) and array :  \(Banner_array)")
        
    }
    
    @objc func scrollingTimer() {
        
        currentPage = currentPage + 1
        
        if currentPage == Images_Array.count {
            
            timer?.invalidate()
            timer = nil
            
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollingTimer), userInfo: nil, repeats: true)
            currentPage = 0
            
            
            let b =   self.scrollView_tap.frame.size.width
            
            
            let rect = CGRect(x: CGFloat(currentPage) * b, y: 0, width: b, height: scrollView_tap.frame.size.height)
            
            scrollView_tap.scrollRectToVisible(rect, animated: true)
            
            self.pageControl.currentPage = currentPage;
            
            
        } else {
            
            
            
            let b =   self.scrollView_tap.frame.size.width
            
            
            let rect = CGRect(x: CGFloat(currentPage) * b, y: 0, width: b, height: scrollView_tap.frame.size.height)
            
            scrollView_tap.scrollRectToVisible(rect, animated: true)
            self.pageControl.currentPage = currentPage;
            
            
        }
    }
    
    func setupScrollViewImages() {
        
        
        
        scrollView_tap.isScrollEnabled = true
        scrollView_tap.isPagingEnabled = true
        scrollView_tap.isUserInteractionEnabled = true
        pageControl.numberOfPages = Images_Array.count
        pageControl.currentPage = 0
        
        //banner_ScrView.userInteractionEnabled = YES;
        scrollView_tap.backgroundColor = UIColor.clear
        //setup internal views
        for i in 0..<Images_Array.count {
            let xOrigin: CGFloat = CGFloat(i) * scrollView_tap.frame.size.width
            image_tap = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: scrollView_tap.frame.size.width, height: scrollView_tap.frame.size.height))
            
            
            
            BannerImg_Url = Images_Array[i] as! String
            
            let combined = "\(BannerImg_Url)"
            
            
            
            image_tap.isUserInteractionEnabled = true
            //let imageURL = URL(string: combined)
            
            image_tap.sd_setImage(with: URL(string: combined), placeholderImage: UIImage(named: "placeholder.png"))
            
            
            
            
            image_tap.animationDuration = 0.3
            image_tap.startAnimating()
            image_tap.isUserInteractionEnabled = true
            
            
            Banner_Tap = UITapGestureRecognizer()
            //  [Banner_Tap addTarget:self action:@selector(Banner_Click:)]
            
            Banner_Tap?.addTarget(self,action:#selector(banner_Click(_:) ))
            image_tap.tag = i
            image_tap.addGestureRecognizer(Banner_Tap!)
            scrollView_tap.addSubview(image_tap)
            
        }
        scrollView_tap.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(Images_Array.count), height: scrollView_tap.frame.size.height)
        
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollingTimer), userInfo: nil, repeats: true)
        
        
        
        
    }
    
    
}

