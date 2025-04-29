#import "lib.typ" as lib

#let details = toml("data.toml")

#let work_exps = details.work_experience.jobs
#let personal = details.personal
#let projects = details.projects
#let educations = details.education.degrees
#let skills = details.skills
#let projects = details.projects.list

#show: lib.resume.with(
  author: personal.name,
  email: personal.email,
  github: personal.github,
  linkedin: personal.linkedin,
  phone: personal.phone,
  personal-site: personal.site,
  location: personal.location,
  accent-color: "#101e70",
  // accent-color: "#26429d",
  font: "New Computer Modern",
  // font: "Libertinus Serif",
  paper: "a4",
  author-position: left,
  personal-info-position: left,
)

== Work Experience
#for exp in work_exps [
  #lib.work(
    title: exp.title,
    company: exp.company,
    location: exp.location,
    dates: lib.dates-helper(start-date: exp.start_date, end-date: exp.end_date),
    body: (exp.points),
  )
]

== Projects
#for project in projects [
  #lib.project(
    name: project.name,
    role: project.role,
    dates: lib.dates-helper(start-date: project.start_date, end-date: project.end_date),
    demo-url: project.demo_url,
    code-url: project.code_url,
    body: project.points
  )
]

== Skills
*Programming Languages*: #skills.programming_languages.join(", ")\
*Frameworks*: #skills.frameworks.join(", ")\
*Tools*: #skills.tools.join(", ")\
// *Languages*: #skills.languages.join(", ")

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
  )
]