import SwiftUI

struct ScrumsViews: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var sortOption: SortOption = .attendees
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void
    
    enum SortOption {
        case attendees
        case lengthInMinutes
    }
        
    var sortedScrums: [DailyScrum] {
        switch sortOption {
        case .attendees:
            return scrums.sorted(by: { $0.attendees.count > $1.attendees.count })
        case .lengthInMinutes:
            return scrums.sorted(by: { $0.lengthInMinutes > $1.lengthInMinutes })
        }
    }
    
    var body: some View {
        NavigationStack{
            List(sortedScrums, id: \.title) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                    }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        Menu {
            Button(action: { sortOption = .attendees }) {
                Label("Sort by Attendees", systemImage: sortOption == .attendees ? "checkmark.circle.fill" : "circle")
            }
                               
            Button(action: { sortOption = .lengthInMinutes }) {
                Label("Sort by Length", systemImage: sortOption == .lengthInMinutes ? "checkmark.circle.fill" : "circle")
            }
        }
        label: { Image(systemName: "arrow.up.arrow.down.circle") }
            .accessibilityLabel("Sort Options")
            .font(.system(size:30))
            .padding(5)
        
            .sheet(isPresented: $isPresentingNewScrumView){
                NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}
struct ScrumViews_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsViews(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
