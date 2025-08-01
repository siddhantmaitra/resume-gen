
#let resume(
  author: "",
  header-position: left,
  pronouns: "",
  location: "",
  email: "",
  github: "",
  linkedin: "",
  phone: "",
  personal-site: "",
  orcid: "",
  accent-color: "#000000",
  font: "New Computer Modern",
  paper: "us-letter",
  body,
  footer: "",
  font-size: 11pt,
  name-size: 22pt,
  contacts-size: 12pt,
) = {
  // Sets document metadata
  set document(author: author, title: "Resume - " + author)

  // Document-wide formatting, including font and margins
  set text(
    font: font,
    size: font-size,
    lang: "en",
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false,
  )

  // Recommended to have 0.5in margin on all sides. Added the "rest" param to try fitting content in 1 page if needed
  set page(
    margin: (top: 0.5in, rest: 0.5in),
    paper: paper,
    footer: [
      #if footer != "" {
        set align(right)
        set text(8pt)
        footer
      }
    ],
  )
  // Link styles
  show link: underline


  // Small caps for section titles. Size is relative to base font size
  show heading.where(level: 2): it => [
    #set text(font-size + 2pt)
    #pad(top:-5pt, bottom: -12pt, [#smallcaps(it.body)])
    #line(length: 100%, stroke: (paint:gray ,thickness: 1pt))
  ]

  // Accent Color Styling
  show heading: set text(fill: rgb(accent-color))

  show link: set text(fill: rgb(accent-color))

  // Name will be aligned left, bold and big
  show heading.where(level: 1): it => [
    #set align(header-position)
    #set text(
      weight: 600,
      size: name-size,
    )
    #pad(it.body)
  ]

  // Level 1 Heading
  [= #(author)]


  // Personal Info Helper
  let contact-item(value, link-type: "", link-text: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#{
            if link-text != "" {
              link-text
            } else {
              value
            }
          }]
      } else {
        value
      }
    }
  }

  // Personal Info
  pad(
    top: 0.01em,
    align(header-position)[
      #set text(size: contacts-size)
      #{
        let items = (
          contact-item(pronouns),
          contact-item(location),
          contact-item(phone),
          contact-item(email, link-type: "mailto:"),
          contact-item(personal-site, link-type: "https://"),
          contact-item(github, link-type: "https://", link-text: "GitHub"),
          contact-item(linkedin, link-type: "https://", link-text: "Linkedin"),
        )
        items.filter(x => x != none).join(" | ")
      }
    ],
  )

  // Main body.
  set par(justify: true)

  body
}

// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

// Cannot just use normal --- ligature becuase ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.em$ + " " + end-date
}

// Section components below
#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  // Makes dates on upper right like rest of components
  consistent: false,
  font-size: 12pt,
) = {
  set text(font-size)
  let eduData = (top-left: "", top-right: "", bottom-left: "", bottom-right: "")

  eduData.top-left = strong(institution)

  eduData.bottom-left = if gpa !="" {
    emph(degree) + (" GPA: " + strong(gpa))
  } else {
    degree
  }

  if consistent {
    // edu-constant style (dates top-right, location bottom-right)
    eduData.top-right = dates
    // eduData.bottom-right =  if(italics){emph(location)}else{location}
    eduData.bottom-right = emph(location)
  } else {
    // original edu style (location top-right, dates bottom-right)
    // eduData.top-right =  if(italics){emph(location)}else{location}
    eduData.top-right = emph(location)
    eduData.bottom-right = dates
  }
  generic-two-by-two(
    top-left: eduData.top-left,
    top-right: eduData.top-right,
    bottom-left: eduData.bottom-left,
    bottom-right: eduData.bottom-right,
  )
}

#let work(title: "", company: "", location: "", dates: "", body: [],font-size: 10pt) = {
  set text(font-size)
  generic-two-by-two(
    top-left: strong(title),
    top-right: dates,
    bottom-left: (company),
    bottom-right: emph(location),
  )
  v(0.1em)
  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.2em,spacing: 0.8em)
    for item in body [
      - #eval(item,mode: "markup")
    ]
  }
}


#let project(
  role: "",
  name: "",
  code-url: "",
  demo-url: "",
  tech-stack: [],
  body: [],
  font-size: 10pt
) = {
  set text(font-size)
  let project-header = if role == "" { [*#name*] } else { [*#role*, #name] }
  let right
  if code-url != "" {
    // project-header = project-header + [ [#link(code-url)[Code]]]
    right = right + [ [#link(code-url)[Code]]]
  }
  if demo-url != "" {
    // project-header = project-header + [ [#link(demo-url)[Demo]]]
    right = right + [ | [#link(demo-url)[Demo]]]
  }
  generic-one-by-two(left: { project-header }, right: {right })

  v(-0.2em)
  if body != [] {
    v(-0.4em)
    set par(leading: 0.6em)
    set list(indent: 0.2em)
    for item in body [
       - #eval(item,mode: "markup")
    ]
      [- Tech Used: _#tech-stack.join(", ")_]
  }
}
