//
//  File.swift
//  trendline
//
//  Created by Jithin Eringat on 2/3/20.
//  Copyright © 2020 Jithin Eringat. All rights reserved.
//

import Foundation
import SwiftUICharts

var testva = "0000000"

func sayHello()->String{
    return "Soil_tf value is:" + String(soil_tf_y3(cmfrom:10, cmto:20))
}

//================== Above is test code =============


//Variables definition
var p_values = [Double]()
var Soil_Depth_P:Array<Double> = [5, 15, 25, 35, 45, 55]  // cm
var PBI:Array<Double> = [13, 11, 11, 13, 13, 11]
var Colwell_P:Array<Double> = [21.75,29,32.125,30.625,14.625,3]  // mg/kg

var p_applied_y3:Double = 0
var p_applied_y6:Double = 0
var p_applied_y9:Double = 0

//================= Utility Functions ==============

// Rounds the double to decimal places value
func roundTo(number:Double, decimals:Int) -> Double {
       let divisor = pow(10.0, Double(decimals))
       return (number * divisor).rounded() / divisor
   }



//=================  Year 3  =======================
/*
 SOIL_TF value for next 3 years prediction
 Parameters:    cmfrom: start cm value
                cmto: end cm value
 */
func soil_tf_y3(cmfrom:Double, cmto:Double)->Double{
    var soil_tf:Double = -1
    
    if cmfrom == 0 && cmto == 10 {
        if PBI[0] < 0.1{
            soil_tf = 0.08
        }else{
            if PBI[0] > 273{
                soil_tf = 0.2403
            }else{
                soil_tf = -0.0005*PBI[0]+0.3772
            }
        }
    }else if cmfrom == 10 && cmto == 20{   //10-20cm
        if PBI[1] < 0.1{
            soil_tf = 0.08
        }else{
            if PBI[1] > 273{
                soil_tf = 0.2403
            }else{
                soil_tf = -0.0015*PBI[1]+0.3772
            }
        }
    }else if cmfrom == 20 && cmto == 30{   //20-30cm
        if PBI[2] < 0.1{
            soil_tf = 0.08
        }else{
            if PBI[2] > 273{
                soil_tf = 0.2403
            }else{
                soil_tf = -0.002*PBI[2]+0.3772
            }
        }
    }else if cmfrom == 30 && cmto == 40{   //30-40cm
        if PBI[3] < 0.1{
            soil_tf = 0.08
        }else{
            if PBI[3] > 273{
                soil_tf = 0.2403
            }else{
                soil_tf = -0.002*PBI[3]+0.3772
            }
        }
    }else if cmfrom == 40 && cmto == 50{   //40-50cm
        if PBI[4] < 0.1{
            soil_tf = 0.08
        }else{
            if PBI[4] > 273{
                soil_tf = 0.2403
            }else{
                soil_tf = -0.002*PBI[4]+0.3772
            }
        }
    }else if cmfrom == 50 && cmto == 60{   //50-60cm
        if PBI[5] < 0.1{
            soil_tf = 0.08
        }else{
            if PBI[5] > 273{
                soil_tf = 0.2403
            }else{
                soil_tf = -0.002*PBI[5]+0.3772
            }
        }
    }else{
        print("Not a suitable value for this program.")
    }
    
    return roundTo(number:soil_tf, decimals:4)
}


/*
 FCST_1 value of next 3 years prediction
 Parameters:    cmfrom: start cm value
                cmto: end cm value
 */
func fcst_1_y3(cmfrom:Double,cmto:Double)->Double{
    let fcst_1:Double = soil_tf_y3(cmfrom:cmfrom,cmto:cmto) * p_applied_y3
    return fcst_1
}

/*
 ST_NT_1 value of next 3 years prediction
 Parameters:    cmfrom: start cm value
                cmto: end cm value
 */
