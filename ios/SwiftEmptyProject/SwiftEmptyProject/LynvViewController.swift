//
//  LynvViewController.swift
//  SwiftEmptyProject
//

import Foundation
import UIKit

class LynxViewController: UIViewController {
    var url: String

    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.title = "LynxViewController"

        render(url: self.url)
    }

    private func render(url: String) {
        // TODO: render LynxView here
    }
}
