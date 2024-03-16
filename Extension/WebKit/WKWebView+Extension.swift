//
//  WKWebView+Extension.swift
//
//  Created by jjw-MAC-PC on 2021/08/25.
//
import WebKit

public extension WKWebView {
    func clean(completion: (() -> Void)? = nil) {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
            completion?()
        }
    }
    
    /// 웹뷰 줌 없애기
    func removeZoom() {
        self.configuration.userContentController.addUserScript(self.getZoomDisableScript())
    }
    
    private func getZoomDisableScript() -> WKUserScript {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
}

public extension WKWebViewConfiguration {
    func setCookies(cookies: [HTTPCookie], completion: (() -> Void)?) {
        let waitGroup = DispatchGroup()
        for cookie in cookies {
            waitGroup.enter()
            websiteDataStore.httpCookieStore.setCookie(cookie) { waitGroup.leave() }
        }
        waitGroup.notify(queue: DispatchQueue.main) { completion?() }
    }
    
    func clean(completion: (() -> Void)? = nil) {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        let dataStore = self.websiteDataStore
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
            completion?()
        }
    }
}
