import SwiftUI
import FSCalendar


struct FSCalendarView: UIViewControllerRepresentable {
    
    @ObservedObject var diaryFetcher: DiaryFetcher = DiaryFetcher()
    
    var controller: MyCalendarViewController
    
    var navi: UINavigationController
    
    init() {
        controller = MyCalendarViewController()
        navi = UINavigationController(rootViewController: controller)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        controller.calendar.delegate = context.coordinator
        controller.calendar.dataSource = context.coordinator
        loadData()
        return navi
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
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
                showDiaryDetail(seq: seq)
            }
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return parent.controller.registeredSeq[date.getDateString()] != nil ? 1 : 0
        }
        
        private func showDiaryDetail(seq: Int64) {
            let hostingConroller = UIHostingController(rootView: DiaryDetilView(diarySeq: seq))
            parent.navi.pushViewController(hostingConroller, animated: true)
        }
    }
}
