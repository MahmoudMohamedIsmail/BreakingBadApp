//
//  LanguageManager.swift


import UIKit

enum Language: String {
    case ar = "ar"
    case en = "en"
    
    var id: String{
        switch self {
        case .ar:
            return "F9E168C0-13B3-4A64-92F0-2D65F83BAD19"
        case .en:
            return "89345AFF-2AB2-41DF-A1A1-708902799C67"
        }
    }
}

class LanguageManager {
    
    private let appLocaleKey = "Locale"
    
    public static let sharedInstance = LanguageManager()
    
    private init () {
        // set default language
        let currentLocale = currentLanguage()
        self.setLanguage(to: currentLocale)
    }
    
    func currentLanguage() -> Language {
        guard let locale = UserDefaults.standard.string(forKey: appLocaleKey)else {
            return .en
        }
        return Language(rawValue: locale) ?? .en
    }
    
    func setLanguage(to newLanguage: Language) {
        
        switch newLanguage {
        case .ar:
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        default:
            UIView.appearance().semanticContentAttribute = .forceLeftToRight

        }
        
        UserDefaults.standard.set(newLanguage.rawValue, forKey: self.appLocaleKey)
        UserDefaults.standard.set([newLanguage.rawValue], forKey: "AppleLanguages")
        
        UserDefaults.standard.synchronize()
    }
    
    func isRTL() -> Bool {
        guard let locale = UserDefaults.standard.string(forKey: appLocaleKey) else {
            return false
        }
        return locale == "ar"
    }

}
