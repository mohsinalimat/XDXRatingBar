//
//  XDXRatingBar.swift
//  XDXRatingBar
//
//  Created by 6谢侠6 (6xieapplexia6) on 2018/4/20.
//  Copyright © 2018年 6谢侠6 (6xieapplexia6). All rights reserved.
//

import UIKit

@objc public protocol XDXRatingBarDelegate: NSObjectProtocol
{
    func ratingDidChange(_ ratingBar: XDXRatingBar, rating: CGFloat)
}

@IBDesignable open class XDXRatingBar: UIView
{
    static let imageOfSelectedStars = UIImage(named: "Selected Star")!
    static let imageOfUnselectedStars = UIImage(named: "Unselected Star")!
    
    private var foregroundRatingView: UIView!
    private var backgroundRatingView: UIView!
    private var isDrawn = false
    
    @IBOutlet public weak var delegate: XDXRatingBarDelegate?
    
    @IBInspectable open var minRating: CGFloat                  = XDXRatingBarManager.shared.minRating                   ?? 1
    @IBInspectable open var maxRating: CGFloat                  = XDXRatingBarManager.shared.maxRating                   ?? 5
    @IBInspectable open var numberOfStars: Int                  = XDXRatingBarManager.shared.numberOfStars               ?? 5
    @IBInspectable open var animated: Bool                      = XDXRatingBarManager.shared.animated                    ?? true
    @IBInspectable open var animationTimeInterval: TimeInterval = XDXRatingBarManager.shared.animationTimeInterval       ?? 0.2
    @IBInspectable open var isDecimalRating: Bool               = XDXRatingBarManager.shared.isDecimalRating             ?? false
    @IBInspectable open var isIndicator: Bool                   = XDXRatingBarManager.shared.isIndicator                 ?? false
    @IBInspectable open var starWidthInsetRatio: CGFloat        = XDXRatingBarManager.shared.starWidthInsetRatio         ?? 0.05
    @IBInspectable open var imageForSelectedStars: UIImage      = XDXRatingBarManager.shared.imageForSelectedStars       ?? imageOfSelectedStars
    @IBInspectable open var imageForUnselectedStars: UIImage    = XDXRatingBarManager.shared.imageForUnselectedStars     ?? imageOfUnselectedStars
    @IBInspectable open var isDisplayingUnselectedStars: Bool   = XDXRatingBarManager.shared.isDisplayingUnselectedStars ?? true
    
    @IBInspectable open var rating: CGFloat = 1 {
        didSet {
            if      minRating > rating { rating = minRating }
            else if maxRating < rating { rating = maxRating }
            delegate?.ratingDidChange(self, rating: rating)
            setNeedsLayout()
        }
    }
    
    override open func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        layoutSubviews()
    }
    
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        
        buildView()
        let timeInterval: TimeInterval = animated ? animationTimeInterval : 0
        
        UIView.animate(withDuration: timeInterval) {
            self.animationRatingChange()
        }
    }
    
    private func buildView()
    {
        if isDrawn { return }
        isDrawn = true
        
        if isDisplayingUnselectedStars { backgroundRatingView = createRatingView(image: imageForUnselectedStars) }
        foregroundRatingView = createRatingView(image: imageForSelectedStars)
        animationRatingChange()
        addSubview(backgroundRatingView)
        addSubview(foregroundRatingView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRatingView))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    private func animationRatingChange()
    {
        let currentRating: CGFloat = rating / maxRating
        foregroundRatingView.frame = CGRect(x: 0,
                                            y: 0,
                                            width: bounds.size.width * currentRating,
                                            height: bounds.size.height)
    }
    
    private func createRatingView(image: UIImage) -> UIView
    {
        let view: UIView = UIView(frame: bounds)
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        
        for position in 0 ..< numberOfStars
        {
            let imageView = UIImageView(image: image)
            let x: CGFloat = CGFloat(position) * bounds.size.width / CGFloat(numberOfStars) + (bounds.size.width * starWidthInsetRatio) / 5
            let width: CGFloat = (bounds.size.width / CGFloat(numberOfStars)) * (1 - starWidthInsetRatio * 2)
            imageView.frame = CGRect(x: x, y: 0, width: width, height: bounds.size.height)
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
        }
        
        return view
    }
    
    @objc private func tapRatingView(sender: UITapGestureRecognizer)
    {
        if isIndicator { return }
        
        let tapPoint: CGPoint = sender.location(in: self)
        let offset: CGFloat = tapPoint.x
        
        let currentRating: CGFloat = offset / (bounds.size.width / maxRating)
        rating = isDecimalRating ? currentRating : round(currentRating)
    }
}

open class XDXRatingBarManager
{
    open static let shared = XDXRatingBarManager()
    
    open var minRating: CGFloat?
    open var maxRating: CGFloat?
    open var numberOfStars: Int?
    open var animated: Bool?
    open var animationTimeInterval: TimeInterval?
    open var isDecimalRating: Bool?
    open var isIndicator: Bool?
    open var starWidthInsetRatio: CGFloat?
    open var imageForSelectedStars: UIImage?
    open var imageForUnselectedStars: UIImage?
    open var isDisplayingUnselectedStars: Bool?
}
