//
//  HideViewsOnLandscape.swift
//  On The Map
//
//  Created by Felipe Ribeiro on 29/01/19.
//  Copyright © 2019 Felipe Ribeiro. All rights reserved.
//

import Foundation
import UIKit

protocol HideViewsOnLandscape {
    var traitCollection: UITraitCollection { get }
    func hideOnLandscape(view: UIView) -> Void
    func hideOnLandscape(views: [UIView]) -> Void
    func hideOnLandscape(view: UIView, transitioningTo newCollection: UITraitCollection) -> Void
    func hideOnLandscape(views: [UIView], transitioningTo newCollection: UITraitCollection) -> Void
}

extension HideViewsOnLandscape {
    
    func hideOnLandscape(view: UIView) { view.isHidden = traitCollection.verticalSizeClass == .compact }
    
    func hideOnLandscape(views: [UIView]) { views.forEach { $0.isHidden = traitCollection.verticalSizeClass == .compact }}
    
    func hideOnLandscape(view: UIView, transitioningTo newCollection: UITraitCollection) { view.isHidden = newCollection.verticalSizeClass == .compact }
    
    func hideOnLandscape(views: [UIView], transitioningTo newCollection: UITraitCollection) { views.forEach { $0.isHidden = newCollection.verticalSizeClass == .compact }}
}
