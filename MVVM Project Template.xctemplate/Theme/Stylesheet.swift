//
//  Stylesheet.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Stylesheet {
    enum Layout {
        enum Padding {
            static var edgeLeadingTrailing: CGFloat = 16
            static var edgeTopBottom: CGFloat = 6
            static var subviewSpacing: CGFloat = 6
        }
    }

    enum Fonts {
        static var titleFont: UIFont {
            return .boldSystemFont(ofSize: 34)
        }

        static var subtitleFont: UIFont {
            return .systemFont(ofSize: 28, weight: .semibold)
        }

        static var headerFont: UIFont {
            return .systemFont(ofSize: 16, weight: .medium)
        }

        static var subheaderFont: UIFont {
            return .systemFont(ofSize: 14, weight: .medium)
        }

        static var descriptionFont: UIFont {
            return .systemFont(ofSize: 14, weight: .regular)
        }

        static var buttonFont: UIFont {
            return .systemFont(ofSize: 14, weight: .regular)
        }

        static var captionFont: UIFont {
            return .systemFont(ofSize: 13)
        }

        static var footnoteFont: UIFont {
            return .systemFont(ofSize: 12, weight: .medium)
        }
    }

    enum Labels {
        static let title = Style<UILabel> {
            $0.font = Fonts.titleFont
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
        }

        static let subtitle = Style<UILabel> {
            $0.font = Fonts.subtitleFont
            $0.textColor = .darkGray
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
        }

        static let header = Style<UILabel> {
            $0.font = Fonts.headerFont
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.adjustsFontSizeToFitWidth = true
        }

        static let subheader = Style<UILabel> {
            $0.font = Fonts.subheaderFont
            $0.textColor = .darkGray
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.adjustsFontSizeToFitWidth = true
        }

        static let light = Style<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 28, weight: .light)
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
        }

        static let description = Style<UILabel> {
            $0.font = Fonts.descriptionFont
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
        }

        static let address = Style<UILabel> {
            $0.font = Fonts.descriptionFont.withSize(12)
            $0.textColor = .darkGray
            $0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
        }

        static let caption = Style<UILabel> {
            $0.font = Fonts.captionFont
            $0.textColor = .darkGray
            $0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
        }

        static let footnote = Style<UILabel> {
            $0.font = Fonts.footnoteFont
            $0.textColor = .darkGray
            $0.numberOfLines = 0
            $0.adjustsFontSizeToFitWidth = true
        }
    }

    enum Views {
        static let rounded = Style<UIView> {
            $0.layer.cornerRadius = 8
        }

        static let lightlyShadowed = Style<UIView> {
            $0.layer.shadowColor = UIColor.shadowColor.cgColor
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowRadius = 2
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        }

        static let shadowed = Style<UIView> {
            $0.layer.shadowColor = UIColor.shadowColor.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowRadius = 3
            $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        }

        static let roundedShadowed = Style<UIView> {
            $0.apply(Views.shadowed)
            $0.apply(Views.rounded)
        }

        static let roundedLightlyShadowed = Style<UIView> {
            $0.apply(Views.lightlyShadowed)
            $0.apply(Views.rounded)
        }

        static let farShadowed = Style<UIView> {
            $0.layer.shadowRadius = 5
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowColor = UIColor.lightGray.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }

    enum VisualEffectView {
        static let regular = Style<UIVisualEffectView> {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            $0.effect = blurEffect
        }
    }

    enum GradientViews {
        static let white = Style<GradientView> {
            $0.colors = [UIColor.white.withAlphaComponent(0.3), UIColor.white]
            $0.locations = [0, 1]
        }
    }

    enum ImageViews {
        static let fitted = Style<UIImageView> {
            $0.tintColor = .primaryColor
            $0.contentMode = .scaleAspectFit
        }

        static let filled = Style<UIImageView> {
            $0.tintColor = .primaryColor
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .backgroundColor
            $0.clipsToBounds = true
        }

        static let roundedSquare = Style<UIImageView> {
            $0.tintColor = .primaryColor
            $0.apply(Views.rounded)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .backgroundColor
        }
    }

    enum NavigationBars {
        static let primary = Style<UINavigationBar> {
            $0.barTintColor = .primaryColor
            $0.tintColor = .white
            $0.barStyle = .black
            $0.isTranslucent = false
            $0.shadowImage = UIImage()
        }

        static let inversePrimary = Style<UINavigationBar> {
            $0.barTintColor = .white
            $0.tintColor = .primaryColor
            $0.barStyle = .default
            $0.isTranslucent = false
            $0.shadowImage = UIImage()
        }

        static let clear = Style<UINavigationBar> {
            $0.barTintColor = .white
            $0.tintColor = .primaryColor
            $0.barStyle = .default
            $0.isTranslucent = true
            $0.shadowImage = UIImage()
        }
    }

    enum ToolBars {
        
    }

    enum AnimatedButtons {
        static let regular = Style<Button> {
            $0.imageView.tintColor = .gray
            $0.setTitleColor(UIColor.darkGray, for: .normal)
            $0.setTitleColor(UIColor.darkGray.withAlphaComponent(0.3), for: .highlighted)
        }

        static let primary = Style<Button> {
            $0.apply(AnimatedButtons.regular)
            $0.setPrimaryColor(to: .primaryColor)
            let titleColor: UIColor = UIColor.primaryColor.isLight ? .black : .white
            $0.imageView.tintColor = titleColor
            $0.setTitleColor(titleColor, for: .normal)
            $0.setTitleColor(titleColor.withAlphaComponent(0.3), for: .highlighted)
            $0.titleLabel.font = .boldSystemFont(ofSize: 14)
        }

        static let secondary = Style<Button> {
            $0.apply(AnimatedButtons.regular)
            $0.setPrimaryColor(to: .secondaryColor)
            let titleColor: UIColor = UIColor.secondaryColor.isLight ? .black : .white
            $0.imageView.tintColor = titleColor
            $0.setTitleColor(titleColor, for: .normal)
            $0.setTitleColor(titleColor.withAlphaComponent(0.3), for: .highlighted)
            $0.titleLabel.font = .boldSystemFont(ofSize: 14)
        }

        static let link = Style<Button> {
            $0.apply(AnimatedButtons.regular)
            $0.titleLabel.textAlignment = .left
            let titleColor: UIColor = UIColor.primaryColor
            $0.imageView.tintColor = titleColor
            $0.setTitleColor(titleColor, for: .normal)
            $0.setTitleColor(titleColor.withAlphaComponent(0.3), for: .highlighted)
            $0.titleLabel.font = .boldSystemFont(ofSize: 14)
        }

        static let roundedWhite = Style<Button> {
            $0.apply(AnimatedButtons.regular)
            $0.layer.cornerRadius = 22
            $0.backgroundColor = .white
            $0.setTitleColor(.black, for: .normal)
            $0.setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .highlighted)
        }

        static let termsAndConditions = Style<Button> {
            let title = String.localize(.termsOfUsePrompt) + " "
            let normalTitle = NSMutableAttributedString()
                .normal(title, font: Fonts.buttonFont.withSize(10), color: .black)
                .bold(.localize(.termsOfUse), size: 10, color: .primaryColor)
            let highlightedTitle = NSMutableAttributedString()
                .normal(title, font: Fonts.buttonFont.withSize(10), color: UIColor.black.withAlphaComponent(0.3))
                .bold(.localize(.termsOfUse), size: 10, color: UIColor.primaryColor.withAlphaComponent(0.3))
            $0.setAttributedTitle(normalTitle, for: .normal)
            $0.setAttributedTitle(highlightedTitle, for: .highlighted)
            $0.backgroundColor = .white
        }

        static let signUp = Style<Button> {
            $0.apply(AnimatedButtons.regular)
            let prompt = String.localize(.signUpPrompt) + " "
            let link = String.localize(.signUpHere)
            let textColor = UIColor.darkGray
            let linkColor = UIColor.primaryColor
            let normalTitle = NSMutableAttributedString()
                .normal(prompt, font: Stylesheet.Fonts.buttonFont, color: textColor)
                .bold(link, size: 14, color: linkColor)
            let highlightedTitle = NSMutableAttributedString()
                .normal(prompt,
                        font: Stylesheet.Fonts.buttonFont,
                        color: textColor.withAlphaComponent(0.3))
                .bold(link,
                      size: 14,
                      color: linkColor.withAlphaComponent(0.3))
            $0.setAttributedTitle(normalTitle, for: .normal)
            $0.setAttributedTitle(highlightedTitle, for: .highlighted)
            $0.contentHorizontalAlignment = .center
        }

    }

    enum Buttons {
        static let regular = Style<UIButton> {
            $0.titleLabel?.font = Fonts.buttonFont
            $0.titleLabel?.numberOfLines = 0
            $0.titleLabel?.textAlignment = .center
            $0.imageView?.tintColor = .gray
            $0.imageView?.contentMode = .scaleAspectFit
            $0.setTitleColor(UIColor.darkGray, for: .normal)
            $0.setTitleColor(UIColor.darkGray.withAlphaComponent(0.3), for: .highlighted)
        }

        static let primary = Style<UIButton> {
            $0.apply(Buttons.regular)
            $0.backgroundColor = .primaryColor
            let titleColor: UIColor = UIColor.primaryColor.isLight ? .black : .white
            $0.imageView?.tintColor = titleColor
            $0.setTitleColor(titleColor, for: .normal)
            $0.setTitleColor(titleColor.withAlphaComponent(0.3), for: .highlighted)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        }

        static let secondary = Style<UIButton> {
            $0.apply(Buttons.regular)
            $0.backgroundColor = .secondaryColor
            let titleColor: UIColor = UIColor.secondaryColor.isLight ? .black : .white
            $0.imageView?.tintColor = titleColor
            $0.setTitleColor(titleColor, for: .normal)
            $0.setTitleColor(titleColor.withAlphaComponent(0.3), for: .highlighted)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        }

        static let link = Style<UIButton> {
            $0.apply(Buttons.regular)
            $0.contentHorizontalAlignment = .left
            let titleColor: UIColor = UIColor.primaryColor
            $0.imageView?.tintColor = titleColor
            $0.setTitleColor(titleColor, for: .normal)
            $0.setTitleColor(titleColor.withAlphaComponent(0.3), for: .highlighted)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        }

        static let roundedWhite = Style<UIButton> {
            $0.apply(Buttons.regular)
            $0.layer.cornerRadius = 22
            $0.backgroundColor = .white
            $0.setTitleColor(.black, for: .normal)
            $0.setTitleColor(UIColor.black.withAlphaComponent(0.3), for: .highlighted)
        }

        static let termsAndConditions = Style<UIButton> {
            let title = String.localize(.termsOfUsePrompt) + " "
            let normalTitle = NSMutableAttributedString()
                .normal(title, font: Fonts.buttonFont.withSize(10), color: .black)
                .bold(.localize(.termsOfUse), size: 10, color: .primaryColor)
            let highlightedTitle = NSMutableAttributedString()
                .normal(title, font: Fonts.buttonFont.withSize(10), color: UIColor.black.withAlphaComponent(0.3))
                .bold(.localize(.termsOfUse), size: 10, color: UIColor.primaryColor.withAlphaComponent(0.3))
            $0.setAttributedTitle(normalTitle, for: .normal)
            $0.setAttributedTitle(highlightedTitle, for: .highlighted)
        }

        static let signUp = Style<UIButton> {
            $0.apply(Buttons.regular)
            let prompt = String.localize(.signUpPrompt) + " "
            let link = String.localize(.signUpHere)
            let textColor = UIColor.darkGray
            let linkColor = UIColor.primaryColor
            let normalTitle = NSMutableAttributedString()
                .normal(prompt, font: Stylesheet.Fonts.buttonFont, color: textColor)
                .bold(link, size: 14, color: linkColor)
            let highlightedTitle = NSMutableAttributedString()
                .normal(prompt,
                        font: Stylesheet.Fonts.buttonFont,
                        color: textColor.withAlphaComponent(0.3))
                .bold(link,
                      size: 14,
                      color: linkColor.withAlphaComponent(0.3))
            $0.setAttributedTitle(normalTitle, for: .normal)
            $0.setAttributedTitle(highlightedTitle, for: .highlighted)
            $0.contentHorizontalAlignment = .center
        }
    }

    enum TextViews {
        static let regular = Style<UITextView> {
            $0.tintColor = .primaryColor
            $0.font = Fonts.descriptionFont
        }

        static let nonEditable = Style<UITextView> {
            $0.apply(TextViews.regular)
            $0.isEditable = false
        }
    }

    enum TextFields {
        static let primary = Style<UITextField> {
            $0.tintColor = .primaryColor
            $0.isSecureTextEntry = false
            $0.autocorrectionType = .default
            $0.clearButtonMode = .whileEditing
        }

        static let search = Style<UITextField> {
            $0.apply(TextFields.primary)
            $0.tintColor = .primaryColor
            $0.isSecureTextEntry = false
            $0.autocorrectionType = .default
            $0.clearButtonMode = .whileEditing
            $0.placeholder = .localize(.search)
        }

        static let email = Style<UITextField> {
            $0.apply(TextFields.primary)
            $0.placeholder = .localize(.email)
            $0.keyboardType = .emailAddress
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }

        static let phone = Style<UITextField> {
            $0.apply(TextFields.primary)
            $0.placeholder = .localize(.phoneNumber)
            $0.keyboardType = .phonePad
            $0.autocorrectionType = .no
            $0.tintColor = .primaryColor
            $0.clearButtonMode = .whileEditing
        }

        static let password = Style<UITextField> {
            $0.apply(TextFields.primary)
            $0.placeholder = .localize(.password)
            $0.isSecureTextEntry = true
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
        }
    }
}

