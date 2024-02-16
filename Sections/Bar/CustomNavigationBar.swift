//
//  CustomNavigationBar.swift
//  Sections
//
//  Created by Эля Корельская on 16.02.2024.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    // MARK: - UI

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Видео"
        label.textColor = .black
        return label
    }()

    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.textAlignment = .left
        label.text = "Мои"
        label.textColor = fontColor
        return label
    }()

    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = fontColor
        return view
    }()

    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        return button
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    // MARK: - Properties

    var selectedSectionIndex: Int = 0
    var sectionTitles = ["Для вас", "Тренды", "Подписки", "Трансляции", "Спорт", "Киберспорт и игры", "Фильмы", "Сериалы", "Детям", "Популярное"]
    var fontSize: CGFloat = 14
    var fontColor: UIColor = .gray
    var underlineHeight: CGFloat = 2
    var underlineColor: UIColor = UIColor(red: 0.56, green: 0.7216, blue: 1, alpha: 1)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(addButton)
        addSubview(searchButton)
        addSubview(myLabel)
        addSubview(separatorView)
        addSubview(collectionView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            myLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            myLabel.heightAnchor.constraint(equalToConstant: 25),

            separatorView.leadingAnchor.constraint(equalTo: myLabel.trailingAnchor, constant: 18),
            separatorView.topAnchor.constraint(equalTo: myLabel.topAnchor),
            separatorView.bottomAnchor.constraint(equalTo: myLabel.bottomAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 1),

            addButton.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -20),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionView.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
            collectionView.heightAnchor.constraint(equalTo: separatorView.heightAnchor),
        ])
    }
}
extension CustomNavigationBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let label = UILabel()
        label.text = sectionTitles[indexPath.item]
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.sizeToFit()
        let labelWidth = label.frame.width

        return CGSize(width: labelWidth + padding, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel()
        let underlineView = UIView()
        label.text = sectionTitles[indexPath.item]
        label.textColor = fontColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.sizeToFit()
        underlineView.backgroundColor = underlineColor
        label.translatesAutoresizingMaskIntoConstraints = false
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(label)
        cell.addSubview(underlineView)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
            underlineView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: underlineHeight)
        ])

        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:))))
        underlineView.backgroundColor = indexPath.item == selectedSectionIndex ? underlineColor : .clear
        
        return cell
    }

    @objc func handleCellTap(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        selectedSectionIndex = indexPath.item
        collectionView.reloadData()
    }
    
}
