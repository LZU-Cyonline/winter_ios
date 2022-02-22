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

func getstartDate(kaixueDate: String) ->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    //开学日期
    let startDate = formatter.date(from: kaixueDate)
    return startDate!
}
func getendDate() ->Date{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let endDate = formatter.date(from: getCNDateYMD())
    return endDate!
}
func getToday(kechengbiao_array:Array<Any>, beginTime: Array<String>, endTime: Array<String>, week:Int,day:Int) -> Array<Any>{
    var today_list = [Any]()
    let now_time = getNowTime()
    var flag = false
    for each in kechengbiao_array{
        var each_lesson = each as! [String:Any]
        let time = each_lesson["time"] as! Array<[String:Any]>
        for eachTime in time {
            let weeks = eachTime["week"] as! Array<Any>
            for i in weeks {
                if (i as! Int + 1 == week){
                    if (eachTime["day"] as! Int + 1 == day){
                        flag = true
                        let juti = eachTime["juti"] as! Array<Int>
                        let time1 = beginTime[juti[0]]
                        let time2 = endTime[juti[juti.count - 1]]
                        //print("dasdadadsa")
                        //print(time2)
                        each_lesson["begin_time"] = howLong(time1: time1)
                        each_lesson["end_time"] = howLong(time1: time2)
                        each_lesson["place"] = eachTime["place"]
                        each_lesson["beginTimeForShow"] = "下一节 " + time1
                        each_lesson["endTimeForShow"] = time2
                        if ((each_lesson["begin_time"] as! Int32) < now_time && (each_lesson["end_time"] as! Int32) > now_time) {
                            each_lesson["beginTimeForShow"] = "课程进行中"
                        }
                        if ((each_lesson["end_time"] as! Int32) > now_time){
                            today_list.append(each_lesson)
                        }
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
    if (!flag) {
        var temp = [String: Any]()
        temp["name"] = "今天并没有什么课程耶"
        today_list.append(temp)
    }
    return today_list
}

func main() -> Array<String>{
    //print("widget开始")
    var info_list = [String]()
    let user_defaults = UserDefaults.init(suiteName:"group.cyonline.makeabetterworld.cn")
    let kechengbiao = user_defaults?.object(forKey: "kechengbiao")
    let kaixueDate0 = user_defaults?.object(forKey: "kaixueDate")
    
    if (kechengbiao == nil){
        let contentOne = "暂无课程"
        let contentTwo = "今日无课，好好休息"
        let contentThree = "暂无地点"
        let contentFour = "查看更多"
        
        info_list.append(contentOne)
        info_list.append(contentTwo)
        info_list.append(contentThree)
        info_list.append(contentFour)
        
        return info_list
    }
    
    var kaixueDate: String
    if (kaixueDate0 == nil) {
        print(1)
        kaixueDate = "2022-02-13"
    }
    else{
        print(2)
        let linshi = kaixueDate0 as! String
        let indexStart = linshi.startIndex
        let indexTwo = linshi.index(indexStart, offsetBy: 1)
        let indexFive = linshi.index(indexStart, offsetBy: 11)
        let subString = linshi[indexTwo..<indexFive]
        print(subString)
        kaixueDate = String(subString)
        
        print(kaixueDate)
    }

//    kaixueDate0 = kaixueDate0[3...10]
    let kechengbiao_array = getArrayFromJSONString(jsonString: kechengbiao as! String)
    
    if (kechengbiao_array.count == 0){
        let contentOne = "暂无课程"
        let contentTwo = "今日无课，好好休息"
        let contentThree = "暂无地点"
        let contentFour = "查看更多"
        
        info_list.append(contentOne)
        info_list.append(contentTwo)
        info_list.append(contentThree)
        info_list.append(contentFour)
        
        return info_list
    }
    
    // 在此添加针对每个学生的上课时间
    let beginTime = user_defaults?.object(forKey: "beginTime")
    let endTime = user_defaults?.object(forKey: "endTime")
    
    if (beginTime == nil || endTime == nil) {
        print("获取上下课时间列表失败")
        let contentOne = "暂无课程"
        let contentTwo = "今日无课，好好休息"
        let contentThree = "暂无地点"
        let contentFour = "查看更多"
        
        info_list.append(contentOne)
        info_list.append(contentTwo)
        info_list.append(contentThree)
        info_list.append(contentFour)
        
        return info_list
    }
    
    let beginTimeList = getArrayFromJSONString(jsonString: beginTime as! String)
    let endTimeList = getArrayFromJSONString(jsonString: endTime as! String)
    
    let startDate = getstartDate(kaixueDate: kaixueDate ?? "2022-02-11")
    print("\n\n\n\n\n---okokok---"+(kaixueDate ?? "2022-02-11")+"---\n\n\n\n")
    let endDate = getendDate()
    let unit : Calendar.Component = .day
    let start = Calendar.current.ordinality(of: unit, in: .era, for: startDate)
    let end = Calendar.current.ordinality(of: unit, in: .era, for: endDate)
    let diff = end! - start!
    let week = diff / 7
    let day = diff % 7
    //print(week)
    //print(day)
    let today_list = getToday(kechengbiao_array: kechengbiao_array as! Array<Any>, beginTime: beginTimeList as! Array<String>, endTime: endTimeList as! Array<String>, week: week, day: day)
    if (today_list.count == 0) {
        let contentOne = "暂无课程"
        let contentTwo = "今日课程已结束"
        let contentThree = "暂无地点"
        let contentFour = "今日无更多课程"
        
        info_list.append(contentOne)
        info_list.append(contentTwo)
        info_list.append(contentThree)
        info_list.append(contentFour)
        
        return info_list
    }
    else if (today_list.count == 1){
        let linshiList = today_list[0] as! [String: Any]
        
        // 针对没有课而非上完课的情况
        let lessonName = linshiList["name"] as! String
        if (lessonName == "今天并没有什么课程耶") {
            let contentOne = "暂无课程"
            let contentTwo = "今日无课，好好休息"
            let contentThree = "暂无地点"
            let contentFour = "查看更多"
            
            info_list.append(contentOne)
            info_list.append(contentTwo)
            info_list.append(contentThree)
            info_list.append(contentFour)
            
            return info_list
        }
        
        let contentOne = linshiList["beginTimeForShow"] as! String
        let contentTwo = linshiList["name"] as! String
        let contentThree = linshiList["place"] as! String
        let contentFour = "今日无更多课程"
        
        info_list.append(contentOne)
        info_list.append(contentTwo)
        info_list.append(contentThree)
        info_list.append(contentFour)
        
        return info_list
    }
    else{
        let linshiList = today_list[0] as! [String: Any]
        let linshiListOfNextLesson = today_list[1] as! [String: Any]
        
        let contentOne = linshiList["beginTimeForShow"] as! String
        let contentTwo = linshiList["name"] as! String
        let contentThree = linshiList["place"] as! String
        let contentFour = "接下来：" + (linshiListOfNextLesson["name"] as! String)
        
        info_list.append(contentOne)
        info_list.append(contentTwo)
        info_list.append(contentThree)
        info_list.append(contentFour)
        
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
    //    let contentOne = "暂无课程"
    //    let contentTwo = "今日无课，好好休息"
    //    let contentThree = "若有课程，点击此处可导航至上课地点"
    //    let contentFour = "查看更多"
    
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), contentOne: "暂无课程", contentTwo: "今日无课，好好休息", contentThree: "暂无地点", contentFour: "查看更多")
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let linshi_list = main()
        let contentOne = linshi_list[0]
        let contentTwo = linshi_list[1]
        let contentThree = linshi_list[2]
        let contentFour = linshi_list[3]
        
        let entry = SimpleEntry(date: Date(), contentOne: contentOne, contentTwo: contentTwo, contentThree: contentThree, contentFour: contentFour)
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
            //print(linshi_list)
            //print("\n\n\n\n\n\n\n\n\n")
            let contentOne = linshi_list[0]
            let contentTwo = linshi_list[1]
            let contentThree = linshi_list[2]
            let contentFour = linshi_list[3]
            
            
            let entry = SimpleEntry(date: entryDate, contentOne: contentOne, contentTwo: contentTwo, contentThree: contentThree, contentFour: contentFour)
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
    var contentOne:String
    var contentTwo:String
    var contentThree:String
    var contentFour:String
}

// 在这里哦
struct cywidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry
    
    @ViewBuilder
    var body: some View {
        cywidgetViewForMiddle(contentOne: entry.contentOne, contentTwo: entry.contentTwo, contentThree: entry.contentThree, contentFour: entry.contentFour, date: entry.date)
//            switch family {
//                case .systemSmall:
//                    break //cywidgetView(first_event:entry.first_event,first_event_description:entry.first_event_description,second_event:entry.second_event,second_event_description:entry.second_event_description,date:entry.date)
//                case .systemMedium: cywidgetViewForMiddle(contentOne: entry.contentOne, contentTwo: entry.contentTwo, contentThree: entry.contentThree, contentFour: entry.contentFour, date: entry.date)
//        //            // 要改成把课程时间写进来
//                case .systemLarge:
//                    break //cywidgetViewForLarge(first_event:entry.first_event,first_event_description:entry.first_event_description,second_event:entry.second_event,second_event_description:entry.second_event_description,date:entry.date,first_begin_time:entry.first_begin_time,first_end_time:entry.first_end_time,second_begin_time:entry.second_begin_time,second_end_time:entry.second_end_time)
//            }
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
        .supportedFamilies([.systemMedium])
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
            HStack {
                Capsule()
                    .frame(width: 3.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading){
                    Text(first_event)
                        .font(.title3)
                        .lineLimit(nil)
                        .padding(.bottom, 1.0)
                    HStack {
                        Text(first_event_description)
                            .font(.callout)
                            .foregroundColor(Color.gray)
                    }
                    
                    
                }
            }
            .padding(.top)
            .padding(.leading)
            
            HStack {
                Capsule()
                    .frame(width: 3.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading){
                    Text(second_event)
                        .font(.title3)
                        .padding(.bottom, 1.0)
                    Text(second_event_description)
                        .font(.callout)
                        .foregroundColor(Color.gray)
                }
            }
            .padding(.bottom)
            .padding(.leading)
        }
    }
}

struct cywidgetViewForMiddle: View {
    var contentOne = "~"
    var contentTwo = "~"
    var contentThree = "~"
    var contentFour = "~"
    
    var date = Date()
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    var body: some View {
        VStack() {
            GeometryReader { geo in
                HStack(alignment: .center) {
                    VStack() {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text(contentOne)
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                    .font(.headline)
                                    .padding(.bottom, 0.1)
                                //Spacer()
                                Text(contentTwo)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    //.padding(.leading, 0.0)
                                    //.border(Color.red)
                                    .padding(.bottom, 0.1)
                                
                                HStack(alignment: .center) {
                                    Image("position")
                                        .resizable()
                                        .frame(width: 16.0, height: 16.0)
                                    //.scaledToFit()
                                    //.border(Color.green)
                                    
                                    Text(contentThree)
                                        .foregroundColor(.gray)
                                        .font(.title3)
                                }
                                //.padding(.top, 0.0)
                                //.border(Color.red)
                            }
                            //.frame(width: 1.0 * geo.size.width, height: 0.5 * geo.size.height)
                            //.border(Color.white)
                            
                            Spacer()
                        }
                        //.border(Color.white)
                        
                        //Spacer()
                        
                        HStack() {
                            Spacer()
                            
                            Text(contentFour)
                                .foregroundColor(.gray)
                                .font(.body)
                                .lineLimit(1)
                        }
                        //.border(Color.white)
                    }
                    //.border(Color.red)
                    //.padding(.top)
                    //.padding(.bottom)
                }
                //.border(Color.yellow)
                .frame(height: 1.0 * geo.size.height)
            }
            .padding(.horizontal)
            //.border(Color.green)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.init(red: Double(0x28) / 255, green: Double(0x2e) / 255, blue: Double(0x34) / 255))
        .edgesIgnoringSafeArea(.all)
        //        GeometryReade { geo in
        //            VStack {
        //                Text(contentOne)
        //            }
        //            .background(Color.black)
        //            .frame(width: geo.size.width, height: geo.size.height)
        //        }
        //        VStack {
        //            Text(contentOne)
        //        }
        //        .background(Color.black)
        //        //.ignoresSafeArea(.all)
        //        .border(Color.red)
        //        .frame(width: .infinity, minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
    
}

//struct cywidgetViewForMiddle: View {
//    var first_event = "～"
//    var first_event_description = "～"
//    var second_event = "～"
//    //    var name = "asdd"
//    var second_event_description = "～"
//    var date = Date()
//    static let taskDateFormat: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm:ss"
//        return formatter
//    }()
//
//    // 显示课程时间
//    var first_begin_time = "08:30"
//    var first_end_time = "10:10"
//
//    var second_begin_time = "10:30"
//    var second_end_time = "12:10"
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            GeometryReader { geo in
//                HStack {
//
//                    VStack (alignment: .leading) {
//                        Text(first_begin_time)
//                            .font(.body)
//                            .padding(.bottom, 3.0)
//
//                        Text(first_end_time)
//                            .font(.callout)
//                            .foregroundColor(Color.gray)
//                    }
//                    .frame(width: 0.16 * geo.size.width)
//
//                    Capsule()
//                        .frame(width: 3.0)
//                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)
//
//                    VStack(alignment: .leading){
//                        Text(first_event)
//                            .font(.title3)
//                            .padding(.bottom, 2.0)
//
//
//                        HStack {
//                            Image("map")
//                                .resizable()
//                                .frame(width: 16.0, height: 16.0)
//                                .scaledToFit()
//                            Text(first_event_description)
//                                .font(.callout)
//                                .foregroundColor(Color.gray)
//                                .frame(height: 16.0)
//                        }
//                    }
//                    Spacer()
//
//                }
//                .padding(.top)
//                .padding(.leading)
//            }
//            //.padding(.horizontal)
//
//            GeometryReader { geo in
//                HStack {
//
//                    VStack (alignment: .leading) {
//                        Text(second_begin_time)
//                            .font(.body)
//                            .padding(.bottom, 1.0)
//                        Text(second_end_time)
//                            .font(.callout)
//                            .foregroundColor(Color.gray)
//                    }
//                    .frame(width: 0.16 * geo.size.width)
//
//                    Capsule()
//                        .frame(width: 3.0)
//                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)
//
//                    VStack(alignment: .leading){
//                        Text(second_event)
//                            .font(.title3)
//                            .padding(.bottom, 2.0)
//                        HStack {
//                            Image("map")
//                                .resizable()
//                                .frame(width: 16.0, height: 16.0)
//                                .scaledToFit()
//
//                            Text(second_event_description)
//                                .font(.callout)
//                                .foregroundColor(Color.gray)
//                        }
//                    }
//                    Spacer()
//
//                }
//                .padding(.bottom)
//                .padding(.leading)
//            }
//            //.padding(.horizontal)
//
//            //Spacer()
//        }
//        //.border(Color.black)
//        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//
//    }
//}

struct cywidgetViewForLarge: View {
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
    
    // 显示课程时间
    var first_begin_time = "08:30"
    var first_end_time = "10:10"
    
    var second_begin_time = "10:30"
    var second_end_time = "12:10"
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geo in
                HStack {
                    
                    VStack (alignment: .leading) {
                        Text(first_begin_time)
                            .font(.body)
                            .padding(.bottom, 3.0)
                        
                        Text(first_end_time)
                            .font(.callout)
                            .foregroundColor(Color.gray)
                    }
                    .frame(width: 0.16 * geo.size.width)
                    
                    Capsule()
                        .frame(width: 3.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading){
                        Text(first_event)
                            .font(.title3)
                            .padding(.bottom, 2.0)
                        
                        
                        HStack {
                            Image("map")
                                .resizable()
                                .frame(width: 16.0, height: 16.0)
                                .scaledToFit()
                            Text(first_event_description)
                                .font(.callout)
                                .foregroundColor(Color.gray)
                                .frame(height: 16.0)
                        }
                    }
                    Spacer()
                    
                }
                .padding(.top)
                .padding(.leading)
            }
            //.padding(.horizontal)
            
            GeometryReader { geo in
                HStack {
                    
                    VStack (alignment: .leading) {
                        Text(second_begin_time)
                            .font(.body)
                            .padding(.bottom, 1.0)
                        Text(second_end_time)
                            .font(.callout)
                            .foregroundColor(Color.gray)
                    }
                    .frame(width: 0.16 * geo.size.width)
                    
                    Capsule()
                        .frame(width: 3.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.349, green: 0.655, blue: 0.843)/*@END_MENU_TOKEN@*/)
                    
                    VStack(alignment: .leading){
                        Text(second_event)
                            .font(.title3)
                            .padding(.bottom, 2.0)
                        HStack {
                            Image("map")
                                .resizable()
                                .frame(width: 16.0, height: 16.0)
                                .scaledToFit()
                            
                            Text(second_event_description)
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                    
                }
                .padding(.bottom)
                .padding(.leading)
            }
            //.padding(.horizontal)
            
            //Spacer()
        }
        //.border(Color.black)
        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        
    }
}

//struct cywidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        cywidgetView()
//    }
//}

