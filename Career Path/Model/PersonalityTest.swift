//
//  PersonalityTest.swift
//  Career_Path
//
//  Created by iosdev on 20/11/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import Foundation

   //MARK: MBTI personality test based on personality types

    struct Question {
        var text: String
        var answers: [Answer]
    }
    
    struct Answer {
        var text: String
        var type: PersonalType
    }
    
    enum PersonalType: String {
        case E = "extraverted", I = "introverted", S = "sensing", N = "iNtuitive",
             T = "thinking", F = "feeling", J = "judging", P = "perceiving"
        
        func convertToInt() -> Int {
            switch self {
            case .E:
                return 0
            case .I:
                return 1
            case .S:
                return 2
            case .N:
                return 3
            case .T:
                return 4
            case .F:
                return 5
            case .J:
                return 6
            case .P:
                return 7
            }
        }
    }

    class PersonalityTest {
   
        //now 40 questions (in oroginal MBTI test 70 questions)
        
    var questions: [Question] = [
        
        //1
        Question(text:"At a party do you:", answers: [
            Answer(text: "Interact with many, including strangers", type: .E),
            Answer(text: "Interact with a few, known to you", type: .I)
            ]),
        //2
        Question(text:"Are you more:", answers: [
            Answer(text: "Realistic than speculative", type: .S),
            Answer(text: "Speculative than realistic", type: .N)
            ]),
        //3
        Question(text:"Is it worse to:", answers: [
            Answer(text: "Have your “head in the clouds”", type: .S),
            Answer(text: "Be “in a rut”", type: .N)
            ]),
        //4
        Question(text:"Are you more impressed by:", answers: [
            Answer(text: "Principles", type: .T),
            Answer(text: "Emotions", type: .F)
            ]),
        //5
        Question(text:"Are more drawn toward the:", answers: [
            Answer(text: "Convincing", type: .T),
            Answer(text: "Touching", type: .F)
            ]),
        //6
        Question(text:"Do you prefer to work:", answers: [
            Answer(text: "To deadlines", type: .J),
            Answer(text: "Just “whenever”", type: .P)
            ]),
        //7
        Question(text:"Do you tend to choose:", answers: [
            Answer(text: "Rather carefully", type: .J),
            Answer(text: "Somewhat impulsively", type: .P)
            ]),
        //8
        Question(text:"At parties do you:", answers: [
            Answer(text: "Stay late, with increasing energy", type: .E),
            Answer(text: "Leave early with decreased energy", type: .I)
            ]),
        //9
        Question(text:"Are you more attracted to:", answers: [
            Answer(text: "Sensible people", type: .S),
            Answer(text: "Imaginative people", type: .N)
            ]),
        //10
        Question(text:"Are you more interested in:", answers: [
            Answer(text: "What is actual", type: .S),
            Answer(text: "What is possible", type: .N)
            ]),
        //11
        Question(text:"In judging others are you more swayed by:", answers: [
            Answer(text: "Laws than circumstances", type: .T),
            Answer(text: "Circumstances than laws", type: .F)
            ]),
        //12
        Question(text:"In approaching others is your inclination to be somewhat:", answers: [
            Answer(text: "Objective", type: .T),
            Answer(text: "Personal", type: .F)
            ]),
        //13
        Question(text:"Are you more:", answers: [
            Answer(text: "Punctual", type: .J),
            Answer(text: "Leisurely", type: .P)
            ]),
        //14
        Question(text:"Does it bother you more having things:", answers: [
            Answer(text: "Incomplete", type: .J),
            Answer(text: "Completed", type: .P)
            ]),
        //15
        Question(text:"In your social groups do you:", answers: [
            Answer(text: "Keep abreast of other’s happenings", type: .E),
            Answer(text: "Get behind on the news", type: .I)
            ]),
        //16
        Question(text:"In doing ordinary things are you more likely to:", answers: [
            Answer(text: "Do it the usual way", type: .S),
            Answer(text: "Do it your own way", type: .N)
            ]),
        //17
        Question(text:"Writers should:", answers: [
            Answer(text: "“Say what they mean and mean what they say”", type: .S),
            Answer(text: "Express things more by use of analogy", type: .N)
            ]),
        //18
        Question(text:"Which appeals to you more:", answers: [
            Answer(text: "Consistency of thought", type: .T),
            Answer(text: "Harmonious human relationships", type: .F)
            ]),
        //19
        Question(text:"Are you more comfortable in making:", answers: [
            Answer(text: "Logical judgments", type: .T),
            Answer(text: "Value judgments", type: .F)
            ]),
        //20
        Question(text:"Do you want things:", answers: [
            Answer(text: "Settled and decided", type: .J),
            Answer(text: "Unsettled and undecided", type: .P)
            ]),
        //21
        Question(text:"Would you say you are more:", answers: [
            Answer(text: "Serious and determined", type: .J),
            Answer(text: "Easy-going", type: .P)
            ]),
        //22
        Question(text:"In phoning do you:", answers: [
            Answer(text: "Rarely question that it will all be said", type: .E),
            Answer(text: "Rehearse what you’ll say", type: .I)
            ]),
        //23
        Question(text:"Facts:", answers: [
            Answer(text: "“Speak for themselves”", type: .S),
            Answer(text: "Illustrate principles", type: .N)
            ]),
        //24
        Question(text:"Are visionaries:", answers: [
            Answer(text: "Somewhat annoying", type: .S),
            Answer(text: "Rather fascinating", type: .N)
            ]),
        //25
        Question(text:"Are you more often:", answers: [
            Answer(text: "A cool-headed person", type: .T),
            Answer(text: "A warm-hearted person", type: .F)
            ]),
        //26
        Question(text:"Is it worse to be:", answers: [
            Answer(text: "Unjust", type: .T),
            Answer(text: "Merciless", type: .F)
            ]),
        //27
        Question(text:"Should one usually let events occur:", answers: [
            Answer(text: "by careful selection and choice", type: .J),
            Answer(text: "randomly and by chance", type: .P)
            ]),
        //28
        Question(text:"Do you feel better about:", answers: [
            Answer(text: "having purchased", type: .J),
            Answer(text: "having the option to buy", type: .P)
            ]),
        //29
        Question(text:"In company do you:", answers: [
            Answer(text: "initiate conversation", type: .E),
            Answer(text: "wait to be approached", type: .I)
            ]),
        //30
        Question(text:"Common sense is:", answers: [
            Answer(text: "rarely questionable", type: .S),
            Answer(text: "frequently questionable", type: .N)
            ]),
        //31
        Question(text:"Children often do not:", answers: [
            Answer(text: "make themselves useful enough", type: .S),
            Answer(text: "exercise their fantasy enough", type: .N)
            ]),
        //32
        Question(text:"In making decisions do you feel more comfortable with:", answers: [
            Answer(text: "standards", type: .T),
            Answer(text: "feelings", type: .F)
            ]),
        //33
        Question(text:"Are you more:", answers: [
            Answer(text: "firm than gentle", type: .T),
            Answer(text: "gentle than firm", type: .F)
            ]),
        //34
        Question(text:"Which is more admirable:", answers: [
            Answer(text: "the ability to organize and be methodical", type: .J),
            Answer(text: " the ability to adapt and make do", type: .P)
            ]),
        //35
        Question(text:"Do you put more value on:", answers: [
            Answer(text: "infinite", type: .J),
            Answer(text: "open-minded", type: .P)
            ]),
        //36
        Question(text:"Does new and non-routine interaction with others:", answers: [
            Answer(text: "stimulate and energize you", type: .E),
            Answer(text: "tax your reserves", type: .I)
            ]),
        //37
        Question(text:"Are you more frequently:", answers: [
            Answer(text: "a practical sort of person", type: .S),
            Answer(text: "a fanciful sort of person", type: .N)
            ]),
        //38
        Question(text:"Are you more likely to:", answers: [
            Answer(text: "see how others are useful", type: .S),
            Answer(text: "see how others see", type: .N)
            ]),
        //39
        Question(text:"Which is more satisfying:", answers: [
            Answer(text: "to discuss an issue thoroughly", type: .T),
            Answer(text: "to arrive at agreement on an issue", type: .F)
            ]),
        //40
        Question(text:"Which rules you more:", answers: [
            Answer(text: "your head", type: .T),
            Answer(text: "your heart", type: .F)
            ]),
    ]
        
      //function for defining "personality type"
        
        func definePersonalityType(responses: [Answer]!) -> PersonalityType  {
            
            var frequencyOfAnswers : [PersonalType:Int] = [:]
            let responseTypes = responses.map{$0.type}
            
            for response in responseTypes {
                
                frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0)+1
                
            }
        
            let e = (frequencyOfAnswers[PersonalType.E] ?? 0)
            let i = (frequencyOfAnswers[PersonalType.I] ?? 0)
            let s = (frequencyOfAnswers[PersonalType.S] ?? 0)
            let n = (frequencyOfAnswers[PersonalType.N] ?? 0)
            let t = (frequencyOfAnswers[PersonalType.T] ?? 0)
            let f = (frequencyOfAnswers[PersonalType.F] ?? 0)
            let j = (frequencyOfAnswers[PersonalType.J] ?? 0)
            let p = (frequencyOfAnswers[PersonalType.P] ?? 0)
        /*
            print("S =\(s)")
            print("I =\(i)")
            print("E =\(e)")
            print("N =\(n)")
            print("T =\(t)")
            print("F =\(f)")
            print("J =\(j)")
            print("P =\(p)")
          */
            
            if(i>=e && s>=n && t>=f && j>=p) {return PersonalityType.ISTJ}
            else if (i>=e && s>=n && t>=f && j<=p){return PersonalityType.ISTP}
            else if (i>=e && s>=n && t<=f && j>=p){return PersonalityType.ISFJ}
            else if (i>=e && s>=n && t<=f && j<=p){return PersonalityType.ISFP}
            else if (i>=e && s<=n && t>=f && j>=p){return PersonalityType.INTJ}
            else if (i>=e && s<=n && t>=f && j<=p){return PersonalityType.INTP}
            else if (i>=e && s<=n && t<=f && j>=p){return PersonalityType.INFJ}
            else if (i>=e && s<=n && t<=f && j<=p){return PersonalityType.INFP}
                
            else if (i<e && s>=n && t>=f && j>=p){return PersonalityType.ESTJ}
            else if (i<e && s>=n && t>=f && j<=p){return PersonalityType.ESTP}
            else if (i<e && s>=n && t<=f && j>=p){return PersonalityType.ESFJ}
            else if (i<e && s>=n && t<=f && j<=p){return PersonalityType.ESFP}
            else if (i<e && s<=n && t>=f && j>=p){return PersonalityType.ENTJ}
            else if (i<e && s<=n && t>=f && j<=p){return PersonalityType.ENTP}
            else if (i<e && s<=n && t<=f && j>=p){return PersonalityType.ENFJ}
                
            else {return PersonalityType.ENFP}
        }
}

