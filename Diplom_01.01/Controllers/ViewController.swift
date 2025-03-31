//
//  ViewController.swift
//  Diplom_01.01
//
//  Created by Maria on 14.02.25.
//

import UIKit

class ViewController: UIViewController {
    
    private let imageBackgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.MainVC.ImageName.mainBackground)
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let startBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.MainVC.BtnTitle.startBtn, for: .normal)
        btn.backgroundColor = Cnst.MainVC.Color.mainBtnColor
        btn.layer.cornerRadius = Cnst.mainCornerRadius
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Cnst.MainVC.Font.mainFont
        return btn
    }()
    private let recordsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.MainVC.BtnTitle.recordsBtn, for: .normal)
        btn.backgroundColor = Cnst.MainVC.Color.mainBtnColor
        btn.layer.cornerRadius = Cnst.mainCornerRadius
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Cnst.MainVC.Font.mainFont
        return btn
    }()
    private let settingsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.MainVC.BtnTitle.settingsBtn, for: .normal)
        btn.backgroundColor = Cnst.MainVC.Color.mainBtnColor
        btn.layer.cornerRadius = Cnst.mainCornerRadius
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Cnst.MainVC.Font.mainFont
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: ConfigureUI
    private func configureUI() {
        view.addSubview(imageBackgroundView)
        view.addSubview(startBtn)
        view.addSubview(recordsBtn)
        view.addSubview(settingsBtn)
        
        NSLayoutConstraint.activate([
            imageBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            startBtn.widthAnchor.constraint(equalToConstant: view.frame.size.width * Cnst.MainVC.UI.mainBtnPctScreen),
            startBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startBtn.bottomAnchor.constraint(equalTo: recordsBtn.topAnchor, constant: -Cnst.MainVC.UI.mainBtnVerticalSpacing),
            startBtn.heightAnchor.constraint(equalToConstant: Cnst.MainVC.UI.mainBtnHeight),
            
            recordsBtn.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            recordsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordsBtn.widthAnchor.constraint(equalToConstant: view.frame.size.width * Cnst.MainVC.UI.mainBtnPctScreen),
            recordsBtn.heightAnchor.constraint(equalToConstant: Cnst.MainVC.UI.mainBtnHeight),
            
            settingsBtn.topAnchor.constraint(equalTo: recordsBtn.bottomAnchor, constant: Cnst.MainVC.UI.mainBtnVerticalSpacing),
            settingsBtn.widthAnchor.constraint(equalToConstant: view.frame.size.width * Cnst.MainVC.UI.mainBtnPctScreen),
            settingsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsBtn.heightAnchor.constraint(equalToConstant: Cnst.MainVC.UI.mainBtnHeight)
        ])
         
        let startBtnAction = UIAction { _ in
            print("Start")
            self.animateClickBtn(for: self.startBtn)
            self.openGameViewController()
        }
        startBtn.addAction(startBtnAction, for: .touchUpInside)
        
        
        let recordsBtnAction = UIAction { _ in
            print("Records")
            self.animateClickBtn(for: self.recordsBtn)
            self.openRecordsViewController()
        }
        recordsBtn.addAction(recordsBtnAction, for: .touchUpInside)
        
        
        let settingsBtnAction = UIAction { _ in
            print("Settings")
            self.animateClickBtn(for: self.settingsBtn)
            self.openSettingsViewController()
            // подгружаем настройки из UserDefaults
            self.loadGameSettings()
        }
        settingsBtn.addAction(settingsBtnAction, for: .touchUpInside)
    }
    
    // MARK: - Navigation
    private func openGameViewController() {
        let controller = GameViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    private func openRecordsViewController() {
        let controller = RecordsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    private func openSettingsViewController() {
        let controller = SettingsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func animateClickBtn(for btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = Cnst.MainVC.Color.mainBtnTappedColor
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                btn.backgroundColor = Cnst.MainVC.Color.mainBtnColor
            }
        }
    }
    
    // MARK: - load settings
    private func loadGameSettings() {
        guard let gameSettings: GameSettings = StorageManager.shared.load() else {
            print("error in StorageManager.shared.load")
            return
        }
        PickerManager.shared.gameSettings =  gameSettings
    }
}


