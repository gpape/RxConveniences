//
//  ShowreelViewController.swift
//  iOS Example
//
//  Created by Greg Pape on 11/26/20.
//

import RxCocoa
import RxSwift
import UIKit

// MARK: - The gist

private extension ShowreelViewController {

    func configureRx() {

        vm.rx.spawn
            .emit { [weak self] position in
                self?.create(at: position)
            }
            .disposed(by: bag)

    }

    private func create(at position: Showreel.Position) {

        let anchor = UIView()
        anchor.translatesAutoresizingMaskIntoConstraints = false
        anchorsContainer.addSubview(anchor)

        let y = anchor.centerYAnchor.constraint(equalTo: anchorsContainer.centerYAnchor, constant: position.y)

        NSLayoutConstraint.activate([
            anchor.widthAnchor.constraint(equalToConstant: 1),
            anchor.heightAnchor.constraint(equalToConstant: 1),
            anchor.centerXAnchor.constraint(equalTo: anchorsContainer.centerXAnchor, constant: position.x),
            y
        ])

        let control = UISwitch()
        control.isOn = true
        control.translatesAutoresizingMaskIntoConstraints = false
        canvas.addSubview(control)

        control.layer.zPosition = position.z
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 250
        transform = CATransform3DTranslate(transform, 0, 0, position.z)
        control.layer.transform = transform

        NSLayoutConstraint.activate([
            control.centerXAnchor.constraint(equalTo: anchor.centerXAnchor),
            control.centerYAnchor.constraint(equalTo: anchor.centerYAnchor)
        ])

        DispatchQueue.main.async {
            y.constant -= UIScreen.height
            UIView.animate(withDuration: 10, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }

    }

}

// MARK: -

final class ShowreelViewController: UIViewController {

// MARK: - Interface

    @IBOutlet private weak var anchorsContainer: UIView!
    @IBOutlet private weak var canvas: UIView!

// MARK: -

    private let bag = DisposeBag()
    private let vm = ShowreelViewModel()

}

// MARK: - : UIViewController

extension ShowreelViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
    }

}
