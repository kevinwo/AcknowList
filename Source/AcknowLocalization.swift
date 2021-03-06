//
// AcknowLocalization.swift
//
// Copyright (c) 2015-2016 Vincent Tourraine (http://www.vtourraine.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

/// Manages the localization for the main acknowledgements labels and strings.
public class AcknowLocalization {

    /**
     The localized version of “Acknowledgements”.
     You can use this value for the button presenting the `AcknowListViewController`, for instance.

     - returns: The localized title.
     */
    public class func localizedTitle() -> String {
        return self.localizedString(forKey: "VTAckAcknowledgements", defaultString: "Acknowledgements")
    }

    /**
     Returns the user’s preferred language.

     - returns: The preferred language ID.
     */
    class func preferredLanguageCode() -> String? {
        return NSLocale.preferredLanguages().first
    }

    /**
     Returns a localized string.

     - parameter key: The key for the string to localize.
     - parameter defaultString: The default non-localized string.

     - returns: The localized string.
     */
    class func localizedString(forKey key: String, defaultString: String) -> String {
        var bundlePath = NSBundle(forClass: AcknowListViewController.self).pathForResource("AcknowList", ofType: "bundle")
        let languageBundle: NSBundle

        if let currentBundlePath = bundlePath {
            let bundle = NSBundle(path: currentBundlePath)
            var language = "en"

            if let firstLanguage = self.preferredLanguageCode() {
                language = firstLanguage
            }

            if let bundle = bundle {
                let localizations = bundle.localizations
                if localizations.contains(language) == false {
                    language = language.componentsSeparatedByString("-").first!
                }

                if localizations.contains(language) {
                    bundlePath = bundle.pathForResource(language, ofType: "lproj")
                }
            }
        }

        if let bundlePath = bundlePath {
            let bundleWithPath = NSBundle(path: bundlePath)
            if let bundleWithPath = bundleWithPath {
                languageBundle = bundleWithPath
            }
            else {
                languageBundle = NSBundle.mainBundle()
            }
        }
        else {
            languageBundle = NSBundle.mainBundle()
        }

        let localizedDefaultString = languageBundle.localizedStringForKey(key, value:defaultString, table:nil)
        return NSBundle.mainBundle().localizedStringForKey(key, value:localizedDefaultString, table:nil)
    }

    /**
     Returns the URL for the CocoaPods main website.

     - returns: The CocoaPods website URL.
     */
    class func CocoaPodsURLString() -> String {
        return "https://cocoapods.org"
    }

    /**
     Returns the default localized footer text.

     - returns: The localized footer text.
     */
    class func localizedCocoaPodsFooterText() -> String {
        return
            self.localizedString(forKey: "VTAckGeneratedByCocoaPods", defaultString: "Generated by CocoaPods")
                + "\n"
                + self.CocoaPodsURLString()
    }
}