func st_nf_1_y3(cmfrom:Double,cmto:Double)->Double{
    var st_nf_1_y3:Double = -1
    if cmto == 10{          // Means Y3, 0-10cm
        st_nf_1_y3 = 0.86 * Colwell_P[0]
    }else if cmto == 20{    // Means Y3, 10-20cm
        st_nf_1_y3 = 0.86 * Colwell_P[1]
    }else if cmto == 30{    // Same as above
        st_nf_1_y3 = 0.86 * Colwell_P[2]
    }else if cmto == 40{
        st_nf_1_y3 = 0.86 * Colwell_P[3]
    }else if cmto == 50{
        st_nf_1_y3 = 0.86 * Colwell_P[4]
    }else if cmto == 60{
        st_nf_1_y3 = 0.86 * Colwell_P[5]
    }
    return st_nf_1_y3
}

//=================  Year 6  =======================
/*
  SOIL_TF value for year 6
  Parameters:   cmfrom: start cm value
                cmto: end cm value
 */
func soil_tf_y6(cmfrom:Double, cmto:Double) -> Double{
    let soil_tf_y6:Double = soil_tf_y3(cmfrom:cmfrom, cmto:cmto) * p_applied_y6
    return roundTo(number:soil_tf_y6, decimals:3)
}

/*
 FCST_1 value for year 6
 Parameters:   cmfrom: start cm value
               cmto: end cm value
*/
func fcst_1_y6(cmfrom:Double,cmto:Double)->Double{
    let fcst_1_y6:Double = soil_tf_y6(cmfrom:cmfrom,cmto:cmto) + (fcst_1_y3(cmfrom:cmfrom,cmto:cmto)/3)
    return roundTo(number:fcst_1_y6, decimals: 5)
}

/*
 ST_NF_1 value for year 6
 Parameters:   cmfrom: start cm value
               cmto: end cm value
*/
func st_nf_1_y6(cmfrom:Double,cmto:Double)->Double{
    var st_nf_1_y6:Double = -1
    
    if cmto == 10 || cmto == 20{
        st_nf_1_y6 = st_nf_1_y3(cmfrom:cmfrom,cmto:cmto) * 0.8953
    }else if cmto == 30 || cmto == 40{
        st_nf_1_y6 = st_nf_1_y3(cmfrom:cmfrom,cmto:cmto) * 0.8993
    }else if cmto == 50{
        st_nf_1_y6 = st_nf_1_y3(cmfrom:cmfrom,cmto:cmto) * 0.983
    }else if cmto == 60{
        st_nf_1_y6 = st_nf_1_y3(cmfrom:cmfrom,cmto:cmto) * 0.99
    }
    
    return roundTo(number: st_nf_1_y6, decimals: 5)
}

//=================  Year 9  =======================
/*
 SOIL_TF value for year 9
 Parameters:   cmfrom: start cm value
               cmto: end cm value
*/
func soil_tf_y9(cmfrom:Double,cmto:Double)->Double{
    let soil_tf_y9 = soil_tf_y3(cmfrom:cmfrom,cmto:cmto) * p_applied_y9
    return roundTo(number:soil_tf_y9, decimals: 3)
}

/*
 FCST_1 value for year 9
 Parameters:   cmfrom: start cm value
               cmto: end cm value
*/
func fcst_1_y9(cmfrom:Double,cmto:Double)->Double{
    let fcst_1_y9 = soil_tf_y9(cmfrom:cmfrom,cmto:cmto) + (soil_tf_y6(cmfrom:cmfrom,cmto:cmto)/3) + fcst_1_y6(cmfrom:cmfrom,cmto:cmto)/6
    return roundTo(number:fcst_1_y9, decimals: 6)
}

/*
 ST_NF_1 value for year 9
 Parameters:   cmfrom: start cm value
               cmto: end cm value
*/
func st_nf_1_y9(cmfrom:Double,cmto:Double)->Double{
    var st_nf_1_y9:Double = -1
    if cmto == 10 || cmto == 20 || cmto == 30 || cmto == 40{
        st_nf_1_y9 = st_nf_1_y6(cmfrom:cmfrom,cmto:cmto) * 0.9221
    }else if cmto == 50{
        st_nf_1_y9 = st_nf_1_y6(cmfrom:cmfrom,cmto:cmto) * 0.983
    }else if cmto == 60{
        st_nf_1_y9 = st_nf_1_y6(cmfrom:cmfrom,cmto:cmto) * 0.99
    }
    return roundTo(number:st_nf_1_y9, decimals: 5)
}


