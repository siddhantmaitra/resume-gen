#import "lib.typ" as lib

#let details = toml("../data/sample.data.toml")

#let work_exps = details.work_experience.jobs
#let personal = details.personal
#let projects = details.projects
#let educations = details.education.degrees
#let skills = details.skills
#let projects = details.projects.list
#let base_font_size = 11pt

#let footer = [Generated on: #datetime.today().display()]

#show: lib.resume.with(
  author: personal.name,
  email: personal.email,
  github: personal.github,
  linkedin: personal.linkedin,
  phone: personal.phone,
  personal-site: personal.site,
  location: personal.location,
  // accent-color: "#101e70",
  accent-color: "#26429d",
  font: "IBM Plex Serif",
  header-position: center,
  name-size: 24pt,
  contacts-size: base_font_size + 1pt,
  font-size: base_font_size,
  paper: "a4",
  // footer: footer,
)

== Work Experience
#for exp in work_exps [
  #lib.work(
    title: exp.title,
    company: exp.company,
    location: exp.location,
    dates: lib.dates-helper(start-date: exp.start_date, end-date: exp.end_date),
    body: (exp.points),
    font-size: base_font_size - 1pt,
  )
]

== Projects
#for project in projects [
  #lib.project(
    name: project.name,
    role: project.role,
    tech-stack: project.tech_stack,
    demo-url: project.demo_url,
    code-url: project.code_url,
    body: project.points,
    font-size: base_font_size - 0.5pt,
  )
]

== Skills
#{
  set text(base_font_size)
  [
    *Programming Languages*: #skills.programming_languages.join(", ")\
    *Frontend*: #skills.frontend.join(", ")\
    *Backend*: #skills.backend.join(", ")\
    *Tools*: #skills.tools.join(", ")\
    *Platforms*: #skills.platforms.join(", ")
  ]
}


== Education
#for degree in educations [
  #lib.edu(
    institution: degree.institution,
    location: degree.location,
    gpa: degree.gpa,
    dates: lib.dates-helper(
      start-date: degree.start_date,
      end-date: degree.end_date,
    ),
    degree: degree.degree,
    consistent: true,
    emphDegree: false,
    font-size: base_font_size - 0.5pt,
  )
]
