//
//  String+Masking.swift
//
//

public extension String {
    /// 전화번호 마스킹된 걸로 리턴
    var convertPhoneNumberMasking: String {
        if count == 10 {
            let first = String(format: "%@", self[0 ..< 3])
            var middle = String(format: "%@", self[3 ..< 6])
            var last = String(format: "%@", self[6 ..< count])

            let middleMaskingStartIndex = middle.index(middle.endIndex, offsetBy: -2) ..< middle.endIndex
            middle.replaceSubrange(middleMaskingStartIndex, with: "**")

            let lastMaskingStartIndex = last.index(last.endIndex, offsetBy: -2) ..< last.endIndex
            last.replaceSubrange(lastMaskingStartIndex, with: "**")

            return String(format: "%@-%@-%@",
                          first,
                          middle,
                          last)
        } else if count == 11 {
            let first = String(format: "%@", self[0 ..< 3])
            var middle = String(format: "%@", self[3 ..< 7])
            var last = String(format: "%@", self[7 ..< count])

            let middleMaskingStartIndex = middle.index(middle.endIndex, offsetBy: -2) ..< middle.endIndex
            middle.replaceSubrange(middleMaskingStartIndex, with: "**")

            let lastMaskingStartIndex = last.index(last.endIndex, offsetBy: -2) ..< last.endIndex
            last.replaceSubrange(lastMaskingStartIndex, with: "**")

            return String(format: "%@-%@-%@",
                          first,
                          middle,
                          last)
        } else {
            return self
        }
    }

    /// 전화번호 대쉬없는 마스킹된 걸로 리턴
    var convertPhoneNumberMaskingWithoutDash: String {
        if count == 10 {
            let first = String(format: "%@", self[0 ..< 3])
            var middle = String(format: "%@", self[3 ..< 6])
            var last = String(format: "%@", self[6 ..< count])

            let middleMaskingStartIndex = middle.index(middle.endIndex, offsetBy: -2) ..< middle.endIndex
            middle.replaceSubrange(middleMaskingStartIndex, with: "**")

            let lastMaskingStartIndex = last.index(last.endIndex, offsetBy: -2) ..< last.endIndex
            last.replaceSubrange(lastMaskingStartIndex, with: "**")

            return String(format: "%@%@%@",
                          first,
                          middle,
                          last)
        } else if count == 11 {
            let first = String(format: "%@", self[0 ..< 3])
            var middle = String(format: "%@", self[3 ..< 7])
            var last = String(format: "%@", self[7 ..< count])

            let middleMaskingStartIndex = middle.index(middle.endIndex, offsetBy: -2) ..< middle.endIndex
            middle.replaceSubrange(middleMaskingStartIndex, with: "**")

            let lastMaskingStartIndex = last.index(last.endIndex, offsetBy: -2) ..< last.endIndex
            last.replaceSubrange(lastMaskingStartIndex, with: "**")

            return String(format: "%@%@%@",
                          first,
                          middle,
                          last)
        } else {
            return self
        }
    }

    /// 메일주소 앞 4자리를 제외한 나머지 모두 마스킹. 단, 메일주소가 4자리 이하일 경우, 앞의 1자리를 제외한 나머지 모두 마스킹
    var maskEmail: String {
        let email = self
        let components = email.components(separatedBy: "@")
        var maskEmail = ""
        if let first = components.first {
            if first.count > 4 {
                maskEmail = String(first.enumerated().map { index, char in
                    [0, 1, 2, 3].contains(index) ?
                        char : "*"
                })
            } else {
                maskEmail = String(first.enumerated().map { index, char in
                    [0].contains(index) ?
                        char : "*"
                })
            }
        }

        if let domain = components.last?.components(separatedBy: ".") {
            if let first = domain.first {
                let makeDomain = String(first.enumerated().map { _, _ in
                    "*"
                })
                maskEmail += "@" + makeDomain
            }
            if let last = domain.last {
                let makeDomain = String(last.enumerated().map { _, _ in
                    "*"
                })
                maskEmail += "." + makeDomain
            }
        }
        return maskEmail
    }

    /// 맨 앞글자 한자리와 맨 뒷글자 한자리를 제외한 나머지 모두 마스킹. 단, 외자일 경우 맨 앞글자만 마스킹
    var maskName: String {
        let name = self
        var maskName = ""
        if name.count > 2 {
            maskName = String(name.enumerated().map { index, char in
                [0, name.count - 1].contains(index) ?
                    char : "*"
            })
        } else if name.count == 2 {
            maskName = String(name.enumerated().map { index, char in
                [0].contains(index) ?
                    char : "*"
            })
        }
        return maskName
    }

    /// 계좌번호 마스킹된 걸로 리턴
    var convertBankAccountMasking: String {
        guard count > 5 else { return self }

        let first = String(format: "%@", self[0 ..< 3])
        var middle = String(format: "%@", self[3 ..< (count - 3)])
        let masking = String(repeating: "*", count: middle.count)
        let last = String(format: "%@", self[(count - 3) ..< count])

        let middleMaskingStartIndex = middle.startIndex ..< middle.endIndex
        middle.replaceSubrange(middleMaskingStartIndex, with: masking)

        return String(format: "%@%@%@",
                      first,
                      middle,
                      last)
    }

    /// ip 마스킹 스트링
    /// - ipv4 : 앞뒤 1 옥텟을 제외하고 마스킹
    /// - ipv4 : 앞뒤 2 옥텟을 제외하고 마스킹
    var ipMasking: String {
        /// ipv4
        if contains(".") {
            var ipArray = components(separatedBy: ".")
            if ipArray.count >= 4 {
                ipArray[1] = "***"
                ipArray[2] = "***"
                return ipArray.joined(separator: ".")
            }
            return self
        }
        /// ipv6
        else {
            var ipArray = components(separatedBy: ":")
            if ipArray.count >= 8 {
                ipArray[2] = "****"
                ipArray[3] = "****"
                ipArray[4] = "****"
                ipArray[5] = "****"

                return ipArray.joined(separator: ":")
            }
            return self
        }
    }
}
