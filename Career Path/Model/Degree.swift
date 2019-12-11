//
//  EducationInfo.swift
//  CareerPath
//
//  Created by mikael on 18/11/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

// Degree model, includes degree info

enum Degree : String, CaseIterable {
    case Doctorate = "Doctor's degree"
    case Master = "Master's degree"
    case Bachelor = "Bachelor's degree"
    case Basic = "School leaving qualification"
    case Licentiate = "Licentiate (degree)"
    
    func description() -> String {
        switch self {
        case .Doctorate:
            return """
            A doctorate (from Latin docere, "to teach") or doctor's degree (from Latin doctor, "teacher") or doctoral degree, is an academic degree awarded by universities, derived from the ancient formalism licentia docendi ("licence to teach"). In most countries, it is a research degree that qualifies the holder to teach at university level in the degree's field, or to work in a specific profession. There are a number of doctoral degrees; the most common is the Doctor of Philosophy (PhD), which is awarded in many different fields, ranging from the humanities to scientific disciplines.
            
            In the United States and some other countries, there are also some types of technical or professional degrees that include doctor in their name and are, in some of those countries, classified as doctorates. Professional doctorates historically came about to meet the needs of practitioners in a variety of disciplines. However, the necessity of these degrees may vary greatly across disciplines, making their significance unclear.
            """
        case .Master:
            return "A master's degree (from Latin magister) is an academic degree awarded by universities or colleges upon completion of a course of study demonstrating mastery or a high-order overview of a specific field of study or area of professional practice. A master's degree normally requires previous study at the bachelor's level, either as a separate degree or as part of an integrated course. Within the area studied, master's graduates are expected to possess advanced knowledge of a specialized body of theoretical and applied topics; high order skills in analysis, critical evaluation, or professional application; and the ability to solve complex problems and think rigorously and independently."
        case .Bachelor:
            return "A bachelor's degree (from Middle Latin baccalaureus) or baccalaureate (from Modern Latin baccalaureatus) is an undergraduate academic degree awarded by colleges and universities upon completion of a course of study lasting three to seven years (depending on institution and academic discipline). In some institutions and educational systems, some bachelor's degrees can only be taken as graduate or postgraduate degrees after a first degree has been completed. In countries with qualifications frameworks, bachelor's degrees are normally one of the major levels in the framework (sometimes two levels where non-honours and honours bachelor's degrees are considered separately), although some qualifications titled bachelor's degrees may be at other levels (e.g., MBBS) and some qualifications with non-bachelor's titles may be classified as bachelor's degrees (e.g. the Scottish MA and Canadian MD)."
        case .Basic:
            return "A school leaving qualification is an academic qualification awarded for the completion of high school. Depending on the country or region, it may alternatively be known as a high school diploma, senior secondary leaving certificate, high school general certificate, school certificate, amongst other names."
        case .Licentiate:
            return "A licentiate is a degree below that of a PhD given by universities in some countries. The term is also used for a person who holds this degree. The term derives from Latin licentia, 'freedom' (from Latin licere, 'to allow'), which is applied in the phrases licentia docendi meaning permission to teach and licentia ad practicandum signifying someone who holds a certificate of competence to practise a profession. Many countries have degrees with this title, but they may represent different educational levels."
        }
    }
    
    func requiredDegree() -> Degree? {
        switch self {
        case .Bachelor:
            return .Basic
        case .Doctorate:
            return .Master
        case .Master:
            return .Bachelor
        case .Basic:
            return nil
        case .Licentiate:
            return .Bachelor
        }
    }
}
