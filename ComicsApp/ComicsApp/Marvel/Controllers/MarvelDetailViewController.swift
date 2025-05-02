import Foundation
import UIKit
import SDWebImage

class MarvelDetailViewController: UIViewController {
    
    // MARK: - Properties
    var character: MarvelCharacterViewModel?
    
    private var responsiveButtons: [UIButton] = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemYellow.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        let baseFont = UIFont(name: "Impact", size: 25)!
        label.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.textColor = .systemYellow
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .backgroundColor
        
        setupUI()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeStackView()
    }
    
    // MARK: - UI Setup Methods
    private func createBoxView(title: String, content: String) -> MarvelBoxView {
        let boxView = MarvelBoxView(title: title, content: content)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        return boxView
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        let characterBox = createBoxView(title: "Description", content: character?.description ?? "No description")
        let comicsBox = createBoxView(title: "Comics", content: "• \(character?.comics.joined(separator: "\n •") ?? "")")
        comicsBox.tag = 1
        let storiesBox = createBoxView(title: "Stories", content: "• \(character?.stories.joined(separator: "\n •") ?? "")")
        storiesBox.tag = 2
        let seriesBox = createBoxView(title: "Series", content: "• \(character?.series.joined(separator: "\n •") ?? "")")
        seriesBox.tag = 3
        let eventsBox = createBoxView(title: "Events", content: "• \(character?.events.joined(separator: "\n •") ?? "")")
        eventsBox.tag = 4
        
        characterBox.setup()
        comicsBox.setup()
        storiesBox.setup()
        seriesBox.setup()
        eventsBox.setup()
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        let comicsButton = MarvelCreateButtons.createButton(title: "Comics", action:  #selector(scrollToComicsBox))
        let storiesButton = MarvelCreateButtons.createButton(title: "Stories", action: #selector(scrollToStoriesBox))
        let seriesButton = MarvelCreateButtons.createButton(title: "Series", action: #selector(scrollToSeriesBox))
        let eventsButton = MarvelCreateButtons.createButton(title: "Events", action: #selector(scrollToEventsBox))
        
        responsiveButtons = [comicsButton, storiesButton, seriesButton, eventsButton]
        responsiveButtons.forEach { buttonsStackView.addArrangedSubview($0) }
        
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(characterBox)
        contentView.addSubview(comicsBox)
        contentView.addSubview(storiesBox)
        contentView.addSubview(seriesBox)
        contentView.addSubview(eventsBox)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            buttonsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            characterBox.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20),
            characterBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            comicsBox.topAnchor.constraint(equalTo: characterBox.bottomAnchor, constant: 20),
            comicsBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            comicsBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            storiesBox.topAnchor.constraint(equalTo: comicsBox.bottomAnchor, constant: 20),
            storiesBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storiesBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            seriesBox.topAnchor.constraint(equalTo: storiesBox.bottomAnchor, constant: 20),
            seriesBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seriesBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            eventsBox.topAnchor.constraint(equalTo: seriesBox.bottomAnchor, constant: 20),
            eventsBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventsBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Responsive StackView
    private func changeStackView() {
        let totalButtonWidth = responsiveButtons.reduce(0) { $0 + $1.intrinsicContentSize.width }
            let spacing = buttonsStackView.spacing * CGFloat(responsiveButtons.count - 1)
            let totalWidth = totalButtonWidth + spacing
            let availableWidth = view.bounds.width - contentView.layoutMargins.left - contentView.layoutMargins.right
            
            if totalWidth - 10 > availableWidth {
                buttonsStackView.axis = .vertical
                buttonsStackView.alignment = .fill
            } else {
                buttonsStackView.axis = .horizontal
                buttonsStackView.alignment = .center
            }
    }

    // MARK: - Configuration Methods
    private func configure() {
        guard let character = character else { return }
        nameLabel.text = character.name
        
        if let imageUrl = character.imageUrl {
            imageView.sd_setImage(with: imageUrl)
        }
    }
    
    @objc private func scrollToComicsBox() {
        scrollToView(withTag: 1)
    }
    
    @objc private func scrollToStoriesBox() {
        scrollToView(withTag: 2)
    }
    
    @objc private func scrollToSeriesBox() {
        scrollToView(withTag: 3)
    }
    
    @objc private func scrollToEventsBox() {
        scrollToView(withTag: 4)
    }
    
    private func scrollToView(withTag tag: Int) {
        if let targetView = contentView.viewWithTag(tag) {
            let offset = CGPoint(x: 0, y: targetView.frame.origin.y)
            scrollView.setContentOffset(offset, animated: true)
        }
    }
}
