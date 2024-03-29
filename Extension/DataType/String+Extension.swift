//
//  String+Extension.swift
//
//

import Foundation
import UIKit

public extension String {
    /// 동일한 문자열을 찾아 Range 객체로 반환한다.
    /// - Parameters:
    /// - of: 찾을 문자열
    /// - skipIndex: 무시할 문자열 index (문자열 맨앞이 0)
    func nsRange(of str: String, skipIndex: Int? = nil) -> NSRange? {
        if str.count > 0, let range = range(of: str) {
            let start = range.lowerBound
            let intStart = distance(from: startIndex, to: start)
            var location: Int!
            if let skipIndex = skipIndex, skipIndex <= count, intStart == 0 {
                location = distance(from: startIndex, to: index(start, offsetBy: skipIndex))
            } else {
                location = distance(from: startIndex, to: start)
            }
            return NSRange(location: location, length: str.count)
        }
        return nil
    }

    /// 공백 제거 함수
    var getReplaceNullStr: String {
        return replacingOccurrences(of: " ", with: "")
    }

    /// 공백과 줄바꿈 제거
    var trimWhitespacesAndNewlines: String {
        if isEmpty {
            return self
        }

        return replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    }

    /// String에서 숫자만 반환
    var getNumberString: String {
        let valueString = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return valueString
    }

    /// String에서 숫자를 Int형으로 반환
    var getNumberInt: Int {
        let valueString = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return Int(valueString) ?? 0
    }

    /// 전화번호 포멧으로 리턴
    var convertPhoneNumber: String {
        if count == 10 {
            return String(format: "%@-%@-%@",
                          self[0 ..< 3],
                          self[3 ..< 6],
                          self[6 ..< count])
        } else if count == 11 {
            return String(format: "%@-%@-%@",
                          self[0 ..< 3],
                          self[3 ..< 7],
                          self[7 ..< count])
        } else {
            return self
        }
    }

    /// 이메일 포멧 체크
    var isEmailFormat: Bool {
        guard count <= 36 else { return false }
        let emailFormat = "(^[-!#$%&'*+/=?^_'{}|~0-9A-Z]+(\\.[-!#$%&'*+/=?^_'{}|~0-9A-Z]+)*|^\"([\\u0001-\\u0008\\u000B\\u000C\\u000E-\\u001F!#-\\[\\]-\\u007F]|\\[\\u0001-\\u0009\\u000B\\u000C\\u000E-\\u007F])*\")@(([A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\\.)+)([A-Z0-9-]{2,63})" // swiftlint:disable:this line_length
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: uppercased())
    }

    /// base 64
    var base64: String {
        return Data(utf8).base64EncodedString()
    }

    /// 토큰을 앞에서부터 8자리로 변경
    var tokenSubstring: String {
        var t = ""
        if count > 8 {
            t = self[0 ..< 8]
        }
        return t
    }

    /// 초성만분리
    static let startOfHangul: UInt32 = 44032 // 한글 유니코드 시작값
    static let endOfHangul: UInt32 = 55215 // 한글 유니코드 끝값
    static let initialConsonantArray = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ",
    ]

    /// 초성만 분리하여 리턴 ex) 홍길동 -> ㅎㄱㄷ
    func getInitString() -> String {
        var resultString = String()

        for unicode in unicodeScalars {
            let currentUnicodeValue = unicode.value

            // 유니코드 값이 한글 범위인 경우
            if String.startOfHangul <= currentUnicodeValue &&
                String.endOfHangul >= currentUnicodeValue
            {
                let currentCharacter = String.initialConsonantArray[Int(((currentUnicodeValue - String.startOfHangul) / 28) / 21)]
                resultString.append(currentCharacter)

            } else { // 유니코드 값이 한글 범위가 아닌 경우
                if let scalar = UnicodeScalar(currentUnicodeValue) {
                    resultString.append(Character(scalar))
                }
            }
        }
        return resultString
    }

    /// URL로 변환
    var toUrl: URL? {
        let s = self
        guard let urlString = s.removingPercentEncoding else {
            return nil
        }

        // 한글일때 이미지가 나오게하기위해 인코딩
        guard let target = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            // 인코딩중 에러가 발생함
            return nil
        }

        guard let url = URL(string: target) else {
            // URL로 만들다가 에러가 발생함
            return nil
        }
        return url
    }

    /// Int or 0
    var int: Int {
        let removedComma = removeComma
        return Int(removedComma.double)
    }

    /// Double or 0
    var double: Double {
        return Double(self) ?? 0
    }

    var removeComma: String {
        return replacingOccurrences(of: ",", with: "")
    }

    /// 콤마를 제거한 후 Decimal로 변환
    var decimal: Decimal {
        return Decimal(string: removeComma, locale: .korea) ?? .zero
    }

    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var isNotBlank: Bool {
        return !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }
}

