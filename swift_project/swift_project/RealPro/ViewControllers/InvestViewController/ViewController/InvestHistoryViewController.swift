//
//  InvestHistoryViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class InvestHistoryViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var uuid = ""
    var nid = ""
    
    var page = 1
    var tableView:UITableView?
    var dataArray = [InvestHistoryModel]()
    
    var cell:InvestHistoryCell?
    
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
        
        GJNetWorkTool.tool.getInvestHistoryWith(UUID: uuid, NID: nid, Page: "\(page)") { (result) in
            let array = result.res_data!["tender_list"] as! NSMutableArray
            if array.count > 0 {
                for dic in array {
                    let model = InvestHistoryModel()
                    model.setValuesForKeys(dic as! [String : Any])
                    self.dataArray.append(model)
                }
            }
            self.tableView?.reloadData()
        }
    }
    
    func createTableView(){
        tableView = UITableView.init(frame: CGRect(x:0, y:8, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - 40 - 8), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
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
        return dataArray.count == 0 ? 1 : dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:40), BackgroundColor: UIColor.white)
        
        let label_1 = GJUtil.createLabelWith(Text: "出借人", Frame: CGRect(x:15, y:5, width:80, height:30), TextColor: UIColor.black, Font: 17, TextAligtment: nil)
        view.addSubview(label_1)
        
        let label_2 = GJUtil.createLabelWith(Text: "金额(元)", Frame: CGRect(x:115, y:5, width:80, height:30), TextColor: UIColor.black, Font: 17, TextAligtment: nil)
        view.addSubview(label_2)
        
        let label_3 = GJUtil.createLabelWith(Text: "时间", Frame: CGRect(x:215, y:5, width:80, height:30), TextColor: UIColor.black, Font: 17, TextAligtment: nil)
        view.addSubview(label_3)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }else{
            return dataArray.count == 0 ? SCREEN_HEIGHT-STATUS_NAV_BAR_Y-40-8-40 : 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? InvestHistoryCell
        cell?.createCellWith(Row: indexPath.row)
        if !dataArray.isEmpty {
            let model:InvestHistoryModel = dataArray[indexPath.row]
            cell?.configCellWith(Model: model)
        }
        cell?.contentView.backgroundColor = UIColor.white
        cell?.selectionStyle = .none
        return cell!
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
