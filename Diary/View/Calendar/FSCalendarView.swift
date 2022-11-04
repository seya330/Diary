import SwiftUI
import FSCalendar


struct FSCalendarView: UIViewControllerRepresentable {
    
    @ObservedObject var diaryFetcher: DiaryFetcher = DiaryFetcher()
    
    @Binding var isShowDetailView: Bool
    
    @Binding var seq: Int64
    
    var controller: MyCalendarViewController = MyCalendarViewController()
    
    func makeUIViewController(context: Context) -> MyCalendarViewController {
        controller.calendar.delegate = context.coordinator
        controller.calendar.dataSource = context.coordinator
        loadData()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MyCalendarViewController, context: Context) {
        controller.calendar.reloadData()
    }
    
    func makeCoordinator() -> FSCalendarView.Coordinator {
        return Coordinator(self)
    }
    
    private func loadData() {
        let currentMonth: Date = controller.calendar.currentPage
        let first: Date = currentMonth.startOfDay.minusDays(7)
        let last: Date = currentMonth.endOfMonth.plusDays(7)
        diaryFetcher.getDiaryRegisteredDates(
            startDate: DateFactory.of(year: first.year, month: first.month, day: first.day),
            endDate: DateFactory.of(year: last.year, month: last.month, day: last.day)
        ) {
            controller.registeredSeq.removeAll()
            diaryFetcher.registeredSeq.forEach { date in
                controller.registeredSeq[date.key.getDateString()] = date.value
            }
            controller.reload()
        }
    }
}

class MyCalendarViewController: UIViewController{
    
    var calendar: FSCalendar = FSCalendar()
    
    var registeredSeq: [String: Int64] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.appearance.headerTitleFont = UIFont(name: "ACCchildrenheart", size: 23)
        calendar.appearance.headerTitleColor = UIColor(red: 230/255, green: 129/255, blue: 213/255, alpha: 1)
        calendar.appearance.headerDateFormat = "YYYY\n\nMM월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = calendar.appearance.headerTitleFont.lineHeight*4
        calendar.appearance.weekdayFont = UIFont(name: "ACCchildrenheart", size: 20)
        calendar.appearance.titleFont = UIFont(name: "ACCchildrenheart", size: 18)
        calendar.scrollEnabled = true
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(red: 230/255, green: 84/255, blue: 73/255, alpha: 1)
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(red: 12/255, green: 168/255, blue: 235/255, alpha: 1)
        view.addSubview(calendar)
    }
    
    func reload() {
        calendar.reloadData()
    }
}

extension FSCalendarView {
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
    var parent: FSCalendarView
        
        init(_ parent: FSCalendarView) {
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            if monthPosition == .previous || monthPosition == .next {
                calendar.setCurrentPage(date, animated: true)
                parent.loadData()
            }
            
            //TODO 다시한번 다이어리 작성 되어 있는지 확인 call
            
            if let seq = parent.controller.registeredSeq[date.getDateString()] {
                parent.seq = seq
                parent.isShowDetailView = true
            }
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return parent.controller.registeredSeq[date.getDateString()] != nil ? 1 : 0
        }
    }
}
