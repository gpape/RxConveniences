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

        vm.rx.wave
            .map { [weak self] radius in
                self?.views(in: radius)
            }
            .emit { [vm] views in
                views?.all.displayColor = vm.color
            }
            .disposed(by: bag)

    }

    private func create(at position: Showreel.Position) {

        let newView = ShowreelViewFactory.make(at: position)
        newView.alpha = 0
        newView.displayColor = vm.color
        newView.translatesAutoresizingMaskIntoConstraints = false
        canvas.addSubview(newView)

        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 250
        transform = CATransform3DTranslate(transform, 0, 0, position.z)
        newView.layer.transform = transform
        newView.layer.zPosition = position.z

        let y = newView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor, constant: position.y)

        NSLayoutConstraint.activate([
            newView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor, constant: position.x),
            y
        ])

        DispatchQueue.main.async {

            y.constant -= UIScreen.height

            UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                newView.alpha = 1 - 0.8 * (abs(position.z) / 400).clamped
            }, completion: nil)

            UIView.animate(withDuration: 10, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                self.canvas.layoutIfNeeded()
            }, completion: nil)

//            UIView.animate(withDuration: 0.3, delay: 9.7, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
//                newView.alpha = 0
//            }, completion: { _ in
//                newView.removeFromSuperview()
//            })

        }

    }

}

// MARK: -

final class ShowreelViewController: UIViewController {

// MARK: - Interface

    @IBOutlet private weak var canvas: UIView!
    @IBOutlet private weak var contents: UIView!
    @IBOutlet private weak var gradientView: GradientView!
    
// MARK: -

    private let bag = DisposeBag()
    private let vm = ShowreelViewModel()

}

// MARK: - UI

private extension ShowreelViewController {

    private static let viewOrigin = Showreel.Position(x: UIScreen.width, y: UIScreen.height, z: Showreel.origin.z)

    func views(in radius: CGFloat) -> [UIView] {
        canvas.subviews.filter { view in
            guard let position = view.position else {
                return false
            }
            if Showreel.FeatureFlags.debug, let label = view as? UILabel {
                label.text = ShowreelViewFactory.numberFormatter.string(from: NSNumber(value: abs(Double(position.distance(to: Self.viewOrigin)))))
            }
            guard
                position.distance(to: Self.viewOrigin) < radius,
                view.displayColor != self.vm.color
            else {
                return false
            }
            return true
        }
    }

}

private extension UIView {

    var position: Showreel.Position? {
        guard let layer = layer.presentation() else {
            return nil
        }
        return .init(x: layer.position.x, y: layer.position.y, z: layer.zPosition)
    }

}

// MARK: - : UIViewController

extension ShowreelViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRx()
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 1000
        transform = CATransform3DRotate(transform, -.pi / 32, 0, 1, 0)
        contents.layer.transform = transform
        gradientView.gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor]
    }

}
