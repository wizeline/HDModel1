import Foundation
import SwiftUI

struct Constants {
    static let conversation: [(speaker: String, message: String)] = [
        ("You", "Hey HD, I need to contact insurance assistance."),
        ("HD", "I'll connect you with our insurance service right away."),
        ("HD", "Connecting to HD Insurance Services..."),
        ("Agent", "Hello, this is Sarah from HD Insurance. How can I help you today?"),
        ("You", "Hi, I've had a minor incident with my bike."),
        ("Agent", "I understand. First, could you confirm your full name?"),
        ("You", "John Smith"),
        ("Agent", "Thank you, John. Could you provide your insurance policy number?"),
        ("You", "Yes, it's HD-2024-789456"),
        ("Agent", "Perfect! I've found your State Farm policy. I can see you have comprehensive coverage. Click the attachment below to view your policy details:\n\n📎 Policy_Details.pdf"),
        ("You", "Yes, I'm safely off the road."),
        ("Agent", "Good. I can see your location. Do you need roadside assistance?"),
        ("You", "Yes, please."),
        ("Agent", "I'm dispatching a tow service to your location. ETA 20 minutes."),
        ("Agent", "Would you like me to arrange a replacement vehicle?"),
        ("You", "No thanks, I have alternative transportation."),
        ("Agent", "Alright. You'll receive an SMS with the tow service details."),
        ("HD", "I've saved this incident report to your account.")
    ]
    
    static let encouragingPhrases = [
        "Keep up the safe riding! 🏍",
        "You're becoming a safety pro! 🌟",
        "Your riding skills are impressive! 💫",
        "Making the roads safer, one ride at a time! 🛣",
        "Your dedication to safety shows! 🎯"
    ]
    
    static let incidentConversation: [(speaker: String, message: String)] = [
        ("HD", "I'll help you report this incident. Are you in a safe location?"),
        ("You", "Yes, I'm safe."),
        ("HD", "Good. Please select the type of incident you'd like to report:"),
        ("HD", "I'll guide you through the process and notify relevant services if needed.")
    ]
    
}
