import Foundation

class DemoLynxProvider: NSObject, LynxTemplateProvider {
  func loadTemplate(withUrl url: String!, onComplete callback: LynxTemplateLoadBlock!) {
    if let filePath = Bundle.main.path(forResource: url, ofType: "bundle") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        callback(data, nil)
      } catch {
        print("Error reading file: \(error.localizedDescription)")
        callback(nil, error)
      }
    } else {
      let urlError = NSError(domain: "com.lynx", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL."])
      callback(nil, urlError)
    }
  }
}
