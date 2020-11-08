//
//  MainDemoCell.swift
//  iOS Example
//
//  Created by Greg Pape on 11/8/20.
//

import UIKit

final class MainDemoCell: UICollectionViewCell {

// MARK: - Interface

    @IBOutlet private weak var label: UILabel!

// MARK: - API

    var demo: MainViewModel.Demo? {
        didSet {
            demo.flatMap(configure(for:)) ?? clear()
        }
    }

}

// MARK: -

private extension MainDemoCell {

    func clear() {
        print(#function)
        label.text = nil
    }

    func configure(for demo: MainViewModel.Demo) {
        // TODO: L10n
        switch demo {
        case .collectiveBindings:
            label.text = "Collective Bindings"
        case .showreel:
            label.text = "Showreel"
        }
    }

}

// MARK: - : UICollectionViewCell

extension MainDemoCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        demo = nil
    }

}
