//
//  MainViewController.swift
//  Zhsyd_Swift
//
//  Created by 高军 on 2018/4/3.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource, MainInvestListCellDelegate{
    
    lazy var tableView:UITableView? = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - TABBAR_HEIGHT), style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainInvestListCell.self, forCellReuseIdentifier: "cellid")
        return tableView
    }()
    
    // cell数据源
    var dataArray = [InvestListCellModel]()
    // 滚动图数据源
    var bannarDataArray = [BannarModel]()
    // 公告模型
    var announceModel = AnnouceModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createTableView()
        
        loadData()
    }
    
    func loadData(){
        dataArray = []
        
        GJNetWorkTool.tool.requestMainViewControllerData { (result) in
            // cell数据源
            let array = result.res_data!["projectList"] as! NSMutableArray
            if array.count > 0 {
                for dic in array {
                    let model = InvestListCellModel()
                    model.setValuesForKeys(dic as! [String : Any])
                    self.dataArray.append(model)
                }
            }
            // bannar数据源
            let bannarArr = result.res_data!["banner_list"] as! NSMutableArray
            if bannarArr.count > 0 {
                for dic in bannarArr {
                    let model = BannarModel()
                    model.setValuesForKeys(dic as! [String : Any])
                    self.bannarDataArray.append(model)
                }
            }
            // 公告数据源
            self.announceModel.setValuesForKeys(result.res_data!["notice"] as! [String : Any])
            
            self.tableView?.reloadData()
        }
    }
    
    func createTableView(){
        view.addSubview(tableView!)
        
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0{
                return 200
            }else{
                return 130
            }
        }else{
            return 125
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:30), BackgroundColor: UIColor.clear)
            
            let leftImageView = GJUtil.createImageViewWith(Frame: CGRect(x:(SCREEN_WIDTH-60)/2-25, y:17, width:15, height:6), ImageName: "begin_title_diamon", CornarRadius: 0)
            view.addSubview(leftImageView)
            
            let rightImageView = GJUtil.createImageViewWith(Frame: CGRect(x:SCREEN_WIDTH/2+40, y:17, width:15, height:6), ImageName: "begin_title_diamon2", CornarRadius: 0)
            view.addSubview(rightImageView)
            
            let titleLabel = GJUtil.createLabelWith(Text: "精选推荐", Frame: CGRect(x:(SCREEN_WIDTH-60)/2, y:10, width:60, height:20), TextColor: LABEL_BLACK_COLOR, Font: 14, TextAligtment: .center)
            view.addSubview(titleLabel)
            
            return view
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else{
            let view = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:40), BackgroundColor: UIColor.clear)
            
            let imageView = GJUtil.createImageViewWith(Frame: CGRect(x:(SCREEN_WIDTH-160)/2, y:10, width:160, height:27), ImageName: "", CornarRadius: 0)
            view.addSubview(imageView)
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! MainInvestListCell
        cell.delegate = self
        cell.createInvestListCellWith(Section: indexPath.section, Row: indexPath.row)
        if !dataArray.isEmpty {
            let model:InvestListCellModel = dataArray[indexPath.row]
            cell.configCellWithModel(CellModel: model, BannarArray: bannarDataArray, AnnounceModel: announceModel)
        }
        cell.contentView.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            
        }
    }
    
    func scrollViewDidSelected(Index index: Int) {
        let model = bannarDataArray[index]
        let vc = BannarDetailViewController()
        vc.webTitle = ""
        vc.link = model.introduction
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func announceBtnAction() {
        let vc = AnnounceDetailController()
        vc.link = HOST + ANOUNCE_API + "?id=" + announceModel.nid
        vc.webTitle = announceModel.title
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