public extension String {
    /// UILabel의 size를 구하는 함수
    /// - Parameters:
    ///   - height: UILabel height
    ///   - font: UILabel font
    /// - Returns: CGRect
    func size(withConstrainedHeight height: CGFloat, font: UIFont) -> CGRect {
        let nsString = NSString(string: self)
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = nsString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return boundingBox
    }
}

public extension String {
    func validPasswordWordCase() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[A-Z]).{0,}$")
        return password.evaluate(with: self)
    }

    func validWordLength(count: Int) -> Bool {
        return self.count >= count
    }

    func validPasswordNumber() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[0-9]).{0,}$")
        return password.evaluate(with: self)
    }

    /// - Parameter rex: 정규식
    func validAllowRex(rex: String) -> Bool {
        let allowString = NSPredicate(format: "SELF MATCHES %@ ", rex)
        return allowString.evaluate(with: self)
    }

    /// 완성된 한글만 있는지 체크
    func validAllowCompleteHangulRex() -> Bool {
        let allowString = NSPredicate(format: "SELF MATCHES %@ ", "^[가-힣]*$")
        return allowString.evaluate(with: self)
    }

    /// 영문이름 체크
    func validAllowEngNameRex() -> Bool {
        let allowString = NSPredicate(format: "SELF MATCHES %@ ", "^[a-zA-Z-]*$")
        return allowString.evaluate(with: self)
    }

    /// 날짜 체크(구분자없음)
    /// - Returns:
    func validDateRex() -> Bool {
        let datePattern = "(?<year>(19|20)[0-9]{2})(?<month>(0[1-9]|1[0-2]))(?<date>(0[1-9]|1[0-9]|2[0-9]|3[0-1]))"
        let allowString = NSPredicate(format: "SELF MATCHES %@ ", datePattern)
        return allowString.evaluate(with: self)
    }

    /// 핸드폰 번호인지 체크
    func vaildPhoneNumberPrefix() -> Bool {
        return hasPrefix("010")
            || hasPrefix("011")
            || hasPrefix("016")
            || hasPrefix("017")
            || hasPrefix("018")
            || hasPrefix("019")
    }

    /// 010으로 시작하는지 검증
    func validPhoneNumber010() -> Bool {
        return hasPrefix("010")
    }

    /// 010을 제외한 핸드폰 번호인지 검증
    func validPhoneNumber01n() -> Bool {
        return hasPrefix("011")
            || hasPrefix("016")
            || hasPrefix("017")
            || hasPrefix("018")
            || hasPrefix("019")
    }

    /// 핸드폰 번호 validate
    func validatePhoneNumberDigits() -> Bool {
        let regex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = phonePredicate.evaluate(with: self)

        /// 010으로 시작하는 번호는 11자리 또는 "-"포함시 13자리
        if isValid && validPhoneNumber010() {
            if count == 11 || count == 13 {
                return true
            } else {
                return false
            }
        } else if isValid && validPhoneNumber01n() { /// 011,6,7,8,9으로 시작하는 번호는 1자리 또는 "-"포함시 12자리
            if count == 10 || count == 12 {
                return true
            } else {
                return false
            }
        }

        return isValid
    }

    /// 생년월일 검증
    func validateBirthDay() -> Bool {
        let regex = "^([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = phonePredicate.evaluate(with: self)
        return isValid
    }

    /// 간단히 line spacing 을 주기위해 사용
    func lineSpacingAttributeText(
        lineSpacing: CGFloat,
        font: UIFont,
        foregroundColor: UIColor,
        alignment: NSTextAlignment = .left,
        lineBreakMode: NSLineBreakMode = .byWordWrapping
    ) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        if #available(iOS 14.0, *) {
            style.lineBreakStrategy = .hangulWordPriority
        }
        return NSMutableAttributedString(
            string: self,
            attributes: [
                .font: font,
                .foregroundColor: foregroundColor,
                .paragraphStyle: style,
            ]
        )
    }

    /// leading trailing 각 3자씩 컬러 적용
    /// - Returns:
    func leadingAndTrailingSetColor(font: UIFont, foregroundColor: UIColor, color: UIColor, alignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        let lenght = count
        let colorLenght = 3
        guard count > colorLenght else {
            return NSMutableAttributedString(string: self)
        }

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 3
        style.alignment = alignment
        if #available(iOS 14.0, *) {
            style.lineBreakStrategy = .hangulWordPriority
        }

        let attributeString = NSMutableAttributedString(string: self, attributes: [
            .font: font,
            .foregroundColor: foregroundColor,
            .paragraphStyle: style,
        ])

        attributeString.addAttribute(.foregroundColor,
                                     value: color,
                                     range: NSRange(location: 0, length: colorLenght))
        attributeString.addAttribute(.foregroundColor,
                                     value: color,
                                     range: NSRange(location: lenght - colorLenght, length: colorLenght))
        return attributeString
    }

    /// 두개의 스트링을 받아 앞 스트링 속성을 베이스로해서 뒷쪽 스트링에 대해 속성을 추가한다.
    /// - Parameters:
    ///   - leadingString: 앞 스트링
    ///   - leadingAttribute: 앞 스트링 속성
    ///   - trailingString: 뒤 스트링
    ///   - trailingAttribute: 뒤 스트링 속성
    /// - Returns: 두 스트링 속성을 적용하고 붙여서 리턴
    static func leadingAndTrailingSetAttribute(
        leadingString: String?,
        leadingAttribute: [NSAttributedString.Key: Any],
        trailingString: String?,
        trailingAttribute: [NSAttributedString.Key: Any]
    ) -> NSMutableAttributedString {
        let leading: String = leadingString ?? ""
        let trailing: String = trailingString ?? ""
        let mergeString = leading + trailing
        let trailingLocation = mergeString.count - trailing.count

        let attributeString = NSMutableAttributedString(string: mergeString, attributes: leadingAttribute)

        for attribute in trailingAttribute {
            attributeString.addAttribute(attribute.key,
                                         value: attribute.value,
                                         range: NSRange(location: trailingLocation, length: trailing.count))
        }

        return attributeString
    }

    /// pattern에 있는 특정문자를 치환해주는 함수
    /// - Parameters:
    ///   - pattern: 패턴
    ///   - replacementCharacter: 대치될 문자
    /// - Returns: 대치된 String
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }

    /// pattern에 있는 특정문자를 치환해주는 함수
    /// - Parameters:
    ///   - reg: 정규식
    ///   - pattern: 패턴
    ///   - replacementCharacter: 대치될 문자
    /// - Returns: 대치된 String
    func applyPatternOn(reg: String, pattern: String, replacementCharacter: Character) -> String {
        var pureText = replacingOccurrences(of: reg, with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureText.count else { return pureText }
            let stringIndex = pattern.index(pattern.startIndex, offsetBy: index)
            let pureStringIndex = pureText.index(pureText.startIndex, offsetBy: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            let patternStr = String(patternCharacter.utf8)

            pureText.insert(contentsOf: patternStr, at: pureStringIndex)
        }
        return pureText
    }

    /// AtributeString 설정
    /// - Parameters:
    ///   - font: 폰트
    ///   - color: 색상
    ///   - lineHeight: 줄 높이 (제플린 값)
    ///   - alignment: 정렬
    func setMutableAttributeString(font: UIFont,
                                   color: UIColor,
                                   lineHeight: CGFloat,
                                   alignment: NSTextAlignment) -> NSMutableAttributedString
    {
        let attrStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.alignment = alignment

        attrStr.addAttributes([
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle,
        ], range: NSRange(location: 0, length: attrStr.length))
        return attrStr
    }

    /// 해당 index의 Chrachter를 String으로 리턴
    /// - Parameter index: 가져올 index
    func item(at index: Int) -> String? {
        guard count > index else { return nil }
        return self[index ..< (index + 1)]
    }
}
