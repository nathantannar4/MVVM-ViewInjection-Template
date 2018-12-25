//
//  ListView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListView: ScrollStackView {
    enum SeparatorStyle {
        case none
        case single(UIColor)
    }

    private(set) var rows = [UIView]()

    var separatorStyle: SeparatorStyle = .single(.lightGrayColor)

    func appendRow(_ row: UIView) {
        insertRow(row, at: rows.count, animated: false)
    }

    func appendRows(_ rows: UIView...) {
        rows.forEach { insertRow($0, at: self.rows.count, animated: false) }
    }

    func insertRow(_ row: UIView, at index: Int, animated: Bool) {
        switch separatorStyle {
        case .single(let color):
            row.addBorderView(to: .bottom, color: color, thickness: 1)
        case .none:
            break
        }
        rows.insert(row, at: index)
        insertArrangedSubview(row, at: index)

        guard animated else { return }
        row.isHidden = true
        row.alpha = 0
        UIView.animate(withDuration: 0.3) {
            row.isHidden = false
            row.alpha = 1
        }
    }

    func deleteRow(_ row: UIView, at index: Int, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                row.isHidden = true
                row.alpha = 0
            }, completion: { [weak self] _ in
                self?.deleteRow(row, at: index, animated: false)
            })
        } else {
            rows.removeAll { $0 == row }
            removeArrangedSubview(row)
        }
    }
}
