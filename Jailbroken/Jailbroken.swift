//
//  Jailbroken.swift
//
//
//  Created by JJW on 10/20/23.
//

#if canImport(UIKit)
import Foundation
import UIKit

public class Jailbroken {
    public static let shared = Jailbroken()
    /// 탈옥체크
    /// - Returns: true 는 탈옥 false는 정상
    public var isJailbroken: Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        return checkGeneralPath()
        || checkCydia()
        || checkTestFileWrite()
        || checkFridaPort()
        || checkFridaInstall()
        || checkSandBoxFork()
        #endif
    }
    
    /// 탈옥된 장치에서 일반적으로 발견되는 파일이나 디렉토리 확인
    private func checkGeneralPath() -> Bool {
        let fileManager = FileManager.default
        let jailbreakFilePaths = ["/Applications/Cydia.app",
                                  "/Library/MobileSubstrate/MobileSubstrate.dylib",
                                  "/bin/bash",
                                  "/usr/sbin/sshd",
                                  "/etc/apt",
                                  "/usr/bin/ssh",
                                  "/private/var/lib/apt"]
        for path in jailbreakFilePaths where fileManager.fileExists(atPath: path) {
            return true
        }
        return false
    }
    
    /// Cydia 체크
    @available(iOSApplicationExtension, unavailable)
    private func checkCydia() -> Bool {
        /// 탈옥된 환경에서만 접근 가능한 cydia 접근 시도
        let cydiaUrlScheme = URL(string: "cydia://package/com.example.package")
        
        if UIApplication.shared.canOpenURL(cydiaUrlScheme!) {
            return true
        }
        return false
    }
    
    /// 테스트 파일을 개인 디렉토리에 쓴 다음 즉시 삭제하려고 시도
    private func checkTestFileWrite() -> Bool {
        let fileManager = FileManager.default
        let path = "/private/" + UUID().uuidString
        do {
            try "test".write(toFile: path, atomically: true, encoding: .utf8)
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
    
    /// frida 포트 사용 체크
    func checkFridaPort() -> Bool {
        let hostName = "127.0.0.1"
        let fridaDefault = 27042
        
        var addr = sockaddr_in()
        addr.sin_len = UInt8(MemoryLayout.size(ofValue: addr))
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_addr.s_addr = inet_addr(hostName)
        var sock_addr = sockaddr(sa_len: 0, sa_family: 0, sa_data: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
        memcpy(&sock_addr, &addr, Int(MemoryLayout.size(ofValue: sockaddr_in.self)))
        
        addr.sin_port = in_port_t(fridaDefault)
        let socket = socket(AF_INET, SOCK_STREAM, 0)
        let result = connect(socket, &sock_addr, socklen_t(MemoryLayout.size(ofValue: addr)))
        if result == 0 {
            return true
        }
        close(socket)
        return false
    }
    
    /// frida 경로검사
    func checkFridaInstall() -> Bool {
        let fridaPath = "/usr/sbin/frida-server"
        let theURL = URL(fileURLWithPath: fridaPath, isDirectory: false)
        let fileManager = FileManager.default
        
        do {
            /// 접근 가능 체크
            if try theURL.checkResourceIsReachable() {
                return true
            }
            
            if fileManager.isReadableFile(atPath: fridaPath) ||
                fileManager.isWritableFile(atPath: fridaPath)
            {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    /// fork 함수 작동 여부로 판단
    /// - 앱은 샌드박스 내에서 실행되며 자식 프로세스를 둘 수 없음 fork로 에러가아닌 프로세스 아이디가 나올경우에는 탈옥 된것으로 판단
    func checkSandBoxFork() -> Bool {
        let RTLD_DEFAULT = UnsafeMutableRawPointer(bitPattern: -2)
        let forkPtr = dlsym(RTLD_DEFAULT, "fork")
        typealias ForkType = @convention(c) () -> Int32
        let fork = unsafeBitCast(forkPtr, to: ForkType.self)
        let result = fork()
        return result != -1
    }
}
#endif
