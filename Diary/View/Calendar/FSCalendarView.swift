import SwiftUI
import FSCalendar


struct FSCalendarView: UIViewControllerRepresentable {
    
    @ObservedObject var diaryFetcher: DiaryFetcher = DiaryFetcher()
    
    var controller: MyCalendarViewController = MyCalendarViewController()
    
    func makeUIViewController(context: Context) -> MyCalendarViewController {
        controller.calendar.delegate = context.coordinator
        controller.calendar.dataSource = context.coordinator
        loadData()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: MyCalendarViewController, context: Context) {
        uiViewController.calendar.reloadData()
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
            controller.registeredDate.removeAll()
            diaryFetcher.registeredDates.forEach { date in
                if let cnt = controller.registeredDate[date.getDateString()] {
                    controller.registeredDate[date.getDateString()]! += cnt
                } else {
                    controller.registeredDate[date.getDateString()] = 1
                }
            }
            controller.reload()
        }
    }
}

class MyCalendarViewController: UIViewController{
    
    var calendar: FSCalendar = FSCalendar()
    
    var registeredDate: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
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
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return parent.controller.registeredDate[date.getDateString()] ?? 0
        }
    }
}
