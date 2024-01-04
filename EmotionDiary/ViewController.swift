//
//  ViewController.swift
//  EmotionDiary
//
//  Created by SUCHAN CHANG on 1/2/24.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet var slimeButtonList: [UIButton]!
    @IBOutlet var emotionLabelList: [UILabel]!
    
    let emotionNameList = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "행복해", "행복해"]
    
    var countList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        countList = getNumberOfButtonPressed()
        
        setupButtonTags()

        configureBackgroundImageView()
        configureNavigationItem()
        configureSlimeButtons()
    }
    
    func setupButtonTags() {
        for (index, button) in slimeButtonList.enumerated() {
            button.tag = index
        }
    }
    
    
    func getNumberOfButtonPressed() -> [Int] {
        guard
            let countList = UserDefaults.standard.array(forKey: "CountList") as? [Int]
        else {
            return Array(repeating: 0, count: 9)
        }
        return countList
    }
    
    @IBAction func slimeButtonTapped(_ sender: UIButton) {
        for (index, button) in slimeButtonList.enumerated() {
            if sender == button {
                countList[index] += 1
                UserDefaults.standard.set(countList, forKey: "CountList")
                emotionLabelList[index].text = "\(emotionNameList[index]) \(countList[index])"
                break
            }
        }
    }
    
    private func configureBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "backgroundImage")
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "감정 다이어리"
        let leftBarButtonItemImage = UIImage(systemName: "list.dash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButtonItemImage, style: .plain, target: self, action: #selector(leftBarButtonTapped))
    }
    
    private func configureSlimeButtons() {
        for (index, button) in slimeButtonList.enumerated() {
            button.setImage(UIImage(named: "slime\(index + 1)"), for: .normal)
            configureEmotionLabels(index, numberOfPressed: countList[index])
        }
    }
    
    private func configureEmotionLabels(_ index: Int = 0, numberOfPressed: Int) {
        emotionLabelList[index].text = "\(emotionNameList[index]) \(numberOfPressed)"
        emotionLabelList[index].textAlignment = .center
        emotionLabelList[index].font = .systemFont(ofSize: 17.0)
    }
    
    @objc func leftBarButtonTapped() {
        print("메뉴 눌림")
    }
}

