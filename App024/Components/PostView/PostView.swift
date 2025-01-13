//
//  PostView.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import UIKit
import AVFoundation
import Photos

class PostView: UIView, IReusableView {

    private var playerLayer: AVPlayerLayer?
    public var player: AVPlayer?
    private let playPauseButton = UIButton(type: .custom)
    private let downloadButton = UIButton(type: .custom)

    public func setup(image: UIImage) {
        self.clearPreviousContent()
        playerLayer = nil
        player = nil

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        addSubview(imageView)
        imageView.frame = bounds
    }

    public func setupVideo(url: URL) {
        self.clearPreviousContent()

        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill

        if let playerLayer = playerLayer {
            layer.addSublayer(playerLayer)
            playerLayer.frame = bounds
        }

        setupPlayPauseButton()
        setupDownloadButton()
        player?.play()
    }

    @objc private func setupPlayPauseButton() {
        playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        playPauseButton.tintColor = .white
        playPauseButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        playPauseButton.layer.cornerRadius = 14
        playPauseButton.clipsToBounds = true
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)

        addSubview(playPauseButton)

        playPauseButton.snp.makeConstraints { view in
            view.leading.equalToSuperview().offset(8)
            view.bottom.equalToSuperview().inset(8)
            view.width.equalTo(28)
            view.height.equalTo(28)
        }
    }

    private func setupDownloadButton() {
        downloadButton.setImage(UIImage(named: "downloadIcon"), for: .normal)
        downloadButton.tintColor = .white
        downloadButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        downloadButton.layer.cornerRadius = 14
        downloadButton.clipsToBounds = true
        downloadButton.addTarget(self, action: #selector(downloadVideo), for: .touchUpInside)

        addSubview(downloadButton)

        downloadButton.snp.makeConstraints { view in
            view.trailing.equalToSuperview().inset(8)
            view.bottom.equalToSuperview().inset(8)
            view.width.equalTo(28)
            view.height.equalTo(28)
        }
    }

    @objc private func playPauseTapped() {
        guard let player = player else { return }

        if player.timeControlStatus == .playing {
            player.pause()
            playPauseButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            player.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
    }

    @objc private func downloadVideo() {
        guard let player = player else { return }
        guard let url = player.currentItem?.asset as? AVURLAsset else {
            print("Invalid video asset")
            return
        }

        let videoURL = url.url
        UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, self, #selector(self.videoSavedToGallery(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func videoSavedToGallery(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving video: \(error.localizedDescription)")
        } else {
            print("Video saved to gallery successfully!")
        }
    }

    private func clearPreviousContent() {
        subviews.forEach { $0.removeFromSuperview() }
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
}

