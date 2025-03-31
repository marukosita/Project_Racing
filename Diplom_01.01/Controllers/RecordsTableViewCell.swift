//
//  RecordsTableViewCell.swift
//  Diplom_01.01
//
//

import UIKit
import SnapKit

class RecordsTableViewCell: UITableViewCell {
    
    static var identifaer: String { "\(Self.self)" }
    
    private let placeInTableLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textColor = Cnst.mainTextColor
        lbl.font = Cnst.RecordsVC.recordsFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let userPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.textColor = Cnst.mainTextColor
        lbl.font = Cnst.RecordsVC.recordsFont
        return lbl
    }()
    
    private let numberOfBarriersLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textColor = Cnst.mainTextColor
        lbl.font = Cnst.RecordsVC.recordsFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let gameDifficultyLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.textColor = Cnst.mainTextColor
        lbl.font = Cnst.RecordsVC.recordsFont
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let raceStartTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.textColor = Cnst.mainTextColor
        lbl.font = Cnst.RecordsVC.recordsFontRaceStartTimeLabel
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = Cnst.mainBackgroundColor
        
        contentView.addSubview(placeInTableLabel)
        contentView.addSubview(userPhotoImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(numberOfBarriersLabel)
        contentView.addSubview(gameDifficultyLabel)
        contentView.addSubview(raceStartTimeLabel)
        
        placeInTableLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(contentView.frame.width * Cnst.RecordsVC.smallSpacing)
            make.right.equalTo(userPhotoImageView.snp.left).offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
            make.width.equalTo(contentView.frame.width * Cnst.RecordsVC.placeInTableLabelWidth)
        }
        
        userPhotoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(contentView.frame.width * Cnst.RecordsVC.userPhotoHeightWidth)
            make.right.equalTo(userNameLabel.snp.left).offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
            make.top.equalToSuperview().offset(contentView.frame.width * Cnst.RecordsVC.smallSpacing)
            make.bottom.equalToSuperview().offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
        }
        userPhotoImageView.layer.cornerRadius = contentView.frame.width * Cnst.RecordsVC.userPhotoHeightWidth / 2
        
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.frame.width * Cnst.RecordsVC.userNameLblWidth)
            make.right.equalTo(numberOfBarriersLabel.snp.left).offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
        }
        numberOfBarriersLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.frame.width * Cnst.RecordsVC.numberOfBarriersLblWidth)
            make.right.equalTo(gameDifficultyLabel.snp.left).offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
        }
        gameDifficultyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.frame.width * Cnst.RecordsVC.gameDifficultyLblWidth)
            make.right.equalTo(raceStartTimeLabel.snp.left).offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
        }
        raceStartTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(contentView.frame.width * Cnst.RecordsVC.raceStartTimeLblWidth)
            make.right.equalToSuperview().offset(-contentView.frame.width * Cnst.RecordsVC.smallSpacing)
        }
    }
    
    func configureRecordsTable(with model: RecordsModel) {
        placeInTableLabel.text = String(model.placeInTable)
        userPhotoImageView.image = model.userPhoto
        userNameLabel.text = model.userName
        numberOfBarriersLabel.text = String(model.numberOfBarriers)
        gameDifficultyLabel.text = PickerManager.shared.gameDifficultyArray[model.gameDifficulty].gameDifficultyName
        raceStartTimeLabel.text = model.raceStartTime
    }
}
