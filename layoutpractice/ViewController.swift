//
//  ViewController.swift
//  layoutpractice
//
//  Created by shin seunghyun on 2020/03/21.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCell")
        tableView.register(UINib(nibName: "YouTableViewCell", bundle: nil), forCellReuseIdentifier: "YouCell")
//        tableView.rowHeight = UITableView.automaticDimension
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        //Keyboard Notification, 키보드가 올라왔는지 내려왔는지 확인
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybooardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //observer 지워주기
      NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        //키보드의 높이를 가져오는 작업
        let notificationInfo = notification.userInfo! as NSDictionary
        let keyboardFrame = notificationInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let height = keyboardFrame!.size.height
        inputViewBottomMargin.constant = height //bottom constraint 에 keyboard 높이 값을 넣어준다.
        
        //애니메이션 추가.
        //키보드의 움직이는 시간을 가져와야 함.
        //그 시간만큼 텍스트 인풋뷰를 애니메이션 형태로 올라오게 만들면 자연스럽게 보인다.
        
        let animationDuration = notificationInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration){
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func keybooardWillHide(notification: NSNotification) {
        inputViewBottomMargin.constant = 0
        let notificationInfo = notification.userInfo! as NSDictionary
        let animationDuration = notificationInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
  

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell: UITableViewCell
        if indexPath.row % 2 == 0 {
            defaultCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyTableViewCell
            print("My Cell Printed")
        } else {
            defaultCell = tableView.dequeueReusableCell(withIdentifier: "YouCell", for: indexPath) as! YouTableViewCell
            print("You Cell Printed")
        }
        return defaultCell
    }
    
    
}

