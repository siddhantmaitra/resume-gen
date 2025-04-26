#import "lib.typ" as lib

#let details = toml("data.toml")

#let work_exps = details.work_experience.jobs
#let personal = details.personal
#let projects = details.projects

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

== Education

#lib.edu(
  institution: "Harvey Mudd College",
  location: "Claremont, CA",
  gpa: "9.33/10 GPA",
  dates: lib.dates-helper(start-date: "Aug 2023", end-date: "May 2027"),
  degree: "Bachelor's of Technology, Computer Science and Engineering",
  // consistent: true
)

== Work Experience
#for exp in work_exps [
#lib.work(
  title:exp.title,
  company:exp.company,
  location:exp.location,
  dates:lib.dates-helper(start-date: exp.start_date, end-date: exp.end_date),
  body:(exp.points)
)
]
