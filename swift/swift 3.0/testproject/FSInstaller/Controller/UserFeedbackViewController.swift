//
//  UserFeedbackViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/9/12.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//

class UserFeedbackViewController: BaseStaticTableViewController {
    
    
    @IBOutlet weak var imgContentView: UIView!
    @IBOutlet weak var contactTextField: UITextField!
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var inputTextView: PlaceholderTextView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    fileprivate var selectPhotoView: SelectPhotoView!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "用户反馈"
    }
    
    override func setup(){
        
        tableView.allowsSelection = false
          
        for label in labels {
            label.textColor = kAppTitleColor
            label.font = UIFont.systemFont(ofSize: 14)
        }
        self.inputTextView.placeholderLabel.text = "请输入遇见的问题或建议"
        
        let padding: CGFloat = 4
        selectPhotoView = SelectPhotoView(frame: CGRect(x: 0, y: padding, width: self.view.sizeWidth, height: imgContentView.sizeHeight - padding * 2))
        
        selectPhotoView.didClickAddButton = {
            [weak self] (selectPhotoView: SelectPhotoView) -> () in
            
            self?.selectMultiPic2()
        } 
        
        imgContentView.addSubview(selectPhotoView)
        imgContentView.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kHeightZero
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 222
        }
        else {
            return kAppRowHeight
        }
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        appPrint(image)
    }
    
    override func imagePickerController(_ picker: SGImagePickerController, didFinishPickingImages images: [AnyObject]!) {
        self.selectPhotoView.addImages(imgs: images as! [UIImage]!)
    }

    @IBAction func submitAction(_ sender: AnyObject) {
    }
}
