//
//  HomeUserAvatarView.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/10.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import Lottie

//关注按钮
class HomeAvatarView : UIView {
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView();
        imageView.isUserInteractionEnabled = true
        return imageView;
    }()
    
    private lazy var followButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = UIColor.red
        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        return button;
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
    }()
    
    init(user: HomeModel.Author) {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(followButton)
        let followButtonHeight: CGFloat = 20
        imageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self)
            make.centerX.equalTo(self)
            make.width.height.equalTo(40)
            make.bottom.equalTo(self).offset(-followButtonHeight/2)
        }
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = true;
        imageView.addGestureRecognizer(tapGesture)
        
        followButton.snp.makeConstraints { make in
            make.width.height.equalTo(followButtonHeight)
            make.centerX.equalTo(self.imageView)
            make.bottom.equalTo(self)
        }
        
        if let url = user.avatarUrl {
            imageView.kf.setImage(with: .network(url));
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //拿到最原始的大小
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 50, height: 50)
        }
    }
    
    @objc func didClickButton() {
        
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        
    }
    
}


//点赞按钮
class HomeLikeButton: UIView {
    
    private let likeAnimationView : LottieAnimationView = LottieAnimationView(name: "icon_home_like_new")
    private let disLikeAnimationView : LottieAnimationView = LottieAnimationView(name: "icon_home_dislike_new")
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "123w"
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 1
        return label
    }()
    private var isLike = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(likeAnimationView)
        addSubview(disLikeAnimationView)
        addSubview(label)
        
        setAnimationViewHidden(isLike: true)
        likeAnimationView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.greaterThanOrEqualTo(self.snp_topMargin)
            make.bottom.equalTo(self.label.snp_topMargin).offset(5)
            make.centerX.equalTo(self)
        }
        
        disLikeAnimationView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.greaterThanOrEqualTo(self.snp.top)
            make.bottom.equalTo(self.label.snp.top).offset(5)
            make.centerX.equalTo(self)
        }
        
        label.snp.makeConstraints { make in
             make.leading.trailing.equalTo(0)
             make.height.equalTo(20)
             make.bottom.equalTo(self.snp.bottom)
         }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:)))
        addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(forName: .init(rawValue: "didTapLikeNotification"), object: nil, queue: .main) {[weak self]_ in
            guard self?.isLike != .some(true) else {
                return
            }
            self?.updateLikeState(true)
        }
    }
    
    deinit {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap(gesture: UITapGestureRecognizer) {
        updateLikeState(!self.isLike)
    }
    
    private func updateLikeState(_ isLike : Bool) {
        self.isLike = !isLike
        setAnimationViewHidden(isLike: isLike)
        if isLike {
            likeAnimationView.play(completion: nil)
        } else {
            disLikeAnimationView.play(completion: nil)
        }
    }
    
    private func setAnimationViewHidden(isLike : Bool) {
        likeAnimationView.isHidden = !isLike
        disLikeAnimationView.isHidden = isLike
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return CGSize(width: 50, height: 70)
        }
    }
}


