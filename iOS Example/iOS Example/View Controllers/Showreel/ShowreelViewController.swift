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

        let control = UISwitch(frame: .init(x: 0, y: 0, width: 44, height: 44))
        control.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(control)

        let anchor = UIView()
        anchor.translatesAutoresizingMaskIntoConstraints = false
        control.addSubview(anchor)

        let y = anchor.centerYAnchor.constraint(equalTo: view.topAnchor, constant: position.y)

        NSLayoutConstraint.activate([
            anchor.widthAnchor.constraint(equalToConstant: 1),
            anchor.heightAnchor.constraint(equalToConstant: 1),
            anchor.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: position.x),
            y,
            control.centerXAnchor.constraint(equalTo: anchor.centerXAnchor),
            control.centerYAnchor.constraint(equalTo: anchor.centerYAnchor)
        ])

        control.layer.zPosition = position.z
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 250
        transform = CATransform3DTranslate(transform, 0, 0, position.z)
        control.layer.transform = transform

//        control.layoutIfNeeded()
//
//        y.constant -= 10//UIScreen.main.bounds.height
//        UIView.animate(withDuration: 10) {
//            control.layoutIfNeeded()
//        }

    }

}

// MARK: -

final class ShowreelViewController: UIViewController {

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
