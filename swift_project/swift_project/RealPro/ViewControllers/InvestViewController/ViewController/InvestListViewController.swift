//
//  InvestListViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/11.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestListViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource{

    var isPerson = false
    
    var page = 1
    var tableView:UITableView?
    var dataArray = [InvestListCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createTableView()
        loadDataWith(Page: 1)
    }
    
    func loadDataWith(Page page:Int){
        if page == 1 {
            dataArray = []
        }
        
        GJNetWorkTool.tool.getInvestListWith(Category: isPerson == true ? "1" : "2", Page: "\(page)") { (result) in
            let array = result.res_data!["invest_list"] as! NSMutableArray
            if array.count > 0 {
                for dic in array {
                    let model = InvestListCellModel()
                    model.setValuesForKeys(dic as! [String : Any])
                    self.dataArray.append(model)
                }
            }
            self.tableView?.reloadData()
        }
    }

    func createTableView(){
        tableView = UITableView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT - 40), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        
        let header = GJRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshHeader))
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        tableView?.mj_header = header
        
        let footer = GJRefreshFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(refreshFooter))
        footer.stateLabel.isHidden = true
        tableView?.mj_footer = footer
        tableView?.mj_footer.isAutomaticallyChangeAlpha = true
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! InvestListCell
        cell.createCell()
        if !dataArray.isEmpty {
            let model:InvestListCellModel = dataArray[indexPath.row]
            cell.configCellWith(Model: model)
        }
        cell.contentView.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataArray[indexPath.row]
        
        let vc = InvestDetailViewController()
        if model.lastAccount == "0"{
            vc.isCompleted = true
        }else{
            vc.isCompleted = false
        }
        vc.pro_title = model.name
        vc.scale = model.scales
        vc.isPerson = isPerson
        vc.userID = GJUtil.GET_USER_DEFAULTS(Key: "userID") as! String
        vc.uuID = model.uuid
        vc.nID = model.nid
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refreshHeader(){
        page = 1
        loadDataWith(Page: page)
        tableView?.mj_header.endRefreshing()
    }
    
    @objc func refreshFooter(){
        page += 1
        loadDataWith(Page: page)
        tableView?.mj_footer.endRefreshing()
    }
    
}
