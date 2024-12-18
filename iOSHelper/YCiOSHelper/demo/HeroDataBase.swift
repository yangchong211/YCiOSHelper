//
//  HeroDataBase.swift
//  TableViewDemo
//
//  Created by wang ya on 2020/6/16.
//  Copyright © 2020 EYA-Studio. All rights reserved.
//

import UIKit

struct HeroSection {

    enum Category: String {
        case Strength = "力量"
        case Intelligence = "智力"
        case Agility = "敏捷"
    }

    var category: Category
    var heros: [Hero]
}

struct Hero {
    var name = ""
    var imageName = ""
}


struct HeroDataBase {

    static func sections() -> [HeroSection] {
        return [
            HeroSection(category: .Strength, heros: [
                Hero(name: "上古巨神", imageName: "1.png"),
                Hero(name: "不朽尸王", imageName: "2.png"),
                Hero(name: "亚巴顿", imageName: "3.png"),
                Hero(name: "伐木机", imageName: "4.png"),
                Hero(name: "全能骑士", imageName: "1.png"),
                Hero(name: "兽王", imageName: "2.png"),
                Hero(name: "军团指挥官", imageName: "3.png"),
                Hero(name: "冥魂大帝", imageName: "4.png"),
                Hero(name: "凤凰", imageName: "1.png"),
                Hero(name: "半人马战行者", imageName: "2.png"),
                Hero(name: "发条技师", imageName: "3.png"),
                Hero(name: "哈斯卡", imageName: "4.png"),
                Hero(name: "噬魂鬼", imageName: "1.png"),
                Hero(name: "大地之灵", imageName: "2.png"),
                Hero(name: "孽主", imageName: "3.png"),
                Hero(name: "小小", imageName: "4.png"),
              
            ]),
            HeroSection(category: .Agility, heros: [
                Hero(name: "主宰", imageName: "1.png"),
                Hero(name: "克林克兹", imageName: "2.png"),
                Hero(name: "冥界亚龙", imageName: "3.png"),
                Hero(name: "剃刀", imageName: "4.png"),
                Hero(name: "剧毒术士", imageName: "1.png"),
                Hero(name: "力丸", imageName: "2.png"),
                Hero(name: "卓尔游侠", imageName: "3.png"),
                Hero(name: "变体精灵", imageName: "4.png"),
                Hero(name: "司夜刺客", imageName: "1.png"),
                Hero(name: "圣堂刺客", imageName: "2.png"),
                Hero(name: "复仇之魂", imageName: "3.png"),
                Hero(name: "天穹守望者", imageName: "4.png"),
                Hero(name: "娜迦海妖", imageName: "1.png"),
                Hero(name: "巨魔战将", imageName: "2.png"),
                Hero(name: "幻影刺客", imageName: "3.png"),
                Hero(name: "幻影长矛手", imageName: "4.png"),
            ]),
            HeroSection(category: .Intelligence, heros: [
                Hero(name: "修补匠", imageName: "1.png"),
                Hero(name: "先知", imageName: "2.png"),
                Hero(name: "光之守卫", imageName: "3.png"),
                Hero(name: "天怒法师", imageName: "4.png"),
                Hero(name: "天涯墨客", imageName: "1.png"),
                Hero(name: "宙斯", imageName: "2.png"),
                Hero(name: "寒冬飞龙", imageName: "3.png"),
                Hero(name: "工程师", imageName: "4.png"),
                Hero(name: "巫医", imageName: "1.png"),
                Hero(name: "巫妖", imageName: "2.png"),
                Hero(name: "帕克", imageName: "3.png"),
                Hero(name: "帕格纳", imageName: "4.png"),
                Hero(name: "干扰者", imageName: "1.png"),
                Hero(name: "戴泽", imageName: "2.png"),
                Hero(name: "拉席克", imageName: "3.png"),
                Hero(name: "拉比克", imageName: "4.png"),
            ])
        ]
    }

}
