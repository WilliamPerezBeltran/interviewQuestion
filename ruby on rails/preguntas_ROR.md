# Ruby on Rails Interview Questions & Resources

A comprehensive list of resources, questions, and topics to prepare for Ruby on Rails interviews. Topics are categorized by levels and include links for further reading.

---

## 🔗 **Resources**

1. [Ruby and Rails Interview Questions and Answers by Anil Punjabi](https://anilpunjabi.tumblr.com/post/25948339235/ruby-and-rails-interview-questions-and-answers)
2. [CareerRide: Ruby on Rails Interview Questions](https://www.careerride.com/ruby-on-rails-interview-questions.aspx)
3. [MindMajix: Ruby on Rails Interview Questions](https://mindmajix.com/ruby-rails-interview-questions)
4. [GitHub: Awesome Interview Questions](https://github.com/DopplerHQ/awesome-interview-questions#ruby-on-rails)
5. [GitHub: Ruby Interview Questions](https://github.com/nick-brown/ruby-interview-questions)
6. [Developers.dev: Why Ruby on Rails is Great in 2021](https://www.developers.dev/tech-talk/es/web-development/what-makes-ruby-on-rails-great-in-2021.html)
7. [IT-Swarm: Ruby and Rails Must-Know Concepts](https://www.it-swarm-es.com/es/ruby-on-rails/que-ruby-y-rails-los-desarrolladores-deben-saber/968202129/)
8. [SunDevs: Key Questions for Ruby on Rails Developers](https://www.sundevs.com/es/blog/como-contratar-desarrolladores-ruby-on-rails-12-preguntas-clave-entrevista)

---

## 🧑‍💻 **Interview Topics**

### **Ruby-Specific Questions**
- **Basic Knowledge:**
  - What is a class? What are open classes?
  - Explain the difference between a class and a module.
  - What is `self` in Ruby?
  - Difference between `false` and `nil` in Ruby.
  - What are singleton methods and Eigenclass?

- **Intermediate Knowledge:**
  - What is a mixin, and how does it differ from a module?
  - Differences between a `Block`, a `Proc`, and a `Lambda`.
  - How does Ruby handle metaprogramming?

- **Advanced Knowledge:**
  - Analyze and profile applications for performance/memory issues.
  - Use metaprogramming effectively in real-world applications.

---

### **Rails-Specific Questions**
- **Core Framework:**
  - Explain the Asset Pipeline and its evolution in Rails versions.
  - What is the "Active Record" pattern?
  - Explain Polymorphic Associations.
  - Difference between optimistic and pessimistic locking in Rails.

- **Security:**
  - What is CSRF? How does Rails prevent it?
  - Why use HTTPS over HTTP?
  - Methods to securely store passwords.

- **Testing:**
  - Familiarity with RSpec, Capybara, FactoryBot, and Cucumber.
  - Write a basic unit test with RSpec.

- **Requests & Routing:**
  - Explain REST principles.
  - How does the Rails router map incoming requests to controllers?
  - Describe the Rack middleware stack in Rails.

---

## 🚀 **Practical Tasks**
- Build an API that manages tasks across three states: *Ideas*, *In Progress*, and *Completed*.
- Deliverables:
  - JWT-based authentication.
  - CRUD functionality for projects and tasks.
  - Deployment-ready on AWS.

---

## 🧩 **Common Scenarios**
1. **Debugging Code:**  
   Analyze given Rails code and identify issues.
   
2. **Code Review:**  
   Assess the structure, naming conventions, and testing coverage of a project.

3. **Problem-Solving:**  
   Implement solutions for common challenges like scaling applications or optimizing database queries.

---

## 🗂 **Preparation Tips by Levels**

### **Entry-Level**
- Create and configure a Rails application.
- Use generators to create models, controllers, and migrations.
- Handle basic GET/POST requests using controllers and views.
- Basic Git commands: clone, commit, push.

### **Mid-Level**
- Understand Rails callbacks, filters, and gem usage.
- Build associations using Active Record.
- Define scopes and abstract logic into modules.
- Write and execute RSpec tests.
- Familiarity with object-oriented programming and design patterns.

### **Senior-Level**
- Design scalable application architectures.
- Deep knowledge of Rails internals (engines, middleware).
- Optimize for security and performance.
- Mentoring team members and planning complex projects.

---

## 🔍 **Sample Technical Questions**

1. What is the result of the following code snippet?
   ```ruby
   a = 1
   b = 2
   a ||= b
