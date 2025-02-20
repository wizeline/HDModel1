import SwiftUI

struct EmergencyIncidentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var countdown = 10
    @State private var showingEmergencyAlert = false
    @State private var timer: Timer?
    
    // MARK: - Animation states
    @State private var isWarningAnimating = false
    @State private var isCountdownPulsing = false
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // MARK: - Warning Icon with scale animation only
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundStyle(
                    Color.orange.gradient.opacity(isWarningAnimating ? 0.8 : 1)
                )
                .scaleEffect(isWarningAnimating ? 1.1 : 1.0)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: true),
                    value: isWarningAnimating
                )
            
            // MARK: - Main message with fade in
            Text("Are you alright?")
                .font(.title.bold())
                .padding(.bottom, 4)
                .opacity(isWarningAnimating ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: isWarningAnimating)
            
            Text("We've detected you might have been involved in an incident. If you're able to respond, please let us know you're safe.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .opacity(isWarningAnimating ? 1 : 0)
                .animation(.easeIn(duration: 0.5).delay(0.2), value: isWarningAnimating)
            
            // MARK: - Countdown with pulse animation
            Text("\(countdown)")
                .font(.system(size: 72, weight: .bold))
                .foregroundStyle(Color.orange.gradient)
                .scaleEffect(isCountdownPulsing ? 1.1 : 1.0)
                .animation(
                    .easeInOut(duration: 0.5)
                    .repeatForever(autoreverses: true),
                    value: isCountdownPulsing
                )
                .padding(.vertical)
            
            Text("Automatic emergency response in")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // MARK: - Exit button with hover effect
            Button(action: { dismiss() }) {
                Text("I'M SAFE - CANCEL EMERGENCY")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                Color.black.gradient
                            )
                    )
                    .shadow(
                        color: Color.black.opacity(0.2),
                        radius: 8,
                        y: 4
                    )
            }
            .padding(.horizontal)
            .padding(.top)
            .scaleEffect(isWarningAnimating ? 1 : 0.95)
            .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isWarningAnimating)
            
            Spacer()
        }
        .padding()
        .onAppear {
            startCountdown()
            withAnimation {
                isWarningAnimating = true
                isCountdownPulsing = true
            }
        }
        .onChange(of: countdown) { newValue in
            if newValue == 0 {
                showingEmergencyAlert = true
                // Add 3-second delay to dismiss
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    dismiss()
                }
            }
        }
        .alert(isPresented: $showingEmergencyAlert) {
            Alert(
                title: Text("Emergency Services Notified"),
                message: Text("We've automatically notified emergency services and your emergency contacts. Help is on the way. Stay calm and remain in a safe location if possible."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
} 
