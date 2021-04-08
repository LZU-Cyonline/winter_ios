import WidgetKit
import SwiftUI
import Intents

//常用函数
func getCNDateYMD()-> String {
    let dformatter = DateFormatter()
    
    dformatter.dateFormat = "yyyy-MM-dd"
    
    let datestr = dformatter.string(from: Date())
    return datestr
}

func howLong(time1:String) -> Int32{
    let time1_group = time1.split(separator: ":")
    let time1_first = (time1_group[0] as NSString).intValue
    let time1_second = (time1_group[1] as NSString).intValue
    let time1_total = time1_first*60 + time1_second
    return time1_total
}

func getNowTime() -> Int32{
    let date = Date()
    let timeFormatter = DateFormatter()
    //日期显示格式，可按自己需求显示
    timeFormatter.dateFormat = "HH:mm"
    let now_time = timeFormatter.string(from: date)
    let time1_group = now_time.split(separator: ":")
    let time1_first = (time1_group[0] as NSString).intValue
    let time1_second = (time1_group[1] as NSString).intValue
    let time1_total = time1_first*60 + time1_second
    return time1_total
}

func getstartDate() ->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let startDate = formatter.date(from: "2021-03-01")
    // 日期格式的原日期往后一天
    return startDate!
}
func getendDate() ->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let endDate = formatter.date(from: getCNDateYMD())
    return endDate!
}
func getToday(kechengbiao_array:Array<Any>,week:Int,day:Int) -> Array<Any>{
    var today_list = [Any]()
    let now_time = getNowTime()
    for each in kechengbiao_array{
        var each_lesson = each as! [String:Any]

        let weeks = each_lesson["week"] as! Array<Any>
        print(weeks)
        for i in weeks{
            if (i as! Int == week){
                if (each_lesson["day"] as! Int == day){
                    
                    let juti = each_lesson["juti"] as! Array<String>
                    let time1 = juti[0]
                    let time2 = juti[1]
                    each_lesson["begin_time"] = howLong(time1: time1)
                    each_lesson["end_time"] = howLong(time1: time2)
                    if ((each_lesson["end_time"] as! Int32) > now_time){
                        today_list.append(each_lesson)
                    }
                }
            }
        }
    }
    today_list.sort { (obj1, obj2) -> Bool in
        let linshiobj1 = obj1 as! [String:Any]
        let linshiobj2 = obj2 as! [String:Any]
        let long1 = linshiobj1["begin_time"]!
        let long2 = linshiobj2["begin_time"]!
        return (long1 as! Int32) <= (long2 as! Int32)
    }
    return today_list
}

func main() -> Array<String>{
    print("widget开始")
    var info_list = [String]()
    let user_defaults = UserDefaults.init(suiteName:"group.cyonline.makeabetterworld.cn")
//    let kechengbiao = user_defaults?.object(forKey: "kechengbiao") as! String
    let kechengbiao = user_defaults?.object(forKey: "kechengbiao")
    if (kechengbiao == nil){
        info_list.append("登录后将显示")
        info_list.append("最近两个事件")
        info_list.append("如果登录后未加载")
        info_list.append("请等待或重启手机")
        return info_list
    }
    
    let kechengbiao_array = getArrayFromJSONString(jsonString: kechengbiao  as! String)
//    let c:[String:Any] = kechengbiao_array[0] as! [String : Any]
    
    if (kechengbiao_array.count == 0){
        info_list.append("登录后将显示")
        info_list.append("最近两个事件")
        info_list.append("如果登录后未加载")
        info_list.append("请等待或重启手机")
        print("end")
        return info_list
    }
    
    let startDate = getstartDate()
    let endDate = getendDate()
    let unit : Calendar.Component = .day
    let start = Calendar.current.ordinality(of: unit, in: .era, for: startDate)
    let end = Calendar.current.ordinality(of: unit, in: .era, for: endDate)
    let diff = end! - start!
    let week = diff / 7
    let day = diff % 7
    let today_list = getToday(kechengbiao_array: kechengbiao_array as! Array<Any>, week: week, day: day)
    if (today_list.count == 0){
        let first_event = "今日无课"
        let first_event_desciption = "好好休息"
        let second_event = "～"
        let second_event_description = "～"
        info_list.append(first_event)
        info_list.append(first_event_desciption)
        info_list.append(second_event)
        info_list.append(second_event_description)
        return info_list
    }
    else if (today_list.count == 1){
        let linshi_list = today_list[0] as! [String : Any]
        let first_event = linshi_list["name"] as! String
        let first_event_desciption = linshi_list["place"] as! String
        let second_event = "没课啦～"
        let second_event_description = "～"
        info_list.append(first_event)
        info_list.append(first_event_desciption)
        info_list.append(second_event)
        info_list.append(second_event_description)
        return info_list
    }
    else{
        let linshi_list = today_list[0] as! [String : Any]
        let first_event = linshi_list["name"] as! String
        let first_event_desciption = linshi_list["place"] as! String
        let linshi_list2 = today_list[1] as! [String : Any]
        let second_event = linshi_list2["name"] as! String
        let second_event_description = linshi_list2["place"] as! String
        info_list.append(first_event)
        info_list.append(first_event_desciption)
        info_list.append(second_event)
        info_list.append(second_event_description)
        return info_list
    }
}









