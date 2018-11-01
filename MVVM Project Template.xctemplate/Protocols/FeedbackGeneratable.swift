//
//  FeedbackGeneratable.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FeedbackGeneratable {

    typealias FeedbackType = UINotificationFeedbackGenerator.FeedbackType

    func generateSelectionFeedback()
    func generateImpactFeedback()
    func generateNotificationFeedback(type: FeedbackType)
}

extension FeedbackGeneratable {

    func generateSelectionFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }

    func generateImpactFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }

    func generateNotificationFeedback(type: FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}

