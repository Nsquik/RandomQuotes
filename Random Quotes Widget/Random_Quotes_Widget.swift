//
//  Random_Quotes_Widget.swift
//  Random Quotes Widget
//
//  Created by Kacper Kędzierski on 15/06/2023.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: "Can a man still be brave if he's afraid? That is the only time a man can be brave.")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quote: "Can a man still be brave if he's afraid? That is the only time a man can be brave.")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task{
            let currentDate = Date()
            
            let gotQuote = try await Quote.random(source: GameOfThronesDataSource())?.content ?? ""
            let bbQuote = try await Quote.random(source: BreakingBadDataSource())?.content ?? ""
            let bcsQuote = try await Quote.random(source: BetterCallSaulDataSource())?.content ?? ""

            let gotEntry = SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!, quote: gotQuote)
            let bbEntry = SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!, quote: bbQuote)
            let bcsEntry = SimpleEntry(date: Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!, quote: bcsQuote)
            
            let timeline = Timeline(entries: [gotEntry, bbEntry, bcsEntry], policy: .atEnd)
            completion(timeline)
            }
        }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: String
}

struct Random_Quotes_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        let quoteToDisplay = entry.quote
        VStack{
            Text(quoteToDisplay)
                .padding(.all, 20)
        }
    }
}

struct Random_Quotes_Widget: Widget {
    let kind: String = "Random_Quotes_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Random_Quotes_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct Random_Quotes_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Random_Quotes_WidgetEntryView(entry: SimpleEntry(date: Date(), quote: "Can a man still be brave if he's afraid? That is the only time a man can be brave."))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
