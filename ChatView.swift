import SwiftUI

struct ChatbotView: View {
    @State private var userMessage: String = ""
    @State private var messages: [(String, Bool)] = []
    @State private var navigateToMeditation: Bool = false
    @State private var navigateToGoals: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { scrollView in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(messages.indices, id: \.self) { index in
                                MessageBubble(text: messages[index].0, isUser: messages[index].1)
                                    .id(index)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            scrollView.scrollTo(messages.count - 1, anchor: .bottom)
                        }
                    }
                }

                HStack {
                    TextField("Type a message...", text: $userMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                .padding()

                NavigationLink(destination: MeditationView(), isActive: $navigateToMeditation) {
                    EmptyView()
                }
                NavigationLink(destination: GoalsView(), isActive: $navigateToGoals) {
                    EmptyView()
                }
            }
            .navigationTitle("Chat")
        }
    }

    func sendMessage() {
        guard !userMessage.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let userText = userMessage
        messages.append((userText, true))
        userMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let botResponse = getBotResponse(for: userText)
            messages.append((botResponse, false))
        }
    }

    func getBotResponse(for message: String) -> String {
        let lowerMessage = message.lowercased()

        let responses: [String: [String]] = [
            "Hi there! How can I assist you today?": ["hello", "hi", "hey"],
            "I'm just a bot, but I'm here to help!": ["how are you"],
            "Goodbye! Have a great day!": ["goodbye"],
            "I can assist with meditation, breathing exercises, and relaxation tips.": ["help"],
            "Meditation is great for relaxation! Would you like to start a guided session?": ["meditate", "relax", "calm", "mindfulness", "zen", "peace", "tranquility"],
            "Starting a meditation session now... 🧘‍♂️": ["start meditation"],
            "Try this: Breathe in for 4 seconds, hold for 4 seconds, and exhale for 4 seconds. Repeat 5 times!": ["breathing"],
            "Feeling stressed? Try deep breathing and focus on the present moment.": ["stress relief"],
            "A 5-minute meditation session can help clear your mind!": ["focus"],
            "A short guided meditation before bed can improve sleep quality. Would you like some tips?": ["sleep"],
            "Navigating to the goals page...": ["add goal"]
        ]

        for (response, keywords) in responses {
            for keyword in keywords {
                if lowerMessage.contains(keyword) {
                    if keyword == "start meditation" {
                        navigateToMeditation = true
                    } else if keyword == "add goal" {
                        navigateToGoals = true
                    }
                    return response
                }
            }
        }

        return "I'm not sure I understand. Can you try asking something else?"
    }
}