//=======  Final function: Get P_values  ===========
/*
 Predict Phosphorus level for next 3/6/9 years
 Parameters:   year: How many years user want to predict
                p_applied: How much Phosphorus user want to apply for these years
 */
func predictPhosphorus(year:Int)->Array<Double>{
    
    if year == 3{
        //0-10cm p_value
        p_values.append(round(fcst_1_y3(cmfrom:0,cmto:10) + st_nf_1_y3(cmfrom:0,cmto:10)))
        print("fcst:" + String(format:"%f", fcst_1_y3(cmfrom:0,cmto:10)))
        print("fcst:" + String(format:"%f", st_nf_1_y3(cmfrom:0,cmto:10)))
        //10-20cm p_value
        p_values.append(round(fcst_1_y3(cmfrom:10,cmto:20) + st_nf_1_y3(cmfrom:10,cmto:20)))
        //20-30cm p_value
        p_values.append(round(fcst_1_y3(cmfrom:20,cmto:30) + st_nf_1_y3(cmfrom:20,cmto:30)))
        p_values.append(round(fcst_1_y3(cmfrom:30,cmto:40) + st_nf_1_y3(cmfrom:30,cmto:40)))
        p_values.append(round(fcst_1_y3(cmfrom:40,cmto:50) + st_nf_1_y3(cmfrom:40,cmto:50)))
        p_values.append(round(fcst_1_y3(cmfrom:50,cmto:60) + st_nf_1_y3(cmfrom:50,cmto:60)))
    }else if year == 6{
        p_values.append(round(fcst_1_y6(cmfrom:0,cmto:10) + st_nf_1_y6(cmfrom:0,cmto:10)))
        p_values.append(round(fcst_1_y6(cmfrom:10,cmto:20) + st_nf_1_y6(cmfrom:10,cmto:20)))
        p_values.append(round(fcst_1_y6(cmfrom:20,cmto:30) + st_nf_1_y6(cmfrom:20,cmto:30)))
        p_values.append(round(fcst_1_y6(cmfrom:30,cmto:40) + st_nf_1_y6(cmfrom:30,cmto:40)))
        p_values.append(round(fcst_1_y6(cmfrom:40,cmto:50) + st_nf_1_y6(cmfrom:40,cmto:50)))
        p_values.append(round(fcst_1_y6(cmfrom:50,cmto:60) + st_nf_1_y6(cmfrom:50,cmto:60)))
    }else if year == 9{
        p_values.append(round(fcst_1_y9(cmfrom:0,cmto:10) + st_nf_1_y9(cmfrom:0,cmto:10)))
        p_values.append(round(fcst_1_y9(cmfrom:10,cmto:20) + st_nf_1_y9(cmfrom:10,cmto:20)))
        p_values.append(round(fcst_1_y9(cmfrom:20,cmto:30) + st_nf_1_y9(cmfrom:20,cmto:30)))
        p_values.append(round(fcst_1_y9(cmfrom:30,cmto:40) + st_nf_1_y9(cmfrom:30,cmto:40)))
        p_values.append(round(fcst_1_y9(cmfrom:40,cmto:50) + st_nf_1_y9(cmfrom:40,cmto:50)))
        p_values.append(round(fcst_1_y9(cmfrom:50,cmto:60) + st_nf_1_y9(cmfrom:50,cmto:60)))
    }
    print(p_values)
    return p_values
}
func getValueFromInterface(v3:Double, v6:Double, v9: Double){
    
    p_applied_y3 = v3
    p_applied_y6 = v6
    p_applied_y9 = v9
//   year3 = predictPhosphorus(year: 3)
// year6 = predictPhosphorus(year: 6)
//   year9 = predictPhosphorus(year: 9)
//    print("3",year3)
}

func yearValueToInt(yearValueArray:Array<Double>)->Array<Int>{
    var yearValueIntArray:Array<Int> = []
    var yearValueInt:Int = 0
    for yearValue in yearValueArray{
        yearValueInt = Int(yearValue)
        yearValueIntArray.append(yearValueInt)
    }
    return yearValueIntArray
}

//====== Below is a function which can be attached to a "submit" or "next" button ========



