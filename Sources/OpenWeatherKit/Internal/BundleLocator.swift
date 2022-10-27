import Foundation

class BundleLocator {
    static let bundle: Bundle = {
#if SWIFT_PACKAGE
        let bundleName = "Localization_Localization"
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: BundleLocator.self).resourceURL,
            /* For command-line tools. */
            Bundle.main.bundleURL,
            /* Bundle should be present here when the package is used in UI Tests. */
            Bundle(for: BundleLocator.self).resourceURL?.deletingLastPathComponent(),
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: BundleLocator.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }

        fatalError("unable to find bundle named \(bundleName)")
#else
        return Bundle(for: BundleLocator.self)
#endif
    }()
}
