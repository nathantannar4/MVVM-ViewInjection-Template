//
//  UIImage+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func resizeImage(width: CGFloat, height: CGFloat) -> UIImage? {
        var newImage = self
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        newImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage.withRenderingMode(renderingMode)
    }
    
    func scale(to size: CGFloat) -> UIImage? {
        return self.resizeImage(width: size, height: size)
    }

    func masked(with color: UIColor) -> UIImage? {
        let image = resizeImage(width: 250, height: 250) ?? self
        guard let maskImage = image.cgImage else {
            return nil
        }

        let bounds = CGRect(origin: .zero, size: image.size)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(
            data: nil,
            width: Int(bounds.width),
            height: Int(bounds.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )

        context?.clip(to: bounds, mask: maskImage)
        context?.setFillColor(color.cgColor)
        context?.fill(bounds)

        guard let cgImage = context?.makeImage() else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
