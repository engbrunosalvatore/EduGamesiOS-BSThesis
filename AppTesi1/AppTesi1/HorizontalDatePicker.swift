//
//  HorizontalDatePicker.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 28/03/23.
//


import SwiftUI

struct HorizontalDatePickerView: View {
    @State var selectedDate = Date()
    
    var body: some View {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: selectedDate)
        let month = calendar.component(.month, from: selectedDate)
        let daysInMonth = calendar.range(of: .day, in: .month, for: selectedDate)!.count
        
        ScrollViewReader { scrollView in
            VStack {
                HStack {
                    Button(action: {
                        selectedDate = calendar.date(byAdding: .month, value: -1, to: selectedDate)!
                    }, label: {
                        Image(systemName: "arrow.left")
                    })
                    Spacer()
                    Text("\(calendar.monthSymbols[month - 1]) \(String(year))")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        selectedDate = calendar.date(byAdding: .month, value: 1, to: selectedDate)!
                    }, label: {
                        Image(systemName: "arrow.right")
                    })
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(dateRange(from: calendar.date(from: DateComponents(year: year, month: month, day: 1))!, to: calendar.date(from: DateComponents(year: year, month: month, day: daysInMonth))!), id: \.self) { date in
                            let dayOfWeek = calendar.component(.weekday, from: date)
                            let dayOfMonth = calendar.component(.day, from: date)
                            VStack {
                                Text("\(dayOfMonth)")
                                    .font(.title2)
                                    .foregroundColor(.primary)
                                Text("\(calendar.shortWeekdaySymbols[dayOfWeek - 1])")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            .padding(10)
                            .background(selectedDate.isSameDay(as: date) ? Color.accentColor : Color.clear)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedDate = date
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .onAppear {
                        scrollView.scrollTo(Date(), anchor: .center)
                    }
                }
            }
            .frame(height: 150)
        }
    }
    
    func dateRange(from start: Date, to end: Date) -> [Date] {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.year, .month, .day], from: start)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: end)
        var dates: [Date] = []
        var currentDate = start
        while currentDate <= end {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        return dates
    }
}

extension Date {
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}

struct HorizontalDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDatePickerView()
    }
}
