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
        label.text = titleLabelText
        label.textColor = UIColor(named: "CustomBlack")
        return label
    }()

    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.textAlignment = .left
        label.text = myLabelText
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
        button.tintColor = UIColor(named: "CustomBlack")
        return button
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(named: "CustomBlack")
        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = CGFloat(cornerRadiusTable)
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tableView.clipsToBounds = true
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var dimmingView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = true
        return view
    }()

    // MARK: - Properties

    var selectedSectionIndex: Int = 0
    var sectionTitles = [""]
    var titleLabelText = "Видео"
    var myLabelText = "Мои"
    var fontSize: CGFloat = 14
    var fontColor: UIColor = .gray
    var underlineHeight: CGFloat = 2
    var cornerRadiusTable = 15
    var underlineColor: UIColor = UIColor(red: 0.56, green: 0.7216, blue: 1, alpha: 1)
    var isTableViewVisible = false

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
        addSubview(tableView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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

            tableView.topAnchor.constraint(equalTo: myLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 132),
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
        isTableViewVisible.toggle()
        tableView.isHidden = !isTableViewVisible
//        if !tableView.isHidden {
//            addSubview(dimmingView)
//            bringSubviewToFront(dimmingView)
//            dimmingView.isHidden = false
//        } else {
//            dimmingView.isHidden = true
//        }
        tableView.reloadData()
    }

    
}
extension CustomNavigationBar: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Для вас"
            cell.tintColor = underlineColor
            if let checkmarkImage = UIImage(systemName: "checkmark.circle.fill") {
                let checkmarkImageView = UIImageView(image: checkmarkImage)
                checkmarkImageView.tintColor = underlineColor
                cell.accessoryView = checkmarkImageView
            }
            if let iconImage = UIImage(systemName: "list.bullet.rectangle.portrait.fill") {
                cell.imageView?.image = iconImage
                cell.imageView?.tintColor = underlineColor
            }
        case 1:
            cell.textLabel?.text = "Друзья"
            if let iconImage = UIImage(systemName: "person.2.fill") {
                cell.imageView?.image = iconImage
                cell.imageView?.tintColor = underlineColor
            }
        case 2:
            cell.textLabel?.text = "Фотографии"
            if let iconImage = UIImage(systemName: "photo") {
                cell.imageView?.image = iconImage
                cell.imageView?.tintColor = underlineColor
            }
        default:
            break
        }
        cell.textLabel?.textColor = fontColor
        cell.textLabel?.font =  UIFont.systemFont(ofSize: fontSize)
        return cell
    }
}

