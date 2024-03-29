//
//  Locale+Extension.swift
//

import Foundation

public extension Locale {
    static let korea: Locale = /* 참고
         https://www.loc.gov/standards/iso639-2/php/English_list.php
         https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html#//apple_ref/doc/uid/10000171i-CH15-SW1

        identifier: "ko", "ko-KR", "ko-Kore_KR", "ko-수성목성화성금성"
        Locale.current.languageCode == "ko" 로 나온다.

         "ko-수성목성화성금성" : “수성목성화성금성” 이란 지역(주로 국가)에서 사용하는 한국어(ko)
        한국어는 한국에서만 사용하므로 지역을 제외한 언어코드만 넣는다.
        */
        .init(identifier: "ko")
}
