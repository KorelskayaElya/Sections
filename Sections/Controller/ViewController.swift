//
//  ViewController.swift
//  Sections
//
//  Created by Эля Корельская on 16.02.2024.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    let customNavBar = CustomNavigationBar(frame: .zero)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        constraints()
        customNavBar.sectionTitles = ["Для вас", "Тренды", "Подписки", "Трансляции", "Спорт", "Киберспорт и игры", "Фильмы", "Сериалы", "Детям", "Популярное"]
    }

    // MARK: - Private

    private func constraints() {
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customNavBar)

        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

