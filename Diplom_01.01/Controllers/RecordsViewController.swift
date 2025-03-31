//
//  RecordsViewController.swift
//  Diplom_01.01
//
//  Created by Maria on 14.02.25.
//

import UIKit

class RecordsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RecordsTableViewCell.self, forCellReuseIdentifier: RecordsTableViewCell.identifaer)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .leastNonzeroMagnitude
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Cnst.mainBackgroundColor
        return tableView
    }()

    private let backBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.backBtn.backBtnTitle, for: .normal)
        btn.titleLabel?.font = Cnst.backBtn.backBtnFont
        btn.titleLabel?.textColor = Cnst.mainTextColor
        btn.titleLabel?.textAlignment = .left
        return btn
    }()
    
    private var arrayOfRecords: [RecordsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        configureUI()
    }
    
    // MARK: - configureUI()
    private func configureUI() {
        view.backgroundColor = Cnst.mainBackgroundColor
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.backBtn.backBtnPctScreen)
            make.height.equalTo(Cnst.backBtn.backBtnHeight)
        }
        let backBtnAction = UIAction { _ in
            self.backBtnTapped()
        }
        backBtn.addAction(backBtnAction, for: .touchUpInside)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
    
    // MARK: - get records info
    private func getInfo() {
        guard let recordsInfo = RecordsStorageManager.shared.load() else {
            return print("error RecordsStorageManager.shared.load()")
        }
        var place = 0
        for array in recordsInfo {
            place += 1
            let image: UIImage
            
            if array.gameSettings.userPhoto != nil {
                image = UIImage(data: array.gameSettings.userPhoto!)!
            } else {
                image = UIImage(named: Cnst.SettingsVC.Images.userPhotoViewImage)!
            }
            
            let newElement = RecordsModel(
                placeInTable: place,
                userPhoto: image,
                userName: array.gameSettings.userName,
                numberOfBarriers: array.numberOfBarriers,
                gameDifficulty: array.gameSettings.gameDifficulty,
                raceStartTime: array.raceStartTime
            )
            arrayOfRecords.append(newElement)
        }
    }
    
    // MARK: - ButtonTapped
    private func backBtnTapped() {
        self.animateClickBtn(for: self.backBtn)
        self.navigationController?.popViewController(animated: true)
    }

    private func animateClickBtn(for btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = .lightGray
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                btn.backgroundColor = .gray
            }
        }
    }
}


// MARK: - extension
extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsTableViewCell.identifaer, for: indexPath) as? RecordsTableViewCell else {
            return UITableViewCell()
        }
        cell.configureRecordsTable(with: arrayOfRecords[indexPath.row])
        
        
        return cell
    }
}
