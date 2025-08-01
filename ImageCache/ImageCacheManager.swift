import Foundation
import UIKit

public class ImageCacheManager {
    public static let shared = ImageCacheManager()
    public let cache = NSCache<NSString, UIImage>()

    private init() {}
}

public extension ImageCacheManager {
    func getImage(
        _ url: String,
        completion: ((UIImage) -> Void)? = nil
    ) {
        guard url.isEmpty == false,
              let imageUrl = URL(string: url) else { return }

        let cacheKey = NSString(string: url)

        /// memory cache check
        if let cachedImage = ImageCacheManager.shared.cache.object(
            forKey: cacheKey
        ) {
            DispatchQueue.main.async {
                completion?(cachedImage)
            }
            return
        }

        // disk cache(file) check
        guard let cachesDirectory = FileManager.default.urls(
            for: .cachesDirectory, in: .userDomainMask
        ).first else { return }

        var filePath = URL(fileURLWithPath: cachesDirectory.path)
        filePath.appendPathComponent(imageUrl.lastPathComponent)
        if FileManager.default.fileExists(atPath: filePath.path) {
            if let data = try? Data(contentsOf: filePath),
               let image = UIImage(data: data)
            {
                ImageCacheManager.shared.cache.setObject(
                    image, forKey: NSString(string: filePath.path)
                )
                DispatchQueue.main.async {
                    completion?(image)
                }
                return
            }
        }

        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: imageUrl) { data, _, err in
                if err != nil {
                    DispatchQueue.main.async {
                        completion?(UIImage())
                    }
                    return
                }
                if let data, let image = UIImage(data: data) {
                    ImageCacheManager.shared.cache.setObject(
                        image, forKey: cacheKey
                    )
                    FileManager.default.createFile(
                        atPath: filePath.path,
                        contents: data,
                        attributes: nil
                    )
                    DispatchQueue.main.async {
                        completion?(image)
                    }
                }

            }.resume()
        }
    }
}
