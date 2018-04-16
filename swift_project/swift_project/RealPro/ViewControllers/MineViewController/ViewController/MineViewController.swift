//
//  MineViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class MineViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource{

    var tableView:UITableView?
    var avoidLabel:UILabel?
    var model = MineViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
        loadData()
    }
    
    func loadData(){
        GJNetWorkTool.tool.getMineData { (result) in
            self.model.setValuesForKeys(result.res_data!)
            
            self.tableView?.reloadData()
        }
    }

    func createTableView(){
        tableView = UITableView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - TABBAR_HEIGHT), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColor.white
        tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 340 + STATUSBAR_HEIGHT
        }else{
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! MineViewCell
        cell.createCellWith(Row: indexPath.row)
        cell.cellBtnAction = {
            (tag) -> Void in
            self.myCellBtnAction(Tag: tag)
        }
        cell.configCellWith(Model: model)
        cell.selectionStyle = .none
        if indexPath.row != 0 {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(MineInvestHistoryViewController(), animated: true)
        }else if indexPath.row == 1 {
            self.navigationController?.pushViewController(MoneyHistoryViewController(), animated: true)
        }else if indexPath.row == 2 {
            self.navigationController?.pushViewController(InvatationViewController(), animated: true)
        }else if indexPath.row == 3 {
            self.navigationController?.pushViewController(MessageViewController(), animated: true)
        }
    }
    
    func myCellBtnAction(Tag tag:Int){
        switch tag {
        case 1,10:
            self.navigationController?.pushViewController(SafetyCenterViewController(), animated: true)
            break
        case 2:
            //提现
            self.navigationController?.pushViewController(DeleteMoneyViewController(), animated: true)
            break
        case 3:
            //充值
            let vc = AddMoneyViewController()
            if model.userNature == 1 {
                vc.userNature = true
            }else{
                vc.userNature = false
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = MyTicketViewController()
            vc.isRed = "1"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 5:
            let vc = MyTicketViewController()
            vc.isRed = "0"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
}
