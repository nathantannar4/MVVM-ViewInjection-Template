//
//  EULAViewModel.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift

final class EULAViewModel: ViewModel {

    let eula = BehaviorSubject<NSAttributedString?>(value: nil)

    override func viewModelDidLoad() {
        super.viewModelDidLoad()
        loadEULA()
    }

    private func loadEULA() {
        let url = Bundle.main.path(
            forResource: "EndUserLicenseAgreement",
            ofType: "html"
        )
        guard let file = url else { return }
        guard let appName = appViewModel.appDisplayName else { return }
        guard let contents = try? String(contentsOfFile: file) else { return }
        let rawText = contents.replacingOccurrences(of: "$APP_NAME", with: appName)
        guard let data = rawText.data(using: .unicode, allowLossyConversion: true) else { return }
        let string = try? NSAttributedString(
            data: data,
            options: [.documentType : NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
        eula.onNext(string)
    }
}
