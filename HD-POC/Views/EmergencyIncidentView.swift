import SwiftUI

struct EmergencyIncidentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var countdown = 10
    @State private var showingEmergencyAlert = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Warning Icon
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(.red)
            
            // Main message
            Text("Are you alright?")
                .font(.title.bold())
                .padding(.bottom, 4)
            
            Text("We've detected you might have been involved in an incident. If you're able to respond, please let us know you're safe.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            // Countdown
            Text("\(countdown)")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.red)
                .padding(.vertical)
            
            Text("Automatic emergency response in")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Exit button
            Button(action: { dismiss() }) {
                Text("I'M SAFE - CANCEL EMERGENCY")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.green)
                    )
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .onAppear {
            startCountdown()
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