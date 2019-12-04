//
//  PersonalityType.swift
//  CareerPath
//
//  Created by mikael on 19/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

enum PersonalityType : String {
    case
    ISTJ = "ISTJ: Introverted, Sensing, Thinking, Judging",
    ISFJ = "ISFJ: Introverted, Sensing, Feeling, Judging",
    INFJ = "INFJ: Introverted, Intuitive, Feeling, Judging",
    INTJ = "INTJ: Introverted, Intuitive, Thinking Judging",
    ISTP = "ISTP: Introverted, Sensing, Thinking, Perceiving",
    ISFP = "ISFP: Introverted, Sensing, Feeling, Perceiving",
    INFP = "INFP: Introverted, Intuitive, Feeling, Perceiving",
    INTP = "INTP: Introverted, Intuitive, Thinking, Perceiving",
    ESTP = "ESTP: Extraverted, Sensing, Thinking, Perceiving",
    ESFP = "ESFP: Extraverted, Sensing, Feeling, Perceiving",
    ENFP = "ENFP: Extraverted, Intuitive, Feeling, Perceiving",
    ENTP = "ENTP: Extraverted, Intuitive, Thinking, Perceiving",
    ESTJ = "ESTJ: Extraverted, Sensing, Thinking, Judging",
    ESFJ = "ESFJ: Extraverted, Sensing, Feeling, Judging",
    ENFJ = "ENFJ: Extraverted, Intuitive, Feeling, Judging",
    ENTJ = "ENTJ: Extraverted, Intuitive, Thinking, Judging"
    
    var description : String {
        switch self {
        case .ISTJ:
            return "The ISTJ personality type is generally practical and responsible. They rely on logical decision-making, accomplishing tasks in an orderly and organized fashion. ISTJ’s typically enjoy a neat and organized space, both at home and at work. ISTJs highly value traditions, loyalty and order, making it sometimes difficult for them to be flexible during times of change."
        case .ISFJ:
            return "Conventional and grounded, ISFJs respect and strive to uphold established structures and create and maintain orderly environments. They have a strong work ethic that includes serving others and are dedicated to their duties. ISFJs are conscientious and methodical workers who are not satisfied until the job is done."
        case .INFJ:
            return "This is the most rare of the 16 personalities. The INFJ type is highly insightful about people’s needs, motivations and concerns. INFJs often find value in relationships with others. While often artistic, creative and complex, INFJs are also deeply caring and gentle. Often referred to as an advocate, INFJs often find meaning in work that directly helps others."
        case .INTJ:
            return "The INTJ type is guided by reason and logic. They are driven by gaining and using knowledge. They are highly confident and seek to reform and improve the world around them. While self-confident, INTJs can be uncomfortable in large groups or among people they don’t know well. They prefer to discuss ideas and facts rather than engage in superficial small talk."
        case .ISTP:
            return "The ISTP personality type is typically quiet and observant. When a problem arises, they are tolerant, flexible and quick to find a solution. Organized and practical, the ISTP values data, logic and facts to understand issues. ISTPs often find meaningful work making and creating things, finding ways to make things work and learning along the way."
        case .ISFP:
            return "The ISFP personality type is usually friendly and quiet. They enjoy observing and taking in the environment around them. ISFP typically prefer autonomy, working in their own space and completing tasks on their own schedule. ISFPs highly value loyalty and commitment in their personal relationships. Harmony is also important to ISFPs, avoiding confrontation and keeping their opinions to themselves."
        case .INFP:
            return "Because INFPs are highly curious, inquisitive and innovative individuals, they are usually optimistic in their world view and can be an inspiring team member. INFPs comprise just 2% of the population. They are highly creative, easily find connections in hidden patterns and enjoy abstract thinking."
        case .INTP:
            return "The INTP personality type tends to be quiet and contained. They enjoy abstract ideas, and deep thought about theories over interaction with others. INTPs desire logical answers to questions or problems that arise in their environment. Often skeptical and analytical, INTPs are great problem-solvers, helpful when certain business issues present themselves. They are often highly creative, intelligent and attentive."
        case .ESTP:
            return "The ESTP personality type is often referred to as entrepreneurial. They are energetic, pragmatic and flexible. They eagerly search for fast results, often taking risks to come up with the best solutions. ESTPs often do before they think, fixing and adapting their processes as they go. ESTPs enjoy a fast-paced lifestyle by living “in the moment” and spending time around groups of people."
        case .ESFP:
            return "Often seen as the entertainer, the ESFP personality type is outgoing, friendly and generous. They enjoy spending time around others, spreading excitement and joy both at home and at work. While practical and realistic in their work, they also value having fun achieving their goals. They are energetic and flexible, encouraging others along the way."
        case .ENFP:
            return "The ENFP personality type can be powerful in many workplaces. The ENFP type is generally innovative, inspiring and often unafraid of taking risks. ENFPs make up approximately 8% of the general population and includes more women than men. They are highly perceptive when understanding how individuals and groups function, making them natural leaders inside organizations. ENFPs seek excitement, enjoy abstract and experiential learning, and seek maximum potential in their career experiences and in others."
        case .ENTP:
             return "The ENTP personality is ideal for entrepreneurial thinking, whether ENTPs choose to own their own business or innovate within an organization. ENTPs often struggle to meet deadlines and find it difficult to work within hierarchies, which can restrict their innovative talents. ENTPs prefer to focus on the “big idea” and resist routine and repetitive tasks. Instead, they prefer highly conceptual work, problem-solving and leaving details to others."
        case .ESTJ:
            return "ESTJs make great executives, valuing tradition and order. Strong character traits are important to ESTJs who respect honesty and dedication both in themselves and others. ESTJs are practical decision-makers, looking for ways to quickly and effectively see results. Organized and logical, ESTJs are good at both creating and implementing plans. They do not shy away from difficult plans or decisions and work to bring other together toward a common purpose."
        case .ESFJ:
            return "ESFJs are serious and practical, committed to their responsibilities, and sensitive to the needs of others. They strive for harmony and are generous with their time, efforts, and emotions, and are eager to please—both at work and at home. ESFJs value loyalty and tradition and hold to a strict moral code. They typically enjoy their routines and maintain a regular schedule that allows them to stay organized and productive."
        case .ENFJ:
            return "The ENFJ personality type are often charismatic, empathetic leaders. They are highly intuitive when it comes to other’s emotions, needs and motivations. ENFJs are often loyal and responsible, looking for ways to improve their team by leading with inspiration and responsiveness. ENFJs often look for opportunities where they can make the world better and can bring people together to make a difference."
        case .ENTJ:
            return "Often referred to as “the commander,” ENTJs are natural leaders. The ENTJ personality type is often honest, ready to make quick decisions. They are quick to spot inefficiencies and develop ways to solve problems. ENTJs highly value goal-setting, organization and planning. They are charismatic and confident which helps them to rally a group behind a common goal. They sometimes tend to be seen as harsh by those around them, using their drive and rational thinking achieve goals by whatever means necessary."
        }
        
    }
    func convertToInt() -> Int {
        switch self {
        case .ISTJ:
            return 0
        case .ISFJ:
            return 1
        case .INFJ:
            return 2
        case .INTJ:
            return 3
        case .ISTP:
            return 4
        case .ISFP:
            return 5
        case .INFP:
            return 6
        case .INTP:
            return 7
        case .ESTP:
            return 8
        case .ESFP:
            return 9
        case .ENFP:
            return 10
        case .ENTP:
            return 11
        case .ESTJ:
            return 12
        case .ESFJ:
            return 13
        case .ENFJ:
            return 14
        case .ENTJ:
            return 15
    }
}
}
