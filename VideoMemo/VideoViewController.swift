//
//  VideoViewController.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/20.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    
    var player = AVPlayer()
    var timeObserverToken: Any?
    
    var itemDuration: Double = 0
    
    var transferedImage: UIImage? = nil
    var transferedCaptureTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioSession()
        setupPlayer()
        slider.value = 0.0
    }
    
    //動画選択・表示
    @IBAction func selectVideo() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
        picker.mediaTypes = ["public.movie"]
        
        picker.videoQuality = .typeHigh
        picker.videoExportPreset = AVAssetExportPresetHighestQuality
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let movieUrl = info[.mediaURL] as? URL else { return }
        
        // replacePlayerItem
        let asset = AVAsset(url: movieUrl)
        itemDuration = CMTimeGetSeconds(asset.duration)
        let item = AVPlayerItem(url: movieUrl)
        player.replaceCurrentItem(with: item)
        
    }
    
    //動画再生
    //Audio sessionを動画再生向けのものに設定
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        do {
            try audioSession.setActive(true)
            //            print("audio session set active !!")
        } catch {
        }
    }
    
    //AVPlayerをAVPlayerLayerと結びつける
    private func setupPlayer() {
        playerView.player = player
        addPeriodicTimeObserver()
    }
    
    //再生・停止
    @IBAction func playBtnTapped(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let seconds = Double(sender.value) * itemDuration
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: seconds, preferredTimescale: timeScale)
        
        changePosition(time: time)
    }
    
    //スライダー
    private func updateSlider() {
        let time = player.currentItem?.currentTime() ?? CMTime.zero
        if itemDuration != 0 {
            slider.value = Float(CMTimeGetSeconds(time) / itemDuration)
        }
    }
    
    private func changePosition(time: CMTime) {
        let rate = player.rate
        // いったんplayerをとめる
        player.rate = 0
        // 指定した時間へ移動
        player.seek(to: time, completionHandler: {_ in
            // playerをもとのrateに戻す(0より大きいならrateの速度で再生される)
            self.player.rate = rate
        })
    }
    
    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                           queue: .main)
        { [weak self] time in
            // update player transport UI
            DispatchQueue.main.async {
                //print("update timer:\(CMTimeGetSeconds(time))")
                //時間表示
                self!.timeLabel.text = CMTime(value: time.value, timescale: time.timescale).positionalTime
                // sliderを更新
                self?.updateSlider()
            }
        }
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    @IBAction func takeScreenShot() {
        if let url: URL = (player.currentItem?.asset as? AVURLAsset)?.url {
            // サムネイル生成
            let avAsset = AVAsset(url: url)
            let generator = AVAssetImageGenerator(asset: avAsset)
            generator.appliesPreferredTrackTransform = true
            generator.requestedTimeToleranceAfter = .zero
            generator.requestedTimeToleranceBefore = .zero
            let duration = avAsset.duration
            
            let time = player.currentItem?.currentTime() ?? CMTime.zero
            let capturedImage = try! generator.copyCGImage(at: time, actualTime: nil)
            let image = UIImage(cgImage: capturedImage)
            
            //            let nextView = self.storyboard?.instantiateViewController(withIdentifier: "NewMemo") as! NewMemoViewController
            //            self.navigationController?.pushViewController(nextView, animated: true)
            transferedImage = image
            transferedCaptureTime = CMTime(value: time.value, timescale: time.timescale).positionalTime
            
            self.performSegue(withIdentifier: "toNewMemoViewController", sender: nil)
        } else {
            let alert = UIAlertController(title: "動画未選択", message: "動画を選択してください", preferredStyle: .alert)
            //ここから追加
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            //ここまで追加
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewMemoViewController" {
            let nextView = segue.destination as! NewMemoViewController
            nextView.image = transferedImage
            nextView.captureTime = transferedCaptureTime
        }
    }
    
}

//CMTimeをstringにconvert
extension CMTime {
    var roundedSeconds: TimeInterval {
        return seconds.rounded()
    }
    var hours:  Int { return Int(roundedSeconds / 3600) }
    var minute: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 60)) }
    var positionalTime: String {
        return hours > 0 ?
        String(format: "%d:%02d:%02d", hours, minute, second) :
        String(format: "%02d:%02d", minute, second)
    }
}
