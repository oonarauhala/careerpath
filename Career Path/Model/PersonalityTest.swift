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
            Answer(text: "By careful selection and choice", type: .J),
            Answer(text: "Randomly and by chance", type: .P)
            ]),
        //28
        Question(text:"Do you feel better about:", answers: [
            Answer(text: "Having purchased", type: .J),
            Answer(text: "Having the option to buy", type: .P)
            ]),
        //29
        Question(text:"In company do you:", answers: [
            Answer(text: "Initiate conversation", type: .E),
            Answer(text: "Wait to be approached", type: .I)
            ]),
        //30
        Question(text:"Common sense is:", answers: [
            Answer(text: "Rarely questionable", type: .S),
            Answer(text: "Frequently questionable", type: .N)
            ]),
        //31
        Question(text:"Children often do not:", answers: [
            Answer(text: "Make themselves useful enough", type: .S),
            Answer(text: "Exercise their fantasy enough", type: .N)
            ]),
        //32
        Question(text:"In making decisions do you feel more comfortable with:", answers: [
            Answer(text: "Standards", type: .T),
            Answer(text: "Feelings", type: .F)
            ]),
        //33
        Question(text:"Are you more:", answers: [
            Answer(text: "Firm than gentle", type: .T),
            Answer(text: "Gentle than firm", type: .F)
            ]),
        //34
        Question(text:"Which is more admirable:", answers: [
            Answer(text: "The ability to organize and be methodical", type: .J),
            Answer(text: " The ability to adapt and make do", type: .P)
            ]),
        //35
        Question(text:"Do you put more value on:", answers: [
            Answer(text: "Infinite", type: .J),
            Answer(text: "Open-minded", type: .P)
            ]),
        //36
        Question(text:"Does new and non-routine interaction with others:", answers: [
            Answer(text: "Stimulate and energize you", type: .E),
            Answer(text: "Tax your reserves", type: .I)
            ]),
        //37
        Question(text:"Are you more frequently:", answers: [
            Answer(text: "A practical sort of person", type: .S),
            Answer(text: "A fanciful sort of person", type: .N)
            ]),
        //38
        Question(text:"Are you more likely to:", answers: [
            Answer(text: "See how others are useful", type: .S),
            Answer(text: "See how others see", type: .N)
            ]),
        //39
        Question(text:"Which is more satisfying:", answers: [
            Answer(text: "To discuss an issue thoroughly", type: .T),
            Answer(text: "To arrive at agreement on an issue", type: .F)
            ]),
        //40
        Question(text:"Which rules you more:", answers: [
            Answer(text: "Your head", type: .T),
            Answer(text: "Your heart", type: .F)
            ]),
    ]
        
      //function for defining "personality type"
        func definePersonalityType(responses: [Answer]!) -> PersonalityType  {
            
            var frequencyOfAnswers : [PersonalType:Int] = [:]
            let responseTypes = responses.map{$0.type}
            
            for response in responseTypes {
                
                frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
                
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
            
            var persType = ""
            
            if i>=e {persType += "I"} else {persType += "E"}
            if s>=n {persType += "S"} else {persType += "N"}
            if t>=f {persType += "T"} else {persType += "F"}
            if j>=p {persType += "J"} else {persType += "P"}
            
            print("PersType \(persType)")
            
            switch persType{
            case "ISTJ":
                return PersonalityType.ISTJ
            case "ISTP":
                return PersonalityType.ISTP
            case "ISFJ":
                return PersonalityType.ISFJ
            case "ISFP":
                return PersonalityType.ISFP
            case "INTJ":
                return PersonalityType.INTJ
            case "INTP":
                return PersonalityType.INTP
            case "INFJ":
                return PersonalityType.INFJ
            case "INFP":
                return PersonalityType.INFP
            case "ESTJ":
                return PersonalityType.ESTJ
            case "ESTP":
                return PersonalityType.ESTP
            case "ESFJ":
                return PersonalityType.ESFJ
            case "ESFP":
                return PersonalityType.ESFP
            case "ENTJ":
                return PersonalityType.ENTJ
            case "ENTP":
                return PersonalityType.ENTP
            case "ENFJ":
                return PersonalityType.ENFJ
            default:
                return PersonalityType.ENFP
            }
        }
}

