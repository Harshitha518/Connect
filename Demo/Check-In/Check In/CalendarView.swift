//
//  CalendarView.swift
//  Check In
//
//  Created by Harshitha Rajesh on 10/14/24.
//

import SwiftUI

struct CalendarView: View {
    //@EnvironmentObject var history: History
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var date: Date = Date.now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    

    
    var body: some View {
        VStack {
           
            LabeledContent("Calendar Date/Time") {
                DatePicker("", selection: $date, displayedComponents: .date)
            }
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .fontWeight(.black)
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns, content: {
                ForEach(days, id: \.self) { day in
                    if day.monthInt != date.monthInt {
                        Text("")
                    } else {
                        VStack {
                            Text(day.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .background (
                                    
                                    ZStack {
                                        Circle()
                                            .foregroundStyle (
                                                checkedIn(day: day) == false && day < Date.now  ? .red.opacity(0.3) : .clear
                                            )
                                            .frame(width: 50, height: 60)
                                        
                                        Circle()
                                            .foregroundStyle (
                                                checkedIn(day: day)  ? .green.opacity(0.3) : .clear
                                            )
                                            .frame(width: 50, height: 60)

                                    }
                                )
                                
                              
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(Date.now.startOfDay == day.startOfDay ? .black : .clear)
                            
                            
                        
                             
                            

                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        

                    }
                }
            })
        }
        .padding()
        .onAppear {
            days = date.calendarDisplayDays
        }
        .onChange(of: date) {
            days = date.calendarDisplayDays
        }
    }
    
    func checkedIn(day: Date) -> Bool {
        let user = authViewModel.currentUser?.infoHistory ?? [Info]()
        for info in user {
            if info.date == day {
                return true
            }
        }
        return false
    }
    
}



extension Date {
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols
        
        return weekdays.map { weekday in
            guard let firstLetter = weekday.first else { return "" }
            return String(firstLetter).capitalized
        }
    }
    
    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var sundayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday - 1
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        // previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        
        return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

#Preview {
    CalendarView()
        .environmentObject(AuthViewModel())
}

