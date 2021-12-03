//
//  InvitationStack.swift
//  team10app
//
//  Created by GraceJoseph on 10/30/21.
//  Uses code from https://github.com/russ-stamant/Wallet/blob/master/Wallet/Classes/WalletView.swift
//

import Foundation
import UIKit

/**
 The InvitationStack class manages an ordered collection of card view and presents them.
 */
open class InvitationStack: UIView {
    
    // MARK: Public methods
    /**
     Initializes and returns a newly allocated wallet view object with the specified frame rectangle.
     
     - parameter aRect: The frame rectangle for the wallet view, measured in points.
     - returns: An initialized wallet view.
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        prepareInvitationStack()
        addObservers()
    }
    
    /**
     Returns a wallet view object initialized from data in a given unarchiver.
     
     - parameter aDecoder: An unarchiver object.
     - returns: A wallet view, initialized using the data in decoder.
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareInvitationStack()
        addObservers()
    }
    
    
    /**
     Reloads the wallet view with card views.
     
     - parameter cardViews: Card views to be inserted to the wallet view.
     */
    open func reload(cardViews: [InvitationCard]) {
        
        insert(cardViews: cardViews)
        calculateLayoutValues()
        
    }
    
    
    /**
     Presents a card view.
     
     - parameter cardView: A card view to be presented.
     - parameter animated: If true, the view is being added to the wallet view using an animation.
     - parameter completion: A block object to be executed when the animation sequence ends.
     */
    open func present(cardView: InvitationCard, animated: Bool, completion: LayoutCompletion? = nil) {
        
        present(cardView: cardView, animated: animated, animationDuration: animated ? InvitationStack.presentingAnimationSpeed : nil, completion: completion)
        
    }
    
    
    /**
     Dismisses the card view that was presented by the wallet view.
     
     - parameter animated: If true, the view is being removed from the wallet view using an animation.
     - parameter completion: A block object to be executed when the animation sequence ends.
     */
    open func dismissPresentedInvitationCard(animated: Bool, completion: LayoutCompletion? = nil) {
        
        dismissPresentedInvitationCard(animated: animated, animationDuration: animated ? InvitationStack.dismissingAnimationSpeed : nil, completion: completion)
        
    }
    
    
    /**
     Inserts a card view to the beginning of the receiver’s list of card views.
     
     - parameter cardView: A card view to be inserted.
     - parameter animated: If true, the view is being added to the wallet view using an animation.
     - parameter presented: If true, the view is being added to the wallet view and presented right way.
     - parameter completion: A block object to be executed when the animation sequence ends.
     */
    open func insert(cardView: InvitationCard, animated: Bool = false, presented: Bool = false,  completion: InsertionCompletion? = nil) {
        
        presentedInvitationCard = presented ? cardView : self.presentedInvitationCard
        
        if animated {
            
            let y = scrollView.convert(CGPoint(x: 0, y: frame.maxY), from: self).y
            cardView.frame = CGRect(x: 0, y: y, width: frame.width, height: cardViewHeight)
            cardView.layoutIfNeeded()
            scrollView.insertSubview(cardView, at: 0)
            
            UIView.animateKeyframes(withDuration: InvitationStack.insertionAnimationSpeed, delay: 0, options: [.beginFromCurrentState, .calculationModeCubic], animations: { [weak self] in
                
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
                    self?.insert(cardViews: [cardView] + (self?.insertedInvitationCardViews ?? []))
                    self?.layoutInvitationStack(placeVisibleInvitationCardViews: false)
                })
                
                }, completion: { [weak self] (_) in
                    
                    self?.reload(cardViews: self?.insertedInvitationCardViews ?? [])
                    completion?()
                    
            })
            
            
        } else {
            reload(cardViews: [cardView] + insertedInvitationCardViews)
            placeVisibleInvitationCardViews()
            completion?()
        }
        
    }
    
    /**
     Removes the specified card view from the wallet view.
     
     - parameter cardView: A card view to be removed.
     - parameter animated: If true, the view is being remove from the wallet view using an animation.
     - parameter completion: A block object to be executed when the animation sequence ends.
     
     */
    open func remove(cardView: InvitationCard, animated: Bool = false,  completion: RemovalCompletion? = nil) {
        
        if animated {
            
            let removalBlock = removalAnimation()
            present(cardView: cardView, animated: true, completion: { [weak self] (_) in
                self?.presentedInvitationCard = nil
                removalBlock(cardView, completion)
            })
            
        } else {
            remove(cardViews: [cardView])
            completion?()
        }
        
    }
    
    /**
     Removes the specified card views from the wallet view.
     
     - parameter cardViews: Card views to be removed.
     
     */
    open func remove(cardViews: [InvitationCard]) {
        
        let newInsertedInvitationCardViews = insertedInvitationCardViews.filter { !cardViews.contains($0) }
        
        if let presentedInvitationCard = presentedInvitationCard, !newInsertedInvitationCardViews.contains(presentedInvitationCard) {
            self.presentedInvitationCard = nil
        }
        
        if newInsertedInvitationCardViews.count == 1 {
            presentedInvitationCard = newInsertedInvitationCardViews.first
        }
        
        reload(cardViews: newInsertedInvitationCardViews)
    }
    
    /** The desirable card view height value. Used when the wallet view has enough space. */
    public var preferableInvitationCardViewHeight: CGFloat = .greatestFiniteMagnitude { didSet { calculateLayoutValues() } }
    
    /** Number of card views to show in the bottom of the wallet view when presenting card view. */
    public var maximimNumberOfCollapsedInvitationCardViewsToShow: Int = 5 { didSet { calculateLayoutValues() } }
    
    /** The positioning of card views relative to each other when the wallet view is not presenting a card view. */
    public var minimalDistanceBetweenStackedInvitationCardViews: CGFloat = 52 { didSet { calculateLayoutValues() } }
    
    /** Use this property to use fixed distance between card views */
    public var useHeaderDistanceForStackedCards: Bool = false { didSet { calculateLayoutValues() } }
    
    /** The positioning of card views relative to each other when the wallet view is presenting a card view. */
    public var minimalDistanceBetweenCollapsedInvitationCardViews: CGFloat = 8 { didSet { calculateLayoutValues() } }
    
    /** The positioning of card views relative to the receiver’s presenting card view. */
    public var distanceBetweetCollapsedAndPresentedInvitationCardViews: CGFloat = 10 { didSet { calculateLayoutValues() } }
    
    /** The pop up offset of a card view when a long tap detected. */
    public var grabPopupOffset: CGFloat = 20 { didSet { calculateLayoutValues() } }
    
    /** The total duration of the animations when the card view is being presented. */
    public static var presentingAnimationSpeed: TimeInterval = 0.35
    
    /** The total duration of the animations when the card view is being dismissed. */
    public static var dismissingAnimationSpeed: TimeInterval = 0.35
    
    /** The total duration of the animations when the card view is being insertred. */
    public static var insertionAnimationSpeed: TimeInterval = 0.6
    
    /** The total duration of the animations when the card view is being removed. */
    public static var removalAnimationSpeed: TimeInterval = 1.0
    
    /** The total duration of the animations when the card view is being grabbed. */
    public static var grabbingAnimationSpeed: TimeInterval = 0.2
    
    /** This block is called after the receiver’s card view is presented. */
    public var didPresentInvitationCardBlock: PresentedInvitationCardDidUpdateBlock?
    
    /** Returns an accessory view that is displayed above the wallet view. */
    @IBOutlet public weak var walletHeader: UIView? {
        willSet {
            if let walletHeader = newValue {
                scrollView.addSubview(walletHeader)
            }
        }
        didSet {
            oldValue?.removeFromSuperview()
            calculateLayoutValues()
        }
    }
    
    
    /** The card view that is presented by this wallet view. */
    public var presentedInvitationCard: InvitationCard? {
        
        didSet {
            oldValue?.presented = false
            presentedInvitationCard?.presented = true
            didPresentInvitationCardBlock?(presentedInvitationCard)
        }
        
    }
    
    
    /** The receiver’s immediate card views. */
    public var insertedInvitationCardViews = [InvitationCard]()    {
        didSet {
            calculateLayoutValues(shouldLayoutInvitationStack: false)
        }
    }
    
    
    /** The distance that the wallet view is inset from the enclosing scroll view. */
    public var contentInset: UIEdgeInsets {
        set {
            scrollView.contentInset = newValue
            calculateLayoutValues()
        }
        get {
            return scrollView.contentInset
        }
    }
    
    public typealias PresentedInvitationCardDidUpdateBlock    = (InvitationCard?) -> ()
    public typealias InvitationCardShouldAllowBlock           = () -> (Bool)
    public typealias InvitationCardBeganPanBlock              = () -> ()

    public typealias LayoutCompletion                   = (Bool) -> ()
    public typealias InsertionCompletion                = () -> ()
    public typealias RemovalCompletion                  = () -> ()
    
    /**
     Informs the observing object when the value at the specified key path relative to the observed object has changed.
     
     - parameter keyPath: The key path, relative to object, to the value that has changed.
     - parameter object: The source object of the key path keyPath.
     - parameter change: A dictionary that describes the changes that have been made to the value of the property at the key path keyPath relative to object. Entries are described in Change Dictionary Keys.
     - parameter context: The value that was provided when the observer was registered to receive key-value observation notifications.
     */
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard context == &InvitationStack.observerContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if keyPath == #keyPath(UIScrollView.bounds) {
            layoutInvitationStack()
        } else if keyPath == #keyPath(UIScrollView.frame) {
            calculateLayoutValues()
        }
        
    }
    
    // MARK: Private methods
    
    private static var observerContext = 0
    
    deinit {
        scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.frame), context: &InvitationStack.observerContext)
        scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.bounds), context: &InvitationStack.observerContext)
    }
    
    
    func addObservers() {
        
        let options: NSKeyValueObservingOptions = [.new, .old, .initial]
        
        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.frame), options: options, context: &InvitationStack.observerContext)
        
        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.bounds), options: options, context: &InvitationStack.observerContext)
    }
    
    func prepareScrollView() {
        
        addSubview(scrollView)
        
        scrollView.clipsToBounds = false
        
        scrollView.isExclusiveTouch = true
        scrollView.alwaysBounceVertical = true
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleHeight, .flexibleWidth]
        scrollView.frame = bounds
        
        
    }
    
    func prepareWalletHeaderView() {
        
        let walletHeader = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        
        walletHeader.textAlignment = .center
        walletHeader.text = "Wallet"
        
        self.walletHeader = walletHeader
    }
    
    public let scrollView = UIScrollView()

    func prepareInvitationStack() {
        
        prepareScrollView()
        prepareWalletHeaderView()
        
    }
    
    func insert(cardViews: [InvitationCard]) {
        
        self.insertedInvitationCardViews = cardViews
        
        if insertedInvitationCardViews.count == 1 {
            presentedInvitationCard = insertedInvitationCardViews.first
        }
        
    }
    
    func present(cardView: InvitationCard, animated: Bool, animationDuration: TimeInterval?, completion: LayoutCompletion? = nil) {
        
        if cardView == presentedInvitationCard {
            
            completion?(true)
            return
            
        } else if presentedInvitationCard != nil {
            
            dismissPresentedInvitationCard(animated: animated, completion: nil)
            present(cardView: cardView, animated: animated, completion: completion)
            
        } else {
            
            presentedInvitationCard = cardView
            layoutInvitationStack(animationDuration: animated ? animationDuration : nil, placeVisibleInvitationCardViews: false, completion: { [weak self] (_) in
                self?.placeVisibleInvitationCardViews()
                completion?(true)
            })
            
        }
        
    }
    
    func dismissPresentedInvitationCard(animated: Bool, animationDuration: TimeInterval?, completion: LayoutCompletion? = nil) {
        
        if let cardView = presentedInvitationCard,
            cardView.cardViewCanReleaseBlock?() == false {
            layoutInvitationStack(animationDuration: InvitationStack.grabbingAnimationSpeed)
            return
        }
        
        if insertedInvitationCardViews.count <= 1 || presentedInvitationCard == nil {
            completion?(true)
            return
        }
        
        presentedInvitationCard = nil
        layoutInvitationStack(animationDuration: animated ? animationDuration : nil, placeVisibleInvitationCardViews: true, completion: { [weak self] (_) in
            self?.calculateLayoutValues()
            completion?(true)
        })
    }
    
    typealias RemovalAnimation = (InvitationCard, RemovalCompletion?) -> ()
    func removalAnimation() -> RemovalAnimation {
        
        return { [weak self] (cardView: InvitationCard,  completion: RemovalCompletion?) in
            
            guard let strongSelf = self else {
                return
            }
            
            let removalSuperview = UIView()
            
            removalSuperview.clipsToBounds = true
            
            let overlay = UIView()
            overlay.backgroundColor = .red
            
            self?.addSubview(removalSuperview)
            removalSuperview.addSubview(overlay)
            removalSuperview.addSubview(cardView)
            
            removalSuperview.frame = strongSelf.scrollView.convert(cardView.frame, to: self)
            cardView.frame = removalSuperview.bounds
            overlay.frame = removalSuperview.bounds
            
            overlay.alpha = 0.0
            
            removalSuperview.layoutIfNeeded()
            removalSuperview.setNeedsDisplay()
            
            UIView.animateKeyframes(withDuration: InvitationStack.removalAnimationSpeed, delay: 0, options: [.calculationModeCubic], animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.7, animations: {
                    self?.remove(cardViews: [cardView])
                })
                    
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7, animations: {
                
                    removalSuperview.frame = removalSuperview.frame.insetBy(dx: 0, dy: removalSuperview.frame.height/2)
                    cardView.alpha = 0.0
                    
                    cardView.layoutIfNeeded()
                    cardView.setNeedsDisplay()
                    
                    removalSuperview.layoutIfNeeded()
                    removalSuperview.setNeedsDisplay()
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
                    overlay.alpha = 1.0
                    overlay.setNeedsDisplay()
                })
                
            }, completion: { (_) in
                completion?()
                removalSuperview.removeFromSuperview()
                
            })
            
        }
    }
    
    weak var grabbedInvitationCard: InvitationCard?
    
    var grabbedInvitationCardOriginalY: CGFloat = 0
    
    func grab(cardView: InvitationCard, popup: Bool) {
        
        if (presentedInvitationCard != nil && presentedInvitationCard != cardView) {
            return
        }
        scrollView.isScrollEnabled = false
        
        grabbedInvitationCard = cardView
        grabbedInvitationCardOriginalY = cardView.frame.minY - (popup ? grabPopupOffset : 0)
        
        var cardViewFrame = cardView.frame
        cardViewFrame.origin.y = grabbedInvitationCardOriginalY
        
        UIView.animate(withDuration: InvitationStack.grabbingAnimationSpeed, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut], animations: { [weak self] in
            self?.grabbedInvitationCard?.frame = cardViewFrame
            self?.grabbedInvitationCard?.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    func updateGrabbedInvitationCard(offset: CGFloat) {
        
        var cardViewFrame = grabbedInvitationCard?.frame ?? CGRect.zero
        cardViewFrame.origin.y = grabbedInvitationCardOriginalY + offset
        grabbedInvitationCard?.frame = cardViewFrame
        
    }
    
    func releaseGrabbedInvitationCard() {
        
        defer {
            grabbedInvitationCard = nil
        }
        
        if let grabbedInvitationCard = grabbedInvitationCard,
            grabbedInvitationCard == presentedInvitationCard && grabbedInvitationCard.presented == true,
            grabbedInvitationCard.frame.origin.y > grabbedInvitationCardOriginalY + maximumInvitationCardViewHeight / 4 {
            
            let presentationCenter = convert(self.presentationCenter, from: scrollView)
            let yPoints = frame.maxY - (presentationCenter.y - maximumInvitationCardViewHeight / 2)
            let velocityY = grabbedInvitationCard.panGestureRecognizer.velocity(in: grabbedInvitationCard).y
            let animationDuration = min(InvitationStack.dismissingAnimationSpeed * 1.5, TimeInterval(yPoints / velocityY))
            if insertedInvitationCardViews.count > 1 {
                dismissPresentedInvitationCard(animated: true, animationDuration: animationDuration)
            } else {
                layoutInvitationStack(animationDuration: InvitationStack.grabbingAnimationSpeed)
            }
        } else if let grabbedInvitationCard = grabbedInvitationCard,
            presentedInvitationCard == nil && grabbedInvitationCard.presented == false,
            grabbedInvitationCard.frame.origin.y < grabbedInvitationCardOriginalY - maximumInvitationCardViewHeight / 4 {
            present(cardView: grabbedInvitationCard, animated: true)
        } else {
            layoutInvitationStack(animationDuration: InvitationStack.grabbingAnimationSpeed)
        }
        
    }
    
    
    
    var presentationCenter: CGPoint {
        
        let centerRect = CGRect(x: 0, y: cardViewTopInset,
                                width: frame.width,
                                height: frame.height - collapsedInvitationCardViewStackHeight - cardViewTopInset)
        
        return scrollView.convert( CGPoint(x: centerRect.midX, y: centerRect.midY), from: self)
        
    }
    
    var collapsedInvitationCardViewStackHeight:   CGFloat = 0
    var walletHeaderHeight:         CGFloat = 0
    var cardViewTopInset:               CGFloat = 0
    var maximumInvitationCardViewHeight:          CGFloat = 0
    var cardViewHeight:                 CGFloat = 0
    var distanceBetweenInvitationCardViews:       CGFloat = 0
    
    func calculateLayoutValues(shouldLayoutInvitationStack: Bool = true) {
        
        
        walletHeaderHeight = walletHeader?.frame.height ?? 0
        
        cardViewTopInset = scrollView.contentInset.top + walletHeaderHeight
        
        collapsedInvitationCardViewStackHeight = (minimalDistanceBetweenCollapsedInvitationCardViews * CGFloat(maximimNumberOfCollapsedInvitationCardViewsToShow)) + distanceBetweetCollapsedAndPresentedInvitationCardViews
        
        maximumInvitationCardViewHeight = frame.height - (cardViewTopInset + collapsedInvitationCardViewStackHeight)
        
        cardViewHeight = min(preferableInvitationCardViewHeight, maximumInvitationCardViewHeight)
        
        
        let usableInvitationCardViewsHeight = walletHeaderHeight + insertedInvitationCardViews.map { _ in cardViewHeight }.reduce(0, { $0 + $1 } )
        
        distanceBetweenInvitationCardViews = max(minimalDistanceBetweenStackedInvitationCardViews, usableInvitationCardViewsHeight/CGFloat(insertedInvitationCardViews.count)/CGFloat(insertedInvitationCardViews.count))

        if shouldLayoutInvitationStack {
            layoutInvitationStack()
            updateScrolViewContentSize()
        }
        
    }
    
    func layoutWalletHeader() {
        
        if let walletHeader = walletHeader {
            
            var walletHeaderFrame = walletHeader.frame
            walletHeaderFrame.origin = convert(.zero, to: scrollView)
            walletHeaderFrame.origin.y += scrollView.contentInset.top
            walletHeaderFrame.size = CGSize(width: frame.width, height: walletHeader.frame.height)
            walletHeader.frame = walletHeaderFrame
            
        }
        
    }
    
    func layoutInvitationStack(animationDuration: TimeInterval? = nil,
                          animationOptions: UIView.KeyframeAnimationOptions = [.beginFromCurrentState, .calculationModeCubic],
                          placeVisibleInvitationCardViews: Bool = true,
                          completion: LayoutCompletion? = nil) {
        
        let animations = { [weak self] in
            
            self?.layoutWalletHeader()
            
            if let presentedInvitationCard = self?.presentedInvitationCard,
                let insertedInvitationCardViews = self?.insertedInvitationCardViews {
                self?.makeCollapseLayout(collapsePresentedInvitationCardView: !insertedInvitationCardViews.contains(presentedInvitationCard))
            } else {
                self?.makeStackLayout()
            }
            
            if placeVisibleInvitationCardViews {
                self?.placeVisibleInvitationCardViews()
            }
            
            self?.layoutIfNeeded()
            
        }
        
        if let animationDuration = animationDuration, animationDuration > 0 {
            UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: animationOptions, animations: animations, completion: completion)
        } else {
            animations()
            completion?(true)
        }
    }
    
    func updateScrolViewContentSize() {
        
        var contentSize = CGSize(width: frame.width, height: 0)
        
        let walletHeaderHeight = walletHeader?.frame.height ?? 0
        
        contentSize.height = (insertedInvitationCardViews.last?.frame.maxY ?? walletHeaderHeight) - (maximumInvitationCardViewHeight/2)
        
        if !contentSize.equalTo(scrollView.contentSize) {
            scrollView.contentSize = contentSize
        }
        
    }
    
    
    func makeStackLayout() {
        
        scrollView.isScrollEnabled = true
        
        let zeroRectConvertedFromInvitationStack: CGRect = {
            var rect = convert(CGRect.zero, to: scrollView)
            rect.origin.y += scrollView.contentInset.top
            return rect
        }()
        
        let stretchingDistanse: CGFloat? = {
            
            let negativeScrollViewContentInsetTop = -(scrollView.contentInset.top)
            let scrollViewContentOffsetY = scrollView.contentOffset.y
            
            if negativeScrollViewContentInsetTop > scrollViewContentOffsetY {
                return abs(abs(negativeScrollViewContentInsetTop) + scrollViewContentOffsetY)
            }
            
            return nil
        }()
        
        let walletHeaderY = walletHeader?.frame.origin.y ?? zeroRectConvertedFromInvitationStack.origin.y
        
        var cardViewYPoint = walletHeaderHeight
        
        let cardViewHeight = self.cardViewHeight
        
        let firstInvitationCardView = insertedInvitationCardViews.first
        
        for cardViewIndex in 0..<insertedInvitationCardViews.count {
            
            let cardView = insertedInvitationCardViews[cardViewIndex]
            
            var cardViewFrame = CGRect(x: 0, y: max(cardViewYPoint, walletHeaderY), width: frame.width, height: cardViewHeight)
            
            if cardView == firstInvitationCardView {
                
                cardViewFrame.origin.y = min(cardViewFrame.origin.y, walletHeaderY + walletHeaderHeight)
                cardView.frame = cardViewFrame
                
            } else {
                
                if let stretchingDistanse = stretchingDistanse {
                    cardViewFrame.origin.y += stretchingDistanse * CGFloat((cardViewIndex - 1))
                }
                
                cardView.frame = cardViewFrame
            }
            
            if useHeaderDistanceForStackedCards {
                cardViewYPoint += minimalDistanceBetweenStackedInvitationCardViews
            } else {
                cardViewYPoint += distanceBetweenInvitationCardViews
            }
            
        }
        
    }
    
    func makeCollapseLayout(collapsePresentedInvitationCardView: Bool = false) {
        
        scrollView.isScrollEnabled = false
        
        let scrollViewFrameMaxY = scrollView.convert(CGPoint(x: 0, y: scrollView.frame.maxY), from: self).y
        var cardViewYPoint = scrollViewFrameMaxY - collapsedInvitationCardViewStackHeight
        
        cardViewYPoint += distanceBetweetCollapsedAndPresentedInvitationCardViews
        
        let cardViewHeight = self.cardViewHeight
        
        let distanceBetweenInvitationCardViews = minimalDistanceBetweenCollapsedInvitationCardViews
        
        let firstIndexToMoveY: Int = {
            
            guard let presentedInvitationCard = presentedInvitationCard,
                let presentedInvitationCardIndex = insertedInvitationCardViews.firstIndex(of: presentedInvitationCard) else {
                    return 0
            }
            
            let halfMaximimNumberOfCollapsedInvitationCardViewsToShow = Int(round(CGFloat(maximimNumberOfCollapsedInvitationCardViewsToShow)/2))
            
            if presentedInvitationCardIndex >= insertedInvitationCardViews.count - 1 {
                return presentedInvitationCardIndex - (maximimNumberOfCollapsedInvitationCardViewsToShow - 1)
            } else {
                return presentedInvitationCardIndex - halfMaximimNumberOfCollapsedInvitationCardViewsToShow
            }
            
        }()
        
        var collapsedInvitationCardViewsCount = maximimNumberOfCollapsedInvitationCardViewsToShow
        
        for cardViewIndex in 0..<insertedInvitationCardViews.count {
            
            let cardView = insertedInvitationCardViews[cardViewIndex]
            
            var cardViewFrame = CGRect(x: 0, y: scrollViewFrameMaxY + (collapsedInvitationCardViewStackHeight * 2), width: frame.width, height: cardViewHeight)
            
            if cardViewIndex >= firstIndexToMoveY && collapsedInvitationCardViewsCount > 0 {
                
                if presentedInvitationCard != cardView || collapsePresentedInvitationCardView {
                    
                    let widthDelta = distanceBetweenInvitationCardViews * CGFloat(collapsedInvitationCardViewsCount)
                    cardViewFrame.size.width = cardViewFrame.size.width - widthDelta
                    cardViewFrame.origin.x += widthDelta/2
                    
                    collapsedInvitationCardViewsCount -= 1
                    cardViewFrame.origin.y = cardViewYPoint
                    cardViewYPoint += distanceBetweenInvitationCardViews
                }
                
            }
            
            cardView.frame = cardViewFrame
            
            if presentedInvitationCard == cardView && !collapsePresentedInvitationCardView {
                cardView.center = presentationCenter
            }
            
        }
        
    }
    
    func placeVisibleInvitationCardViews() {
        
        var cardViewIndex = [CGFloat: (index: Int, cardView: InvitationCard)]()
        
        var viewsToRemoveFromScrollView = [InvitationCard]()
        
        let shownScrollViewRect = CGRect(x: scrollView.contentOffset.x,
                                         y: scrollView.contentOffset.y,
                                         width: scrollView.frame.width,
                                         height: scrollView.frame.height)
        
        for index in 0..<insertedInvitationCardViews.count {
            
            let cardView = insertedInvitationCardViews[index]
            
            let intersection = shownScrollViewRect.intersection(cardView.frame)
            
            guard intersection.height > 0 || intersection.width > 0 else {
                viewsToRemoveFromScrollView.append(cardView)
                continue
            }
            
            let cardViewMinY = cardView.frame.minY
            
            if cardView == presentedInvitationCard {
                cardViewIndex[CGFloat.greatestFiniteMagnitude] = (index, cardView)
                continue
            } else if let previousInvitationCardView = cardViewIndex[cardViewMinY]?.cardView {
                viewsToRemoveFromScrollView.append(previousInvitationCardView)
            }
            
            cardViewIndex[cardViewMinY] = (index, cardView)
            
        }
        
        for cardView in viewsToRemoveFromScrollView {
            cardView.removeFromSuperview()
        }
        
        let indexInvitationCardViewPairs = cardViewIndex.sorted(by: { $0.value.index < $1.value.index }).map { $0.value }
        
        guard let firstInvitationCardView = indexInvitationCardViewPairs.first?.cardView else { return }
        
        var previousInvitationCardView = firstInvitationCardView
        
        for pair in indexInvitationCardViewPairs {
            
            if pair.cardView == firstInvitationCardView {
                scrollView.addSubview(pair.cardView)
            } else {
                scrollView.insertSubview(pair.cardView, aboveSubview: previousInvitationCardView)
            }
            
            previousInvitationCardView = pair.cardView
        }
        
    }
    
}
