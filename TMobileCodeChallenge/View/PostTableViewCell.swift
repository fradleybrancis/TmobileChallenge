//
//  PostTableViewCell.swift
//  TMobileCodeChallenge
//
//  Created by Rave BizzDev on 9/26/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    public static let identifier = "post"
    
    var postViewModel: PostViewModel! {
        didSet {
            aspectRatio = (postViewModel.ratio*100).rounded()/100
            postTitle.text = postViewModel.postTitle
            numComments.text = "\(postViewModel.postCommentsNum)"
            numScore.text = "\(postViewModel.postScore)"
            loadImage(urlString: postViewModel.imageURLString)
            configureViews()
            setupConstraints()
        }
    }
    
    var postTitle = UILabel()
    var numComments = UILabel()
    var numScore = UILabel()
    
    var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        return imageView
    }()
    
    var commentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bubble.left.fill")
        return imageView
    }()
    
    var scoreImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.thumbsup.fill")
        return imageView
    }()
    
    private var aspectRatio: CGFloat = 1
    
    private func loadImage(urlString: String) {
        PostImageCache.shared.loadImage(from: urlString) { image in
            self.postImage.image = image
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        addSubviews(postTitle, postImage, numScore, numComments, commentImage, scoreImage)
        
        func configurePostTitle() {
            postTitle.numberOfLines = 0
            postTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            postTitle.adjustsFontSizeToFitWidth = true
            postTitle.textAlignment = .left
        }
        
        func configureImage() {
            postImage.clipsToBounds = true
        }
        func configureComments() {
            numComments.numberOfLines = 0
            numComments.textAlignment = .left
            numComments.font = .boldSystemFont(ofSize: 10)
        }
        func configureScore() {
            numScore.numberOfLines = 0
            numScore.textAlignment = .left
            numScore.font = .boldSystemFont(ofSize: 10)
        }
        configurePostTitle()
        configureImage()
        configureComments()
        configureScore()
    }
    
    private func setupConstraints() {
        func setTitleConstraints() {
            postTitle.leadingAnchor.constrain(to: leadingAnchor, with: Dimensions.padding)
            postTitle.trailingAnchor.constrain(to: trailingAnchor, with: Dimensions.rightPadding)
            postTitle.topAnchor.constrain(to: topAnchor, with: Dimensions.padding/2)
        }
        
        func setImageConstraints() {
            postImage.leadingAnchor.constrain(to: leadingAnchor)
            postImage.trailingAnchor.constrain(to: trailingAnchor)
            postImage.topAnchor.constrain(to: postTitle.bottomAnchor, with: Dimensions.padding)
            postImage.heightAnchor.constrain(to: postImage.widthAnchor, multiplyBy: aspectRatio)
        }
        func setCommentImageConstraints() {
            commentImage.topAnchor.constrain(to: postImage.bottomAnchor, with: Dimensions.padding)
            commentImage.leadingAnchor.constrain(to: leadingAnchor, with: Dimensions.largerPadding)
        }
        
        func setScoreConstraints() {
            numScore.leadingAnchor.constrain(to: scoreImage.trailingAnchor)
            numScore.centerYAnchor.constrain(to: scoreImage.centerYAnchor)
            numScore.widthAnchor.constrain(to: widthAnchor, multiplyBy: Dimensions.fourthRatio)
        }
        
        func setNumCommentsConstraints() {
            numComments.leadingAnchor.constrain(to: commentImage.trailingAnchor)
            numComments.centerYAnchor.constrain(to: commentImage.centerYAnchor)
            numComments.widthAnchor.constrain(to: widthAnchor, multiplyBy: Dimensions.fourthRatio)
        }
        func setScoreImageConstraints() {
            scoreImage.topAnchor.constrain(to: commentImage.bottomAnchor, with: Dimensions.padding)
            scoreImage.leadingAnchor.constrain(to: leadingAnchor, with: Dimensions.largerPadding)
            scoreImage.bottomAnchor.constrain(to: bottomAnchor)
        }
        
        setTitleConstraints()
        setImageConstraints()
        setScoreConstraints()
        setScoreImageConstraints()
        setCommentImageConstraints()
        setNumCommentsConstraints()
    }
}
