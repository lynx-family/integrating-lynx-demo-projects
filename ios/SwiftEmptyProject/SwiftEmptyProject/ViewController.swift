//
//  ViewController.swift
//  SwiftEmptyProject
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
//        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    private func setupUI() {
            self.view.backgroundColor = .white

            let label = UILabel()
            label.text = "Hello Lynx!"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 30)

            self.view.addSubview(label)

            let button = UIButton()
            button.setTitle("Go", for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.blue, for: .highlighted)
            button.addAction(UIAction{ [weak self] _ in
                // TODO: change url to lynx bundle url here
                let url = ""
                guard url.count > 0 else {
                    let alertController = UIAlertController(
                        title: "Warning", message: "Please modify url", preferredStyle: .alert)
                    self?.present(alertController, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        alertController.dismiss(animated: true, completion: nil)
                    }
                    return
                }

                let vc = LynxViewController(url: url)
                self?.navigationController?.pushViewController(vc, animated: true)

            }, for: .touchUpInside)
            self.view.addSubview(button)

            label.translatesAutoresizingMaskIntoConstraints = false
            button.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

                button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
                button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            ])
        }

}

