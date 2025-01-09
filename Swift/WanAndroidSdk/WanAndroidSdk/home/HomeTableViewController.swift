//
//  HomeTableViewController.swift
//  WxiOSPalmDa
//
//  Created by 杨充 on 2024/12/10.
//

import Foundation
import UIKit
import SnapKit
import AVFAudio
import AVFoundation
import Lottie

//视频流的tabview控制器，仿抖音上下滑动

class HomeTableViewController : UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    private var tableView : UITableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置tableview
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.isPagingEnabled = true;
        tableView.showsVerticalScrollIndicator = false;
        tableView.contentInsetAdjustmentBehavior = .never
        //是否可以支持选中
        tableView.allowsSelection = false;
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseIdenfitifer)
        
        self.view.addSubview(tableView)
        
        //设置 audio session，这个是swift调用oc
        let session = AVAudioSession.sharedInstance();
        try? session.setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        //处理前后台播放
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: OperationQueue.main) {[weak self] _ in
            self?.pause()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: OperationQueue.main) {[weak self] _ in
            self?.pause()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds;
    }
    
    private func play(){
        tableView.visibleCells.forEach { cell in
            (cell as? HomeTableViewCell)?.play()
        }
    }
    
    private func pause() {
        tableView.visibleCells.forEach { cell in
            (cell as? HomeTableViewCell)?.pause()
        }
    }
    
    //通过这个方法，设置自己去管理生命周期
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("tableView开始显示 \(indexPath)")
        //cell开始显示了
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        //第一个参数，表示
        cell.viewContrller?.beginAppearanceTransition(true, animated: false)
        cell.viewContrller?.endAppearanceTransition()
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("tableView开始销毁 \(indexPath)")
        //cell不被显示了
        guard let cell = cell as? HomeTableViewCell else {
            return
        }
        //第一个参数，表示
        cell.viewContrller?.beginAppearanceTransition(false, animated: false)
        cell.viewContrller?.endAppearanceTransition()
    }
    
    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    //MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseIdenfitifer, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomYcColor
        if let cell = cell as? HomeTableViewCell {
            cell.config(HomeModel())
        }
        return cell
    }
}

//自定义cell
class HomeTableViewCell : UITableViewCell {
    
    static let reuseIdenfitifer = "HomeTableViewCell"
    var viewContrller : HomeViewController?
    
    func config(_ model : HomeModel) {
        viewContrller?.view.removeFromSuperview()
        let vc = HomeViewController(with: model)
        viewContrller = vc;
        contentView.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    func play() {
        viewContrller?.play()
    }
    
    func pause() {
        viewContrller?.pause()
    }
    
}

//承载抖音cell容器
class HomeViewController : UIViewController {
    
    private var homeModel: HomeModel;
    private var player: AVPlayer?
    private lazy var playerView : PlayerView = {
        PlayerView(player: self.player);
    }()
    
    private lazy var avatarButton: HomeAvatarView = {
        return HomeAvatarView(user: self.homeModel.author ??
                              HomeModel.Author(id: "0", name: "未知"))
    }()

    private lazy var likeButton: HomeLikeButton =  {
        let button = HomeLikeButton(frame: .zero)
        return button
    }()

    private lazy var commentButton: UIButton =  {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_home_comment"), for: .normal)
        return button
    }()

    private lazy var shareButton: UIButton =  {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_home_share"), for: .normal)
        return button
    }()

    private lazy var rightButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private lazy var pauseImageView : UIImageView = {
        let imageView = UIImageView();
        imageView.image = UIImage(named: "icon_feed_white_pause")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(with homeModel: HomeModel) {
        self.homeModel = homeModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view加载出来后
        player = AVPlayer(url: homeModel.videoUrl!)
        view.addSubview(playerView)
        playerView.snp.makeConstraints { make in
            //布局
            make.edges.equalTo(0)
        }
        
        self.view.addSubview(rightButtonsStackView)
        rightButtonsStackView.addArrangedSubview(avatarButton)
        rightButtonsStackView.addArrangedSubview(likeButton)
        rightButtonsStackView.addArrangedSubview(commentButton)
        rightButtonsStackView.addArrangedSubview(shareButton)
        rightButtonsStackView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.bottom.equalTo(self.view.snp_bottomMargin).offset(-200)
            make.trailing.equalTo(self.view.snp_trailingMargin).offset(-10)
        }
        
        view.addSubview(pauseImageView)
        pauseImageView.snp.makeConstraints { make in
            make.center.equalTo(self.view.center)
        }
        pauseImageView.isHidden = true
    
        //1 点击屏幕，暂停播放，继续播放
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(gesture:)))
        singleTapGesture.numberOfTapsRequired = 1
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2
        //需要处理双击失败情况，才处理单击
        singleTapGesture.require(toFail: doubleTapGesture)
        view.addGestureRecognizer(singleTapGesture)
        view.addGestureRecognizer(doubleTapGesture)
        
        //2 player loop
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { [weak self] _ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //将要出现
        play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //将要消失
        pause()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    @objc func singleTap(gesture: UITapGestureRecognizer) {
        print("单击视图View");
        guard let player = player else {
            return
        }
        if player.rate > 0 {
            pause()
            pauseImageView.isHidden = false
        } else {
            play()
            pauseImageView.isHidden = true
        }
    }
    
    @objc func doubleTap(gesture: UITapGestureRecognizer) {
        print("双击视图View");
        
        let animationView = LottieAnimationView(name: "icon_home_like_new")
        let location = gesture.location(in: view)
        let size = CGSize(width: 80, height: 80)
        let origin = CGPoint(x: location.x - size.width/2, y: location.y - size.height/2)
        animationView.frame = CGRect(origin: origin, size: size)
        view.addSubview(animationView)
        animationView.play(completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
            animationView.removeFromSuperview()
        }
        //发一个通知
        NotificationCenter.default.post(name: .init(rawValue: "didTapLikeNotification"), object: nil)
    }
}

//视频播放view
class PlayerView : UIView {
    
    private var playerLayer: AVPlayerLayer;
    
    init(player: AVPlayer?) {
        //创建
        playerLayer = AVPlayerLayer(player: player)
        //初始化
        super.init(frame: .zero)
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //充满屏幕
        playerLayer.frame = bounds;
    }
}

//创建一个结构体，有点类似android中的bean
struct HomeModel {
    
    //作者结构体
    struct Author {
        var id: String?
        var name: String?
        var avatarUrl: URL? = URL(string: "https://img2.baidu.com/it/u=1830630236,400177773&fm=253&fmt=auto&app=138&f=JPEG?w=1067&h=800")
    }
    
    var id: String?
    //注意：App Transport Security Settings，需要配置http请求，在info中
    var videoUrl: URL? = URL(string: "http://vjs.zencdn.net/v/oceans.mp4")
    //var videoUrl: URL? = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
    var author: Author?
    var coverUrl: URL?
    var likeCount: String?
    
}
