//
//  WeatherIconManager.swift
//  WeatherApp
//
//  Created by Kiri4of on 13.11.2022.
//

import UIKit
//Посмотреть Енумы
enum WeatherIconManager: String {
    
    case Clear = "113"
    case Fog = "248"
    case FreezingFog = "260"
    case Cloudy = "119"
    case PartlyCloudy = "116"
    case PatchyRainPossible = "176"
    case PatchyLightRain = "293"
    case LightRain = "296"
    case ModerateRainAtTimes = "299"
    case ModerateRain = "302"
    case HeavyRainAtTimes = "305"
    case HeavyRain = "308"
    case LightFreezingRain = "311"
    case ModerateOrHeavyFreezing = "314"
    case LightRainShower = "359"
    case PatchLightRainWithThunder = "386"
    case PatchySnowPossible = "179"
    case BlowingSnow = "227"
    case PatchyLightSnow = "323"
    case LightSnow = "326"
    case PatchyModerateSnow = "329"
    case ModerateSnow = "332"
    case PatchyHeavySnow = "335"
    case HeavySnow = "338"
    case LightSnowShowers = "368"
    case ModerateOrHeavySnowShowers = "371"
    case PatchyLightSnowWithThunder = "392"
    case ModerateOrHeavySnowWithThunder = "395"
    case PatchySleetPossible = "182"
    case LightSleet = "317"
    case ModerateOrHeavySleet = "320"
    case LightSleetShowers = "362"
    case ModerateOrHeavySleetShowers = "365"
    
    init(rawValue: String){
        switch rawValue {
        case "113": self = .Clear
        case "116": self = .PartlyCloudy
        case "119": self = .Cloudy
        case "176": self = .PatchyRainPossible
        case "182": self = .PatchySleetPossible
        case "248": self = .Fog
        case "260": self = .FreezingFog
        case "293": self = .PatchyLightRain
        case "296": self = .LightRain
        case "302": self = .ModerateRain
        case "305": self = .HeavyRainAtTimes
        case "308": self = .HeavyRain
        case "311": self = .LightFreezingRain
        case "314": self = .ModerateOrHeavyFreezing
        case "359": self = .LightRainShower
        case "386": self = .PatchLightRainWithThunder
        case "179": self = .PatchySnowPossible
        case "227": self = .BlowingSnow
        case "323": self = .PatchyLightSnow
        case "326": self = .LightSnow
        case "329": self = .PatchyModerateSnow
        case "332": self = .ModerateSnow
        case "335": self = .PatchyHeavySnow
        case "338": self = .HeavySnow
        case "368": self = .LightSnowShowers
        case "371": self = .ModerateOrHeavySnowShowers
        case "392": self = .PatchLightRainWithThunder
        case "395": self = .ModerateOrHeavySnowWithThunder
        case "317": self = .LightSleet
        case "320": self = .ModerateOrHeavySleet
        case "362": self = .LightSleetShowers
        case "365": self = .ModerateOrHeavySleetShowers
       
        default: self = .Clear // UnpredictedIcon
        }
        
    }
}

extension WeatherIconManager {
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
