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
        anchor.clipsToBounds = false // TODO: this is it. control in front?
        anchor.backgroundColor = .red
        anchor.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anchor)

        let y = anchor.centerYAnchor.constraint(equalTo: view.topAnchor, constant: position.y)

        NSLayoutConstraint.activate([
            anchor.widthAnchor.constraint(equalToConstant: 1),
            anchor.heightAnchor.constraint(equalToConstant: 1),
            anchor.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: position.x),
            y
        ])

        // transform?
        anchor.layer.zPosition = position.z
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 250
        transform = CATransform3DTranslate(transform, 0, 0, position.z)
        anchor.layer.transform = transform

        let control = UISwitch(frame: .init(x: 0, y: 0, width: 44, height: 44))
        control.isEnabled = true
        control.isUserInteractionEnabled = true
        control.layer.borderColor = UIColor.red.cgColor
        control.layer.borderWidth = 1
        control.translatesAutoresizingMaskIntoConstraints = false
        anchor.addSubview(control)

        NSLayoutConstraint.activate([
            control.centerXAnchor.constraint(equalTo: anchor.centerXAnchor),
            control.centerYAnchor.constraint(equalTo: anchor.centerYAnchor)
        ])

        view.layoutIfNeeded()

//        NSLayoutConstraint.deactivate([y])
//        y.constant -= UIScreen.main.bounds.height
//        NSLayoutConstraint.activate([y])
//        view.setNeedsUpdateConstraints()

//        UIView.animate(withDuration: 10) {
//            self.view.layoutIfNeeded()
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
