//
//  SettingsViewController.swift
//  Diplom_01.01
//
//  Created by Maria on 14.02.25.
//

import UIKit
import SnapKit

enum tapDirection {
    case right
    case left
}

class SettingsViewController: UIViewController {
    
    private let backBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.backBtn.backBtnTitle, for: .normal)
        btn.titleLabel?.font = Cnst.backBtn.backBtnFont
        btn.titleLabel?.textColor = Cnst.mainTextColor
        btn.titleLabel?.textAlignment = .left
        return btn
    }()
    
    private let userPhotoView: UIImageView = {
        let view = UIImageView()
        if PickerManager.shared.gameSettings.userPhoto != nil {
            view.image = UIImage(data: PickerManager.shared.gameSettings.userPhoto!)
        } else {
            view.image = UIImage(named: Cnst.SettingsVC.Images.userPhotoViewImage)
        }
        view.clipsToBounds = true
        return view
    }()
    
    private let selectNewUserPhotoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.selectNewUserPhotoBtn), for: .normal)
        btn.setTitle("+", for: .normal)
        btn.clipsToBounds = true
        return btn
    }()
    
    private let userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = Cnst.SettingsVC.Text.userNameLblText
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        lbl.font = Cnst.SettingsVC.Font.settingsFont
        lbl.textColor = Cnst.mainTextColor
        return lbl
    }()
    private lazy var userNameTextField: UITextField = {
        let txt = UITextField()
        txt.delegate = self // lazy var SettingsViewController: UITextFieldDelegate
        txt.clearButtonMode = .always
        txt.placeholder = "enter your name"
        txt.font = Cnst.SettingsVC.Font.settingsFont
        txt.text = PickerManager.shared.gameSettings.userName
        txt.layer.cornerRadius = Cnst.mainCornerRadius
        txt.backgroundColor = Cnst.SettingsVC.Color.userNameTextFieldBackgroundColor
        txt.textColor = Cnst.SettingsVC.Color.userNameTextFieldTextColor
        txt.textAlignment = .center
        return txt
    }()
    
    private let carViewLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = Cnst.SettingsVC.Text.chooseItemViewLblText
        lbl.textAlignment = .center
        lbl.font = Cnst.SettingsVC.Font.settingsFont
        lbl.textColor = Cnst.mainTextColor
        return lbl
    }()
    private let carView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: PickerManager.shared.carImageArray[PickerManager.shared.gameSettings.carView].settingsCarImage)
        return view
    }()
    private let carViewLeftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.settingsLeftBtnImage), for: .normal)
        btn.setTitle("<", for: .normal)
        return btn
    }()
    private let carViewRightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.settingsRightBtnImage), for: .normal)
        btn.setTitle(">", for: .normal)
        return btn
    }()
    
    
    private let typeOfBarriersLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = Cnst.SettingsVC.Text.typeOfBarriersLblText
        lbl.textAlignment = .center
        lbl.font = Cnst.SettingsVC.Font.settingsFont
        lbl.textColor = Cnst.mainTextColor
        return lbl
    }()
    private let typeOfBarriersView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: PickerManager.shared.typeOfBarriersArray[PickerManager.shared.gameSettings.typeOfBarriers])
        return view
    }()
    private let typeOfBarriersLeftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.settingsLeftBtnImage), for: .normal)
        btn.setTitle("<", for: .normal)
        return btn
    }()
    
    private let typeOfBarriersRightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.settingsRightBtnImage), for: .normal)
        btn.setTitle(">", for: .normal)
        return btn
    }()
    
    private let gameDifficultyLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = Cnst.SettingsVC.Text.gameDifficultyLblText
        lbl.textAlignment = .center
        lbl.font = Cnst.SettingsVC.Font.settingsFont
        lbl.textColor = Cnst.mainTextColor
        return lbl
    }()
    private let gameDifficultyPickerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = PickerManager.shared.gameDifficultyArray[ PickerManager.shared.gameSettings.gameDifficulty].gameDifficultyName
        lbl.font = Cnst.SettingsVC.Font.settingsFont.withSize(60)
        lbl.textColor = Cnst.mainTextColor
        lbl.textAlignment = .center
        return lbl
    }()
    private let gameDifficultyLeftBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.settingsLeftBtnImage), for: .normal)
        btn.setTitle("<", for: .normal)
        return btn
    }()
    private let gameDifficultyRightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: Cnst.SettingsVC.Images.settingsRightBtnImage), for: .normal)
        btn.setTitle(">", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTapGesture()
    }
    
    // MARK: Gesture Recognizer
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: ConfigureUI
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
        
        
        view.addSubview(userPhotoView)
        view.addSubview(selectNewUserPhotoBtn)
        view.addSubview(userNameLbl)
        view.addSubview(userNameTextField)
        userPhotoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backBtn.snp.bottom)
            make.height.width.equalTo(view.frame.width * Cnst.SettingsVC.UI.userPhotoViewSizePctScreen)
        }
        userPhotoView.layer.cornerRadius = view.frame.width * Cnst.SettingsVC.UI.userPhotoViewSizePctScreen / 2
        
        selectNewUserPhotoBtn.snp.makeConstraints { make in
            make.bottom.equalTo(userPhotoView.snp.bottom)
            make.right.equalTo(userPhotoView.snp.right)
            make.width.equalTo(view.frame.height * Cnst.SettingsVC.UI.selectNewUserPhotoBtnWidthPctScreen)
            make.height.equalTo(selectNewUserPhotoBtn.snp.width)
        }
        selectNewUserPhotoBtn.layer.cornerRadius = view.frame.height * Cnst.SettingsVC.UI.selectNewUserPhotoBtnWidthPctScreen / 2
        let selectNewUserPhotoBtnAction = UIAction { _ in
            self.showPickerAlert()
        }
        selectNewUserPhotoBtn.addAction(selectNewUserPhotoBtnAction, for: .touchUpInside)
        
        userNameLbl.snp.makeConstraints { make in
            make.top.equalTo(userPhotoView.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.pickerLblPctScreen)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerLblHeight)
        }
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.userNameTextFieldPctScreen)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
        }
        
        
        view.addSubview(carViewLbl)
        view.addSubview(carView)
        view.addSubview(carViewLeftBtn)
        view.addSubview(carViewRightBtn)
        carViewLbl.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(Cnst.SettingsVC.UI.mediumVerticalSpacing)
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.pickerLblPctScreen)
            make.centerX.equalToSuperview()
            make.height.equalTo(Cnst.SettingsVC.UI.pickerLblHeight)
        }
        carView.snp.makeConstraints { make in
            make.top.equalTo(carViewLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.imagePickerWidthPctScreen)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
        }
        
        carViewLeftBtn.snp.makeConstraints { make in
            make.top.equalTo(carViewLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.right.equalTo(carView.snp.left).offset(-Cnst.SettingsVC.UI.smallHorizontalSpacing)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
            make.width.equalTo(carViewRightBtn.snp.height)
        }
        let carViewLeftBtnAction = UIAction { _ in
            print("<-")
            self.carViewTapBtn(direction: .left)
        }
        carViewLeftBtn.addAction(carViewLeftBtnAction, for: .touchUpInside)
        
        carViewRightBtn.snp.makeConstraints { make in
            make.top.equalTo(carViewLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.left.equalTo(carView.snp.right).offset(Cnst.SettingsVC.UI.smallHorizontalSpacing)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
            make.width.equalTo(carViewRightBtn.snp.height)
        }
        let carViewRightBtnAction = UIAction { _ in
            print("->")
            self.carViewTapBtn(direction: .right)
        }
        carViewRightBtn.addAction(carViewRightBtnAction, for: .touchUpInside)
        
        
        
        view.addSubview(typeOfBarriersLbl)
        view.addSubview(typeOfBarriersView)
        view.addSubview(typeOfBarriersLeftBtn)
        view.addSubview(typeOfBarriersRightBtn)
        typeOfBarriersLbl.snp.makeConstraints { make in
            make.top.equalTo(carView.snp.bottom).offset(Cnst.SettingsVC.UI.mediumVerticalSpacing)
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.pickerLblPctScreen)
            make.centerX.equalToSuperview()
            make.height.equalTo(Cnst.SettingsVC.UI.pickerLblHeight)
        }
        typeOfBarriersView.snp.makeConstraints { make in
            make.top.equalTo(typeOfBarriersLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.imagePickerWidthPctScreen)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
        }
        typeOfBarriersLeftBtn.snp.makeConstraints { make in
            make.top.equalTo(typeOfBarriersLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.right.equalTo(carView.snp.left).offset(-Cnst.SettingsVC.UI.smallHorizontalSpacing)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
            make.width.equalTo(carViewRightBtn.snp.height)
        }
        let typeOfBarriersLeftBtnAction = UIAction { _ in
            print("<-")
            self.typeOfBarriersTapBtn(direction: .left)
        }
        typeOfBarriersLeftBtn.addAction(typeOfBarriersLeftBtnAction, for: .touchUpInside)
        typeOfBarriersRightBtn.snp.makeConstraints { make in
            make.top.equalTo(typeOfBarriersLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.left.equalTo(carView.snp.right).offset(Cnst.SettingsVC.UI.smallHorizontalSpacing)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
            make.width.equalTo(carViewRightBtn.snp.height)
        }
        let typeOfBarriersRightBtnAction = UIAction { _ in
            print("->")
            self.typeOfBarriersTapBtn(direction: .right)
        }
        typeOfBarriersRightBtn.addAction(typeOfBarriersRightBtnAction, for: .touchUpInside)
        
        
        view.addSubview(gameDifficultyLbl)
        view.addSubview(gameDifficultyPickerLbl)
        view.addSubview(gameDifficultyLeftBtn)
        view.addSubview(gameDifficultyRightBtn)
        
        gameDifficultyLbl.snp.makeConstraints { make in
            make.top.equalTo(typeOfBarriersView.snp.bottom).offset(Cnst.SettingsVC.UI.mediumVerticalSpacing)
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.pickerLblPctScreen)
            make.centerX.equalToSuperview()
            make.height.equalTo(Cnst.SettingsVC.UI.pickerLblHeight)
        }
        gameDifficultyPickerLbl.snp.makeConstraints { make in
            make.top.equalTo(gameDifficultyLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.SettingsVC.UI.imagePickerWidthPctScreen)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
        }
        gameDifficultyLeftBtn.snp.makeConstraints { make in
            make.top.equalTo(gameDifficultyLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.right.equalTo(carView.snp.left).offset(-Cnst.SettingsVC.UI.smallHorizontalSpacing)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
            make.width.equalTo(carViewRightBtn.snp.height)
        }
        let gameDifficultyLeftBtnAction = UIAction { _ in
            print("<-")
            self.gameDifficultyTapBtn(direction: .left)
        }
        gameDifficultyLeftBtn.addAction(gameDifficultyLeftBtnAction, for: .touchUpInside)
        gameDifficultyRightBtn.snp.makeConstraints { make in
            make.top.equalTo(gameDifficultyLbl.snp.bottom).offset(Cnst.SettingsVC.UI.smallVerticalSpacing)
            make.left.equalTo(carView.snp.right).offset(Cnst.SettingsVC.UI.smallHorizontalSpacing)
            make.height.equalTo(Cnst.SettingsVC.UI.pickerHeight)
            make.width.equalTo(carViewRightBtn.snp.height)
        }
        let gameDifficultyRightBtnAction = UIAction { _ in
            print("->")
            self.gameDifficultyTapBtn(direction: .right)
        }
        gameDifficultyRightBtn.addAction(gameDifficultyRightBtnAction, for: .touchUpInside)
    }
    
    private func animateClickBtn(for btn: UIButton) {
        UIView.animate(withDuration: 0.2) {
            btn.backgroundColor = Cnst.SettingsVC.Color.tappedColor
        }
    }
    
    // MARK: - ButtonTapped
    private func gameDifficultyTapBtn(direction: tapDirection) {
        let newIndex = PickerManager.shared.chooseItemForPicker(
            direction: direction,
            currentValue: PickerManager.shared.gameSettings.gameDifficulty,
            relevantArray: PickerManager.shared.gameDifficultyArray
        )
        PickerManager.shared.gameSettings.gameDifficulty = newIndex
        self.gameDifficultyPickerLbl.text = PickerManager.shared.gameDifficultyArray[newIndex].gameDifficultyName
    }
    
    private func typeOfBarriersTapBtn(direction: tapDirection) {
        let index = PickerManager.shared.chooseItemForPicker(
            direction: direction,
            currentValue: PickerManager.shared.gameSettings.typeOfBarriers,
            relevantArray: PickerManager.shared.typeOfBarriersArray
        )
        PickerManager.shared.gameSettings.typeOfBarriers = index
        self.typeOfBarriersView.image = UIImage(named: PickerManager.shared.typeOfBarriersArray[index])
    }
    private func carViewTapBtn(direction: tapDirection) {
        let newIndex = PickerManager.shared.chooseItemForPicker(
            direction: direction,
            currentValue: PickerManager.shared.gameSettings.carView,
            relevantArray: PickerManager.shared.carImageArray
        )
        PickerManager.shared.gameSettings.carView = newIndex
        self.carView.image = UIImage(named: PickerManager.shared.carImageArray[newIndex].settingsCarImage)
    }
    
    // MARK: - Image Picker
    private func showPickerToSelectUserPhoto(with source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            print("Source is not available")
            return
        }
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    func showPickerAlert() {
        let alert = UIAlertController(title: "Choose source to add user photo", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showPickerToSelectUserPhoto(with: .camera)
        }
        alert.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { _ in
            self.showPickerToSelectUserPhoto(with: .photoLibrary)
        }
        alert.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - save name
    private func saveNewNameOfPlayer() {
        if userNameTextField.text?.isEmpty == true {
            PickerManager.shared.gameSettings.userName = Cnst.SettingsVC.Text.userNameTextFieldText
        } else {
            PickerManager.shared.gameSettings.userName = userNameTextField.text!
        }
    }
    
    // MARK: - ButtonTapped
    private func backBtnTapped() {
        animateClickBtn(for: self.backBtn)
        
        saveNewNameOfPlayer()
        
        //сохраняем настройки в UserDefaults
        StorageManager.shared.save(gameSettings: PickerManager.shared.gameSettings)
        
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - extension
extension SettingsViewController: UITextFieldDelegate {
    // скрытие клавиатуры при нажатии на return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // ограничение на количество символов
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        // Определение диапазона, который нужно заменить
        guard let stringRange = Range(range, in: currentText) else { return false }
        // Обновленный текст после замены
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= Cnst.SettingsVC.textFieldMaxLength
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // вызывается, когда пользователь завершает выбор изображения в UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var choosenImage = UIImage()
        
        func compressImage(image: UIImage, quality: CGFloat) -> Data? {
            let compressionQuality = min(max(quality, 0.0), 1.0)
            return image.jpegData(compressionQuality: compressionQuality)
        }
        
        // выбираем какое фото будет выбрано - оригинал или редактировали
        if let image = info[.editedImage] as? UIImage {
            choosenImage = image
        } else if let image = info[.originalImage] as? UIImage {
            choosenImage = image
        }
        
        // сжимаем и сохраняем фото
        if let imageData = compressImage(image: choosenImage, quality: 0.5) {
            PickerManager.shared.gameSettings.userPhoto = imageData
        }
        
        // обновляем фото
        userPhotoView.image = choosenImage
        print(choosenImage)
        
        // закрытие пикера
        picker.dismiss(animated: true)
    }
}
