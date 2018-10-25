//
//  CustomCell.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/25.
//  Copyright © 2018年 haoran. All rights reserved.
//

import UIKit
import Eureka

public class CustomCell: Cell<Bool>, CellType {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchControl.addTarget(self, action: #selector(CustomCell.switchValueChanged(sw:)), for: .valueChanged)
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override public func setup() {
        super.setup()
        
    }
    
    @objc func switchValueChanged(sw : UISwitch) {
        row.value = sw.isOn
        row.updateCell()
    }
    
    override public func update() {
        super.update()
//        backgroundColor = (row.value ?? false) ? .white : .black
    }
}

public final class CustomRow: Row<CustomCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        // 我们把对应CustomCell的 .xib 加载到cellProvidor
//        let cell = UINib.init(nibName: "CustomCell", bundle: nil).instantiate(withOwner: nil, options: nil).last
        cellProvider = CellProvider<CustomCell>.init(nibName: NSStringFromClass(CustomCell.self))

    }
}



