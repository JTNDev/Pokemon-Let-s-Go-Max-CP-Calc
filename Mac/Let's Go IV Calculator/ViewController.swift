//
//  ViewController.swift
//  Let's Go IV Calculator
//
//  Created by Joshua Oki on 11/23/18.
//  Copyright © 2018 JTNDev. All rights reserved.
//

import Cocoa
let pokedexNames  = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Mewtwo", "Mew", "Meltan", "Melmetal"]
let actualPokedexLeft = ["Raichu", "Alolan Raichu", "Sandshrew", "Alolan Sandshrew", "Sandslash", "Alolan Sandslash", "Nidoran♀", "Nidorina", "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Alolan Vulpix", "Ninetales", "Alolan Ninetales", "Jigglypuff", "Wigglytuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth", "Diglett"]
let pokedexStats = ["Bulbasaur": [45, 49, 49, 65, 65, 45], "Ivysaur": [60, 62, 63, 80, 80, 60], "Venusaur": [80, 82, 83, 100, 100, 80], "Charmander": [39, 52, 43, 60, 50, 65], "Charmeleon": [58,  64, 58, 80, 65, 80], "Charizard": [78, 84, 78, 109, 85, 100], "Squirtle": [44, 48, 65, 50, 64, 43], "Wartortle": [59, 63, 80, 65, 80, 58], "Blastoise": [79, 83, 100, 85, 105, 78], "Caterpie": [45, 30, 35, 20, 20, 45], "Metapod": [50, 20, 55, 25, 25, 30], "Butterfree": [60, 45, 50, 90, 80, 70], "Weedle": [40, 35, 30, 20, 20, 50], "Kakuna": [45, 25, 50, 25, 25, 35], "Beedrill": [65, 90, 40, 45, 80, 75], "Pidgey": [40, 45, 40, 35, 35, 56], "Pidgeotto": [63, 60, 55, 50, 50, 71], "Pidgeot": [83, 80, 75, 70, 70, 101], "Rattata": [30, 56, 35, 25, 35, 72], "Raticate": [55, 81, 60, 50, 70, 97], "Spearow": [40, 60, 30, 31, 31, 70], "Fearow": [65, 90, 65, 61, 61, 100], "Ekans": [35, 60, 44, 40, 54, 55], "Arbok": [60, 95, 69, 65, 79, 80], "Pikachu": [35, 55, 40, 50, 50, 90], "Mewtwo": [106, 110, 90, 154, 90, 130], "Mew": [100, 100, 100, 100, 100, 100], "Meltan": [46, 65, 65, 55, 35, 34], "Melmetal": [135, 143, 143, 80, 65, 34]]
var levelMin32:Int32 = 0;
var levelMax32:Int32 = 0;
var pokemonStats:[Int] = [];
var Pokemon = "";
var Nature = "";
var levelRange:Int32 = 0;
var data: [[String: String]] = []
class Level: NSObject
{
    @objc dynamic var level: Int;
    @objc dynamic var CP: Int;
    init(level: Int, CP: Int)
    {
        self.level = level;
        self.CP = CP;
    }
}

 class ViewController: NSViewController {
    let Natures = ["Hardy", "Lonely","Brave", "Adamant", "Naughty", "Bold", "Relaxed", "Impish", "Lax", "Timid", "Hasty", "Jolly", "Naive", "Modest", "Mild", "Quiet", "Rash", "Calm", "Gentle", "Sassy", "Careful"] //The nuetral natures with the exception of Hardy are not included because I only need one
    @objc dynamic var people: [Level] = []
     @IBOutlet weak var levelLabel: NSTextField!
    @IBOutlet weak var pokemonComboBox: NSComboBox!
    @IBOutlet weak var levelOutlet1: NSTextField!
    @IBOutlet weak var levelOutlet2: NSTextField!
    @IBOutlet weak var natureComboBox: NSComboBox!
    var HP:Int = 0;
    var ATK:Int = 0;
    var SPATK:Int = 0;
    var DEF:Int = 0;
    var SPDEF:Int = 0;
    var SPD:Int = 0;
    @IBAction func calculateButton(_ sender: NSButton) {
        var pastCPValues: [String] = []
        levelLabel.isHidden = true;
        people.removeAll()
        levelMin32 = levelOutlet1.intValue
        levelMax32 = levelOutlet2.intValue
        let levelMin = Int(levelMin32)
        let levelMax = Int(levelMax32)
        if((levelMin >= 1 && levelMin <= 100) == false || (levelMax >= 1 && levelMax <= 100) == false || levelMin > levelMax)
        {
            levelLabel.isHidden = false;
        }
        else
        {
        Pokemon = pokemonComboBox.objectValueOfSelectedItem! as! String;
        Nature = natureComboBox.objectValueOfSelectedItem! as! String;
        pokemonStats = pokedexStats[Pokemon] ?? [0, 0, 0, 0, 0, 0];
        for level in levelMin ... levelMax
        {
            HP = ((((2 * pokemonStats[0] + 31) * level))/100) + level + 10
            let atkDefault = Int(Double((((((2 * pokemonStats[1] + 31) * level))/100) + 5)) * 1)
            let spatkDefault = Int(Double((((((2 * pokemonStats[3] + 31) * level))/100) + 5)) * 1)
            let defDefault = Int(Double((((((2 * pokemonStats[2] + 31) * level))/100) + 5)) * 1)
            let spdefDefault = Int(Double((((((2 * pokemonStats[4] + 31) * level))/100) + 5)) * 1)
            let spdDefault = Int(Double((((((2 * pokemonStats[5] + 31) * level))/100) + 5)) * 1)
            let atkPlus = Int(Double((((((2 * pokemonStats[1] + 31) * level))/100) + 5)) * 1.1)
            let spatkPlus = Int(Double((((((2 * pokemonStats[3] + 31) * level))/100) + 5)) * 1.1)
            let defPlus = Int(Double((((((2 * pokemonStats[2] + 31) * level))/100) + 5)) * 1.1)
            let spdefPlus = Int(Double((((((2 * pokemonStats[4] + 31) * level))/100) + 5)) * 1.1)
            let spdPlus = Int(Double((((((2 * pokemonStats[5] + 31) * level))/100) + 5)) * 1.1)
            let atkMinus = Int(Double((((((2 * pokemonStats[1] + 31) * level))/100) + 5)) * 0.9)
            let spatkMinus = Int(Double((((((2 * pokemonStats[3] + 31) * level))/100) + 5)) * 0.9)
            let defMinus = Int(Double((((((2 * pokemonStats[2] + 31) * level))/100) + 5)) * 0.9)
            let spdefMinus = Int(Double((((((2 * pokemonStats[4] + 31) * level))/100) + 5)) * 0.9)
            let spdMinus = Int(Double((((((2 * pokemonStats[5] + 31) * level))/100) + 5)) * 0.9)
            if(Nature == "Any")
            {
                for nature in Natures
                {
                    if(nature == "Hardy")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Lonely")
                    {
                        ATK = atkPlus
                        SPATK = spatkDefault;
                        DEF = defMinus
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Brave")
                    {
                        ATK = atkPlus
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdMinus
                    }
                    if(nature == "Adamant")
                    {
                        ATK = atkPlus
                        SPATK = spatkMinus
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Naughty")
                    {
                        ATK = atkPlus
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefMinus
                        SPD = spdDefault
                    }
                    if(nature == "Bold")
                    {
                        ATK = atkMinus
                        SPATK = spatkDefault
                        DEF = defPlus
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Relaxed")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defPlus
                        SPDEF = spdefDefault
                        SPD = spdMinus
                    }
                    if(nature == "Impish")
                    {
                        ATK = atkDefault
                        SPATK = spatkMinus
                        DEF = defPlus
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Lax")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defPlus
                        SPDEF = spdefMinus
                        SPD = spdDefault
                    }
                    if(nature == "Timid")
                    {
                        ATK = atkMinus
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdPlus
                    }
                    if(nature == "Hasty")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defMinus
                        SPDEF = spdefDefault
                        SPD = spdPlus
                    }

                    if(nature == "Jolly")
                    {
                        ATK = atkDefault
                        SPATK = spatkMinus
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdPlus
                    }
                    if(nature == "Naive")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefMinus
                        SPD = spdPlus
                    }
                    if(nature == "Modest")
                    {
                        ATK = atkMinus
                        SPATK = spatkPlus
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Mild")
                    {
                        ATK = atkDefault
                        SPATK = spatkPlus
                        DEF = defMinus
                        SPDEF = spdefDefault
                        SPD = spdDefault
                    }
                    if(nature == "Quiet")
                    {
                        ATK = atkDefault
                        SPATK = spatkPlus
                        DEF = defDefault
                        SPDEF = spdefDefault
                        SPD = spdMinus
                    }
                    if(nature == "Rash")
                    {
                        ATK = atkDefault
                        SPATK = spatkPlus
                        DEF = defDefault
                        SPDEF = spdefMinus
                        SPD = spdDefault
                    }

                    if(nature == "Calm")
                    {
                        ATK = atkMinus
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefPlus
                        SPD = spdDefault
                    }
                    if(nature == "Gentle")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defMinus
                        SPDEF = spdefPlus
                        SPD = spdDefault
                    }
                    if(nature == "Sassy")
                    {
                        ATK = atkDefault
                        SPATK = spatkDefault
                        DEF = defDefault
                        SPDEF = spdefPlus
                        SPD = spdMinus
                    }
                    if(nature == "Careful")
                    {
                        ATK = atkDefault
                        SPATK = spatkMinus
                        DEF = defDefault
                        SPDEF = spdefPlus
                        SPD = spdDefault
                    }
                    var CP = Int(((HP+ATK+DEF+SPATK+SPDEF+SPD) * level * 6 / 100));
                    if(CP >= 10000)
                    {
                        CP = 10000
                    }
                    if(!(pastCPValues.contains(String(level) + " " + String(CP))))
                    {
                        pastCPValues.append(String(level) + " " + String(CP))
                        people.append(Level(level: level, CP: CP))
                    }
                }
            }
            else
            {
                if(Nature == "Hardy")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Lonely")
                {
                    ATK = atkPlus
                    SPATK = spatkDefault;
                    DEF = defMinus
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Brave")
                {
                    ATK = atkPlus
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdMinus
                }
                if(Nature == "Adamant")
                {
                    ATK = atkPlus
                    SPATK = spatkMinus
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Naughty")
                {
                    ATK = atkPlus
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefMinus
                    SPD = spdDefault
                }
                if(Nature == "Bold")
                {
                    ATK = atkMinus
                    SPATK = spatkDefault
                    DEF = defPlus
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Relaxed")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defPlus
                    SPDEF = spdefDefault
                    SPD = spdMinus
                }
                if(Nature == "Impish")
                {
                    ATK = atkDefault
                    SPATK = spatkMinus
                    DEF = defPlus
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Lax")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defPlus
                    SPDEF = spdefMinus
                    SPD = spdDefault
                }
                if(Nature == "Timid")
                {
                    ATK = atkMinus
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdPlus
                }
                if(Nature == "Hasty")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defMinus
                    SPDEF = spdefDefault
                    SPD = spdPlus
                }
                
                if(Nature == "Jolly")
                {
                    ATK = atkDefault
                    SPATK = spatkMinus
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdPlus
                }
                if(Nature == "Naive")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefMinus
                    SPD = spdPlus
                }
                if(Nature == "Modest")
                {
                    ATK = atkMinus
                    SPATK = spatkPlus
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Mild")
                {
                    ATK = atkDefault
                    SPATK = spatkPlus
                    DEF = defMinus
                    SPDEF = spdefDefault
                    SPD = spdDefault
                }
                if(Nature == "Quiet")
                {
                    ATK = atkDefault
                    SPATK = spatkPlus
                    DEF = defDefault
                    SPDEF = spdefDefault
                    SPD = spdMinus
                }
                if(Nature == "Rash")
                {
                    ATK = atkDefault
                    SPATK = spatkPlus
                    DEF = defDefault
                    SPDEF = spdefMinus
                    SPD = spdDefault
                }
                
                if(Nature == "Calm")
                {
                    ATK = atkMinus
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefPlus
                    SPD = spdDefault
                }
                if(Nature == "Gentle")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defMinus
                    SPDEF = spdefPlus
                    SPD = spdDefault
                }
                if(Nature == "Sassy")
                {
                    ATK = atkDefault
                    SPATK = spatkDefault
                    DEF = defDefault
                    SPDEF = spdefPlus
                    SPD = spdMinus
                }
                if(Nature == "Careful")
                {
                    ATK = atkDefault
                    SPATK = spatkMinus
                    DEF = defDefault
                    SPDEF = spdefPlus
                    SPD = spdDefault
                }
                var CP = Int(((HP+ATK+DEF+SPATK+SPDEF+SPD) * level * 6 / 100));
                if(CP >= 10000)
                {
                    CP = 10000
                }
                if(!(pastCPValues.contains(String(level) + " " + String(CP))))
                {
                    pastCPValues.append(String(level) + " " + String(CP))
                    people.append(Level(level: level, CP: CP))
                }
        }
        }
    }
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        for name in pokedexNames
        {
            pokemonComboBox.addItem(withObjectValue: name);
        }
         natureComboBox.addItem(withObjectValue: "Any")
        for name in Natures
        {
            natureComboBox.addItem(withObjectValue: name);
        }
        pokemonComboBox.selectItem(at: 0)
        natureComboBox.selectItem(at: 0)
        levelLabel.isHidden = true;
    }
    override var representedObject: Any? {
        didSet {
        }
    }
}
