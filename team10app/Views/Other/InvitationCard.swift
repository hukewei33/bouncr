//
//  InvitationCard.swift
//  team10app
//
//  Created by GraceJoseph on 10/29/21.
//  Uses code from https://github.com/russ-stamant/Wallet/blob/master/Wallet/Classes/InvitationCard.swift
//

import Foundation
import SwiftUI
import UIKit

/**  The InvitationCard class defines the attributes and behavior of the cards that appear in InvitationStack objects. */
open class InvitationCard: UIView {
    
    // MARK: Public methods
    
    /**
     Initializes and returns a newly allocated card view object with the specified frame rectangle.
     
     - parameter aRect: The frame rectangle for the card view, measured in points.
     - returns: An initialized card view.
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupGestures()
    }
    
    /**
     Returns a card view object initialized from data in a given unarchiver.
     
     - parameter aDecoder: An unarchiver object.
     - returns: A card view, initialized using the data in decoder.
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGestures()
    }
    
    /**  A Boolean value that determines whether the view is presented. */
    open var presented: Bool = false
    
    
    /**  A parent wallet view object, or nil if the card view is not visible. */
    public var stackView: InvitationStack? {
        return container()
    }
    
    /** This method is called when the card view is tapped. */
    @objc open func tapped() {
        if let _ = stackView?.presentedInvitationCard {
            stackView?.dismissPresentedInvitationCard(animated: true)
        } else {
            stackView?.present(cardView: self, animated: true)
        }
    }
    
    /** This block is called to determine if a card view can be panned. */
    public var cardViewCanPanBlock: InvitationStack.InvitationCardShouldAllowBlock?
    
    /** This block is called to determine if a card view can be panned. */
    public var cardViewCanReleaseBlock: InvitationStack.InvitationCardShouldAllowBlock?
    
    private var calledInvitationCardBeganPanBlock = true
    /** This block is called when a card view began panning. */
    public var cardViewBeganPanBlock: InvitationStack.InvitationCardBeganPanBlock?
    
    /** This method is called when the card view is panned. */
    @objc open func panned(gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .began:
            stackView?.grab(cardView: self, popup: false)
            calledInvitationCardBeganPanBlock = false
        case .changed:
            updateGrabbedInvitationCardOffset(gestureRecognizer: gestureRecognizer)
        default:
            if cardViewCanReleaseBlock?() == false {
                stackView?.layoutInvitationStack(animationDuration: InvitationStack.grabbingAnimationSpeed)
            } else {
                stackView?.releaseGrabbedInvitationCard()
            }
        }
        
    }
    
    /** This method is called when the card view is long pressed. */
    @objc open func longPressed(gestureRecognizer: UILongPressGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .began:
            stackView?.grab(cardView: self, popup: true)
        case .changed: ()
        default:
            if cardViewCanReleaseBlock?() == false {
                stackView?.layoutInvitationStack(animationDuration: InvitationStack.grabbingAnimationSpeed)
            } else {
                stackView?.releaseGrabbedInvitationCard()
            }
        }
        
        
    }
    
    public let tapGestureRecognizer    = UITapGestureRecognizer()
    public let panGestureRecognizer    = UIPanGestureRecognizer()
    public let longGestureRecognizer   = UILongPressGestureRecognizer()
    
    // MARK: Private methods
    
    func setupGestures() {
        
        tapGestureRecognizer.addTarget(self, action: #selector(InvitationCard.tapped))
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer.addTarget(self, action: #selector(InvitationCard.panned(gestureRecognizer:)))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        longGestureRecognizer.addTarget(self, action: #selector(InvitationCard.longPressed(gestureRecognizer:)))
        longGestureRecognizer.delegate = self
        addGestureRecognizer(longGestureRecognizer)
        
    }
    
    
    func updateGrabbedInvitationCardOffset(gestureRecognizer: UIPanGestureRecognizer) {
        let offset = gestureRecognizer.translation(in: stackView).y
        if presented && offset > 0 {
            stackView?.updateGrabbedInvitationCard(offset: offset)
            if cardViewCanPanBlock?() == true, calledInvitationCardBeganPanBlock == false {
                cardViewBeganPanBlock?()
                calledInvitationCardBeganPanBlock = true
            }
        } else if !presented {
            stackView?.updateGrabbedInvitationCard(offset: offset)
        }
    }
    
}

extension InvitationCard: UIGestureRecognizerDelegate {
    
    /**
     Asks the delegate if a gesture recognizer should begin interpreting touches.
     
     - parameter gestureRecognizer: An instance of a subclass of the abstract base class UIGestureRecognizer. This gesture-recognizer object is about to begin processing touches to determine if its gesture is occurring.
     */
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        if gestureRecognizer == panGestureRecognizer {
            let cardViewCanPan = cardViewCanPanBlock?() ?? true
            if !cardViewCanPan {
                return false
            }
        }
        
        if gestureRecognizer == longGestureRecognizer && presented {
            return false
        } else if gestureRecognizer == panGestureRecognizer && !presented && stackView?.grabbedInvitationCard != self {
            return false
        }
        
        return true
        
    }
    
    /**
     Asks the delegate if two gesture recognizers should be allowed to recognize gestures simultaneously.
     
     - parameter gestureRecognizer: An instance of a subclass of the abstract base class UIGestureRecognizer. This gesture-recognizer object is about to begin processing touches to determine if its gesture is occurring.
     - parameter otherGestureRecognizer: An instance of a subclass of the abstract base class UIGestureRecognizer.
     */
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer != tapGestureRecognizer && otherGestureRecognizer != tapGestureRecognizer
    }
    
    
}

internal extension UIView {
    
    func container<T: UIView>() -> T? {
        
        var view = superview
        
        while view != nil {
            if let view = view as? T {
                return view
            }
            view = view?.superview
        }
        
        return nil
    }
    
}
