import Foundation

struct FaqItem: Identifiable {
    let id = UUID().uuidString
    let question: String
    let answer: String
    let keywords: [String]
}

extension FaqItem {
    static var mockData: [FaqItem] {
        [
        FaqItem(
            question: "How often should I check my motorcycle's tire pressure?",
            answer: "Check tire pressure at least weekly when the tires are cold. For most Harley-Davidson motorcycles, the recommended pressure is typically between 30-40 PSI, but always refer to your specific model's manual. Proper tire pressure is crucial for handling, safety, and tire longevity.",
            keywords: [
                "tire",
                "pressure",
                "maintenance",
                "safety",
                "psi",
                "check"
            ]
        ),
        FaqItem(
            question: "What's the break-in procedure for a new Harley-Davidson?",
            answer: "During the first 500 miles: Avoid full throttle starts, don't exceed 3000 RPM, vary engine speed, avoid constant speed for long periods, and use extra caution. This helps ensure proper seating of piston rings and other components.",
            keywords: [
                "break-in",
                "new",
                "motorcycle",
                "engine",
                "maintenance",
                "first",
                "miles"
            ]
        ),
        FaqItem(
            question: "How does the HD-Connect safety system work?",
            answer: "HD-Connect uses advanced sensors and AI to monitor your riding patterns, road conditions, and bike performance in real-time. It provides proactive alerts for potential hazards, suggests safer routes based on current conditions, and can automatically notify emergency contacts in case of an incident.",
            keywords: [
                "safety",
                "connect",
                "monitoring",
                "alerts",
                "emergency",
                "system"
            ]
        ),
        FaqItem(
            question: "What should I do if my bike's safety system detects an issue?",
            answer: "If you receive a safety alert, find a safe place to stop. The app will provide detailed information about the detected issue and recommend appropriate action. For serious issues, it can connect you directly with HD support or emergency services.",
            keywords: [
                "safety",
                "alert",
                "emergency",
                "support",
                "issue",
                "problem"
            ]
        ),
        FaqItem(
            question: "How do I maximize my safety score in the HD app?",
            answer: "Your safety score improves with consistent, smooth riding: maintain steady speeds, brake gradually, take turns smoothly, and follow traffic rules. The app analyzes your riding patterns and provides personalized tips for improvement.",
            keywords: [
                "safety",
                "score",
                "riding",
                "improvement",
                "tips",
                "app"
            ]
        ),
        FaqItem(
            question: "What's included in the HD emergency assistance package?",
            answer: "The package includes 24/7 roadside assistance, emergency towing to the nearest HD dealer, fuel delivery, battery jump-start, and flat tire assistance. It also provides emergency medical coordination and travel interruption benefits.",
            keywords: [
                "emergency",
                "assistance",
                "roadside",
                "towing",
                "help"
            ]
        ),
        FaqItem(
            question: "How does the weather alert system work?",
            answer: "The system monitors real-time weather conditions along your route. It alerts you to severe weather, suggests alternative routes, and provides safe stopping points. Alerts include precipitation, temperature changes, and severe weather warnings.",
            keywords: [
                "weather",
                "alerts",
                "conditions",
                "safety",
                "route"
            ]
        ),
        FaqItem(
            question: "What's the recommended maintenance schedule for my HD?",
            answer: "Basic checks (oil, tires, brakes) should be done monthly. Major service intervals vary by model but typically occur at 1,000, 5,000, and 10,000 miles. The app tracks your mileage and sends maintenance reminders based on your specific model.",
            keywords: [
                "maintenance",
                "service",
                "schedule",
                "checks",
                "reminders"
            ]
        ),
        FaqItem(
            question: "How does the group ride feature work?",
            answer: "The group ride feature lets you create or join ride groups, share real-time locations, and communicate through the intercom system. It includes safety features like group speed monitoring and automatic regrouping suggestions.",
            keywords: [
                "group",
                "ride",
                "social",
                "communication",
                "tracking"
            ]
        ),
        FaqItem(
            question: "What should I do if my bike detects a mechanical issue?",
            answer: "When the system detects an issue, it will provide a detailed diagnostic report and severity level. For minor issues, you'll receive maintenance recommendations. For serious problems, it will guide you to the nearest HD service center and can automatically schedule an appointment.",
            keywords: [
                "mechanical",
                "issue",
                "diagnostic",
                "service",
                "maintenance",
                "problem"
            ]
        )
    ]
    }
}
