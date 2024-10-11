import SwiftUI

struct TermsAndAgreementView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var agreedToTerms: Bool
    @Binding var showModelPersonalization: Bool
    let option: PersonalizationOption
    
    let termsText = """
    **Terms and Agreement (With GDPR Compliance)**

    **1. Consent to Upload and Use Personal Data**

    By proceeding, you confirm that you have the legal authority to upload and use the provided voice recordings, images, and personal data. You must ensure that these materials are from individuals you are authorized to represent, such as family members, and that no third-party rights are infringed. In accordance with the General Data Protection Regulation (GDPR), you have the right to withdraw consent at any time without affecting the legality of the processing carried out before withdrawal.

    This includes:

    Explicit Consent: You consent to the processing of this data through AI-based services, including but not limited to OpenAI APIs and Text-to-Speech (TTS) APIs, for the creation of personalized models.
    Verification of Relationship: You may be required to verify your relationship with the individual whose data you are uploading, ensuring that you have the right to use their likeness, voice, and other personal information.

    **2. Use of AI Technology**

    Our platform utilizes AI tools such as OpenAI's GPT models, TTS services, and other machine learning models to create personalized interactions. These AI services are used solely for the purpose of delivering personalized experiences based on the data you upload.

    By agreeing to these terms, you understand that:

    The AI-generated content is created based on the inputs (voice, photos, text) you provide.
    Transparency of AI Usage: You acknowledge that the service utilizes AI to generate responses and outputs. We will provide clear indications that any output generated is created by AI.

    **3. Responsibility for Uploaded Content**

    You acknowledge that all content uploaded to the platform, including voice samples, photos, and personal data, is your sole responsibility. The materials must not violate any privacy rights, intellectual property rights, or any other rights under applicable law.

    Data Accuracy: You confirm that the data you provide is accurate, up-to-date, and legally obtained.
    Indemnification: You agree to indemnify and hold the company harmless from any legal disputes that arise from the content you upload or the use of AI-generated models created from that content.

    **4. Data Privacy and Security (GDPR Compliant)**

    We prioritize your privacy and ensure that all data is handled in compliance with applicable data protection laws, including GDPR (for users in the European Union), PIPEDA (for Canada), and other relevant regulations.

    Your GDPR Rights Include:

    Right to Access: You have the right to access any personal data we hold about you.
    Right to Erasure: You can request that we delete your data, and we will ensure it is erased in compliance with GDPR's "Right to be Forgotten" principle.
    Data Portability: You have the right to request a copy of your personal data in a structured, commonly used, and machine-readable format.
    Right to Object: You can object to the processing of your personal data at any time.
    Data Usage: The voice samples, images, and personal data you upload are used only for the purpose of generating personalized AI interactions. The company will not use or sell your data for any other purpose without your explicit consent.
    Third-Party APIs: Your data may be shared with third-party AI services (such as OpenAI or TTS providers) for processing but will remain secure and subject to the same privacy and data protection standards.

    **5. Data Deletion Upon Unsubscribing**

    Upon unsubscribing from the service, we guarantee the permanent deletion of all the data you have uploaded, including voice samples, photos, and any associated AI-generated models.

    Erasure Guarantee: All data will be erased within 30 days after unsubscribing, and you will receive a confirmation of deletion. This applies to data stored on our servers as well as data shared with third-party AI providers.
    Retention Period: Data will only be retained for as long as necessary to provide the services, and no longer than the duration of your subscription.

    **6. AI Ethics and Limitations**

    The AI-generated content produced by this service is for personal use only. You agree not to misuse AI-generated models to create harmful or defamatory representations of individuals. We are committed to ethical AI usage, ensuring that:

    No Deepfake Misuse: You cannot use AI-generated content to impersonate individuals in a misleading or malicious manner, especially in ways that could harm their reputation.
    Transparency: We make it clear that the output is AI-generated and does not represent the actual words, thoughts, or actions of real individuals.

    **7. iOS & Android Store Compliance**

    To comply with the Apple App Store and Google Play Store guidelines, we include the following provisions:

    Data Privacy and Security: We adhere to Apple's App Store Review Guidelines (Section 5.1) and Google Play's User Data Policy, ensuring that any data collected is secure, not shared without explicit consent, and can be deleted at the user's request.
    User Choice and Control: You have control over how your personal data is used, and you can request data deletion at any time through the app's privacy settings. In accordance with Apple and Google's policies, users will be informed about the purpose of data collection and processing before providing consent.

    **8. Limitation of Liability**

    The company is not liable for any emotional distress or legal disputes that may arise from the use of AI-generated models of your loved ones or other individuals. You acknowledge that AI-generated content may not always align with reality, and you assume full responsibility for its use.

    No Guarantee of Exact Representation: While we strive to provide a personalized and realistic AI interaction, we cannot guarantee that the AI model will perfectly match the likeness or personality of the individual.

    **9. Governing Law**

    These terms shall be governed by and construed in accordance with:

    For users in the European Union, these terms comply with the General Data Protection Regulation (GDPR).
    For users in Canada, these terms comply with the Personal Information Protection and Electronic Documents Act (PIPEDA).
    For users in other jurisdictions, local privacy and data protection laws will apply.
    Any disputes arising from the use of our services shall be resolved in courts located in the user's respective jurisdiction.
    """
    
    @State private var scrollOffset: CGFloat = 0
    @State private var scrollViewHeight: CGFloat = 0
    @State private var contentHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            StarryBackgroundView(starCount: 100)
            
            VStack(spacing: 20) {
                Text("Terms & Agreement")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                ScrollView(.vertical, showsIndicators: true) {
                    Text(.init(termsText))
                        .foregroundColor(.black)
                        .padding()
                        .background(GeometryReader { proxy in
                            Color.clear.preference(key: ViewOffsetKey.self, value: proxy.frame(in: .named("scroll")).minY)
                        })
                        .background(GeometryReader { proxy in
                            Color.clear.onAppear {
                                contentHeight = proxy.size.height
                            }
                        })
                }
                .frame(height: UIScreen.main.bounds.height * 0.6)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.05, green: 0.05, blue: 0.15), lineWidth: 2)
                )
                .coordinateSpace(name: "scroll")
                .background(GeometryReader { proxy in
                    Color.clear.onAppear {
                        scrollViewHeight = proxy.size.height
                    }
                })
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    scrollOffset = offset
                    if -scrollOffset + scrollViewHeight >= contentHeight {
                        withAnimation {
                            agreedToTerms = true
                        }
                    }
                }
                
                Toggle(isOn: $agreedToTerms) {
                    Text("I agree to the terms and conditions")
                        .foregroundColor(.white)
                }
                .disabled(!agreedToTerms)
                .padding()
                .background(Color(red: 0.05, green: 0.05, blue: 0.15))
                .cornerRadius(10)
                
                Button(action: {
                                    if agreedToTerms {
                                        showModelPersonalization = true
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }) {
                                    Text("Continue")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(agreedToTerms ? Color.white : Color.gray)
                                        .foregroundColor(Color(red: 0.05, green: 0.05, blue: 0.15))
                                        .cornerRadius(10)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                                .disabled(!agreedToTerms)
                                .padding(.horizontal)
                            }
                            .padding()
                        }
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarBackButtonHidden(false)
                    }
                }
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}