struct Provider: IntentTimelineProvider {
//    let userDefaults = UserDefaults(suiteName: "group.cyonline.makeabetterworld.cn")
//    userDefaults?.setValue(status, forKey: "widget")
//    userDefaults?.synchronize()
//    @AppStorage("test", store: UserDefaults(suiteName: "group.cyonline.makeabetterworld.cn"))
//    var name1: String = String()
//    var result = UserDefaults.init(suiteName:"group.cyonline.makeabetterworld.cn")?.set("1234",forKey: "test")
    
    
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), first_event: "登录后显示",first_event_description: "最近两个事件",second_event: "如果登录后未加载",second_event_description: "请等待或重启手机")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let linshi_list = main()
        let first_event = linshi_list[0]
        let first_event_desciption = linshi_list[1]
        let second_event = linshi_list[2]
        let second_event_description = linshi_list[3]
        let entry = SimpleEntry(date: Date(),first_event: first_event,first_event_description: first_event_desciption,second_event: second_event,second_event_description: second_event_description)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
//        let entry = SimpleEntry(date: currentDate,first_event: first_event,first_event_description: first_event_desciption,second_event: second_event,second_event_description: second_event_description)
//        entries.append(entry)
        
        for secondOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
            let linshi_list = main()
            let first_event = linshi_list[0]
            let first_event_desciption = linshi_list[1]
            let second_event = linshi_list[2]
            let second_event_description = linshi_list[3]
            let entry = SimpleEntry(date: entryDate,first_event: first_event,first_event_description: first_event_desciption,second_event: second_event,second_event_description: second_event_description)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
func getArrayFromJSONString(jsonString:String) ->NSArray{
    let jsonData:Data = jsonString.data(using: .utf8)!
     
    let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if array != nil {
        return array as! NSArray
    }
    return [] as! NSArray
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var first_event:String
    var first_event_description:String
    var second_event:String
    var second_event_description:String
}

struct cywidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: cywidgetView(first_event:entry.first_event,first_event_description:entry.first_event_description,second_event:entry.second_event,second_event_description:entry.second_event_description,date:entry.date)
        case .systemMedium: cywidgetView(first_event:entry.first_event,first_event_description:entry.first_event_description,second_event:entry.second_event,second_event_description:entry.second_event_description,date:entry.date)
        default: cywidgetView(first_event:entry.first_event,first_event_description:entry.first_event_description,second_event:entry.second_event,second_event_description:entry.second_event_description,date:entry.date)
        }
    }
}

@main
struct cywidget: Widget {
    let kind: String = "兰大小萃"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            cywidgetEntryView(entry: entry)
        }
        .configurationDisplayName("小萃的一些小玩意儿")
        .description("在小组件中添加你喜欢的功能吧！")
    }
}

//struct cywidget_Previews: PreviewProvider {
//    static var previews: some View {
//        cywidgetEntryView(let entry = SimpleEntry(date: currentDate,first_event: "第一节课",first_event_description: "第一节课描述",second_event: "第二节课",second_event_description: "第二节课描述");)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}




struct cywidgetView: View {
    var first_event = "～"
    var first_event_description = "～"
    var second_event = "～"
//    var name = "asdd"
    var second_event_description = "～"
    var date = Date()
    static let taskDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter
    }()
    var body: some View {
        VStack(alignment: .leading) {
            Text("今日")
                .font(.title3)
                .padding([.top, .leading])
            GeometryReader { geometry in
                HStack(){
//                    Rectangle()
//                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/).frame(width: 2.0, height: geometry.size.height * 0.5)
                    Capsule()
                        .frame(width: 2.0,height:geometry.size.height * 0.8)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)

                    VStack(alignment: .leading){
                        Text(first_event)
                            .font(.body)
                                
                            Text(first_event_description)
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                    
                }
                .padding(.top, -5.0)
            }
            .padding(.horizontal)
            
            
            GeometryReader { geometry in
                HStack(){
//                    Rectangle()
//                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/).frame(width: 2.0, height: geometry.size.height * 0.5)
                    Capsule()
                        .frame(width: 2.0,height:geometry.size.height * 0.8)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)

                    VStack(alignment: .leading){
                        Text(second_event)
                            .font(.body)
                                
                            Text(second_event_description)
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                    
                }
                .padding(.top, -7.0)
            }
            .padding(.horizontal)
        }
        
            
    }
}

//struct cywidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        cywidgetView()
//    }
//}

