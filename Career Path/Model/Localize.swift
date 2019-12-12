//
//  Localize.swift
//  Career Path
//
//  Created by iosdev on 12/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import Foundation

private class Localizator {
    
    static let sharedInstance = Localizator()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "LanguageStringPList", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        guard let localiasedS = localizableDictionary.value(forKey: string) as? NSDictionary else {
            return ""
        }
        guard let localizedString = localiasedS.value(forKey: "value") as? String else {
            return ""
        }
        return localizedString
    }
}

extension String {
    var localized: String {
        return Localizator.sharedInstance.localize(string: self)
    }
}
