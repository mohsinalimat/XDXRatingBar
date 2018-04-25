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
    @objc optional func ratingWillChange(_ ratingBar: XDXRatingBar, oldRating: CGFloat, newRating: CGFloat)
    
    @objc optional func ratingDidChange(_ ratingBar: XDXRatingBar, oldRating: CGFloat, newRating: CGFloat)
}

@IBDesignable public class XDXRatingBar: UIView
{
    static let imageOfSelectedStars = UIImage(named: "Selected Star")!
    static let imageOfUnselectedStars = UIImage(named: "Unselected Star")!
    
    private var foregroundRatingView: UIView!
    private var backgroundRatingView: UIView!
    private var isDrawn = false
    
    @IBOutlet public weak var delegate: XDXRatingBarDelegate?
    
    @IBInspectable public var minRating: CGFloat                  = XDXRatingBarManager.shared.minRating                   ?? 1
    @IBInspectable public var maxRating: CGFloat                  = XDXRatingBarManager.shared.maxRating                   ?? 5
    @IBInspectable public var numberOfStars: Int                  = XDXRatingBarManager.shared.numberOfStars               ?? 5
    @IBInspectable public var animated: Bool                      = XDXRatingBarManager.shared.animated                    ?? true
    @IBInspectable public var animationTimeInterval: TimeInterval = XDXRatingBarManager.shared.animationTimeInterval       ?? 0.2
    @IBInspectable public var isDecimalRating: Bool               = XDXRatingBarManager.shared.isDecimalRating             ?? false
    @IBInspectable public var isIndicator: Bool                   = XDXRatingBarManager.shared.isIndicator                 ?? false
    @IBInspectable public var starWidthInsetRatio: CGFloat        = XDXRatingBarManager.shared.starWidthInsetRatio         ?? 0.05
    @IBInspectable public var imageForSelectedStars: UIImage      = XDXRatingBarManager.shared.imageForSelectedStars       ?? imageOfSelectedStars
    @IBInspectable public var imageForUnselectedStars: UIImage    = XDXRatingBarManager.shared.imageForUnselectedStars     ?? imageOfUnselectedStars
    @IBInspectable public var isDisplayingUnselectedStars: Bool   = XDXRatingBarManager.shared.isDisplayingUnselectedStars ?? true
    
    @IBInspectable public var rating: CGFloat = 1 {
        willSet {
            delegate?.ratingWillChange?(self, oldRating: rating, newRating: newValue)
        }
        didSet {
            if      minRating > rating { rating = minRating }
            else if maxRating < rating { rating = maxRating }
            delegate?.ratingDidChange?(self, oldRating: oldValue, newRating: rating)
            setNeedsLayout()
        }
    }
    
    override public func prepareForInterfaceBuilder()
    {
        super.prepareForInterfaceBuilder()
        layoutSubviews()
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        
        buildView()
        let timeInterval: TimeInterval = animated ? animationTimeInterval : 0
        
        UIView.animate(withDuration: timeInterval) {
            self.animatingRatingChange()
        }
    }
    
    private func buildView()
    {
        guard isDrawn == false else { return } 
        isDrawn = true
        
        if isDisplayingUnselectedStars { backgroundRatingView = createRatingView(image: imageForUnselectedStars) }
        foregroundRatingView = createRatingView(image: imageForSelectedStars)
        animatingRatingChange()
        addSubview(backgroundRatingView)
        addSubview(foregroundRatingView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRatingView))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    private func animatingRatingChange()
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
        guard isIndicator == false else { return }
        
        let tapPoint: CGPoint = sender.location(in: self)
        let offset: CGFloat = tapPoint.x
        
        let currentRating: CGFloat = offset / (bounds.size.width / maxRating)
        rating = isDecimalRating ? currentRating : round(currentRating)
    }
}

public class XDXRatingBarManager
{
    public static let shared = XDXRatingBarManager()
    
    public var minRating: CGFloat?
    public var maxRating: CGFloat?
    public var numberOfStars: Int?
    public var animated: Bool?
    public var animationTimeInterval: TimeInterval?
    public var isDecimalRating: Bool?
    public var isIndicator: Bool?
    public var starWidthInsetRatio: CGFloat?
    public var imageForSelectedStars: UIImage?
    public var imageForUnselectedStars: UIImage?
    public var isDisplayingUnselectedStars: Bool?
}
