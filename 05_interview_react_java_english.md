Interview Questions & Answers

1. Tell me about yourself

Question:
Let's start with your quick self-introduction.

Answer:

«Sure. My name is William Pérez. I’m a Senior Software Engineer with over 10 years of experience building and maintaining production systems.

My main expertise is in Python, FastAPI, Django, and backend architecture, with additional experience in Java, Spring Boot, Ruby, and TypeScript. I’ve worked with cloud platforms, Kubernetes, Docker, PostgreSQL, Redis, and CI/CD.

More recently, I’ve been working with AI and LLM integrations, including OpenAI and Anthropic APIs. I focus on building scalable, maintainable systems and also enjoy mentoring other developers and contributing to technical decisions.»

---

2. Angular vs React

Question:
If you want to pick a framework, for example Angular versus React, what are the key points you would check when choosing one for a project?

Answer:

«I would consider several factors. First, the project requirements and complexity. Angular provides a more complete and opinionated structure, while React is more flexible and lightweight.

I would also look at the team's existing expertise, ecosystem and available libraries, long-term maintainability, performance requirements, testing, and scalability.

For a large enterprise application with a standardized structure, I might choose Angular. For a flexible application where we want more freedom in architecture and libraries, I would probably choose React.»

---

3. React vs Angular rendering

Question:
Can you explain the difference in rendering mechanisms between React and Angular?

Answer:

«Yes. The main difference is how they detect changes and update the DOM.

In React, when state or props change, React re-renders the component and uses its Virtual DOM reconciliation process to determine what actually needs to change in the real DOM. Modern React also uses the Fiber architecture to schedule and prioritize rendering work.

In Angular, the traditional approach uses change detection to check component bindings and update the DOM when values change. Modern Angular also supports signals, which provide more granular, reactive updates.

So, in simple terms: React is primarily based on reconciliation and Virtual DOM updates, while Angular uses a more integrated change-detection and reactive system.»

---

4. React component hierarchy

Question:
Let's say we have three components: A, B, and C. A is the parent of B, and B is the parent of C. Do you understand the hierarchy?

Answer:

«Yes. The component tree is:

A → B → C

A is the root parent, B is the child of A, and C is the child of B.»

---

5. What happens when B's data changes?

Question:
If some data changes in B, what are the scenarios that can affect A and C rendering?

Answer:

«If the state changes locally inside B, React normally re-renders B and its children, so C can also re-render. The parent A does not re-render just because B's state changed.

There are a few scenarios:

1. B's local state changes: B and C may render again; A does not.
2. B receives new props from A: A must render first, which can cause B and C to render.
3. B changes data passed to C: C re-renders because its props changed.
4. C is memoized with "React.memo": C can skip rendering if its props remain unchanged.

The key point is that rendering generally flows from the component that updates down through its descendants, not upward to the parent.»

---

6. React performance issues

Question:
If you see performance issues in React, where could the problem be?

Answer:

«I would first measure the problem rather than immediately optimizing. I’d use tools like React DevTools Profiler and browser performance tools to identify unnecessary renders and expensive operations.

Common causes are unnecessary component re-renders, large component trees, expensive calculations during rendering, inefficient state management, large lists, excessive API calls, and unnecessary network requests.

Then I would optimize based on the bottleneck—for example, using "React.memo", "useMemo", "useCallback", list virtualization, better state placement, lazy loading, and caching where appropriate.

The key is to profile first, identify the bottleneck, and then optimize the specific problem.»

---

7. State management in React

Question:
How do you generally manage the state of your application?

Answer:

«It depends on the complexity of the application.

For local UI state, I would use React's "useState" or "useReducer". For shared state across multiple components, I might use Context or a dedicated state-management library like Redux or Zustand.

For server state, I prefer tools such as React Query because they handle caching, synchronization, loading states, and refetching.

The main principle is to keep state as local as possible and only make it global when multiple parts of the application actually need it.»

---

8. Strongest backend technology

Question:
What is your strongest technology skill in backend?

Answer:

«My strongest backend skill is Python, particularly with FastAPI and Django. I’m very comfortable designing scalable REST APIs, working with PostgreSQL, asynchronous processing with Celery and Redis, and building production-ready backend services.

I also have strong experience with microservices, cloud infrastructure, Kubernetes, and CI/CD, so I can work across the full backend lifecycle.»

---

9. Java vs Python

Question:
How would you compare Java with Python?

Answer:

«I would say both are strong backend technologies, but they have different strengths.

Java is strongly typed and generally provides better structure for large enterprise applications, with a mature ecosystem around Spring Boot, concurrency, and JVM performance.

Python is more concise and flexible, which usually allows faster development. It has an excellent ecosystem for APIs, automation, data processing, and AI.

For large enterprise systems, I would often consider Java and Spring Boot. For rapid development, APIs, and AI-related services, Python is usually my first choice.»

---

10. Concurrency in Java

Question:
How do you manage concurrency in Java?

Answer:

«In Java, I typically manage concurrency using threads, executors, and thread pools from the "java.util.concurrent" package.

Instead of creating threads manually, I would use an "ExecutorService" to manage a pool of worker threads. For shared data, I use mechanisms such as "synchronized", locks, or concurrent collections to avoid race conditions.

For asynchronous workflows, Java also provides "CompletableFuture", which allows tasks to run concurrently and compose their results.

The main approach is to control thread creation through executors and protect shared state with proper synchronization mechanisms.»

---

11. How do you avoid race conditions?

Question:
How do you avoid a race condition?

Answer:

«I avoid race conditions by controlling access to shared mutable state.

In Java, I can use "synchronized" blocks or methods, locks such as "ReentrantLock", and thread-safe collections like "ConcurrentHashMap".

When possible, I also prefer immutable objects and minimizing shared state, because that reduces the need for synchronization.

The key is to ensure that operations that must be atomic cannot be executed concurrently in an unsafe way.»

---

12. Does synchronization reduce concurrency?

Question:
If you use synchronization, aren't you defeating concurrency?

Answer:

«Not necessarily. Synchronizing a specific critical section does not eliminate concurrency; it only prevents multiple threads from modifying the same shared resource at the same time.

The rest of the application can still execute concurrently across multiple threads. Java also provides thread pools, non-blocking APIs, "CompletableFuture", concurrent collections, and atomic operations.

So the goal is not to eliminate concurrency, but to limit synchronization to the smallest critical sections necessary while allowing independent work to run in parallel.»

---

13. What is synchronization?

Question:
What is synchronization?

Answer:

«Synchronization is a mechanism used to control access to shared resources when multiple threads are running concurrently.

For example, if two threads try to modify the same variable at the same time, synchronization ensures that only one thread executes the critical section at a time, preventing race conditions and inconsistent data.

In Java, this can be implemented with "synchronized", locks, or atomic classes.»

---

14. Washroom analogy for synchronization

Question:
There is a single washroom and multiple people trying to use it. The entry to the washroom represents synchronization, right?

Answer:

«Yes, exactly. The washroom is the shared resource, and the lock on the door represents synchronization. Only one person can access it at a time, while everyone else waits.

In Java, the idea is similar: multiple threads can run concurrently, but when they need to access a synchronized critical section, only one thread can enter at a time.»

---

15. When do you use synchronization?

Question:
In what cases would you use synchronization?

Answer:

«Synchronization is used when multiple threads access a shared mutable resource and we need to guarantee consistency.

For example, if multiple threads update the same bank account balance, synchronization ensures that the operations don't interfere with each other and cause a race condition.

I would use it carefully, because excessive synchronization can reduce concurrency and impact performance.»

---

16. QueryDSL and Spring Cache

Question:
You mentioned implementing QueryDSL using Spring Cache and improving performance by 55 milliseconds. Can you give me the design of this solution?

Answer:

«Sure. The idea was to combine QueryDSL for dynamic and type-safe queries with Spring Cache to avoid executing the same expensive queries repeatedly.

The flow was basically:

Request → Service → Cache check → QueryDSL repository → Database

For frequently requested data, I used a cache key based on the relevant query parameters. If the data was already cached, we returned it directly without hitting the database. Otherwise, we executed the QueryDSL query, stored the result in the cache, and returned it.

I also configured an appropriate TTL and cache eviction strategy to avoid serving stale data.

The performance improvement came mainly from eliminating repeated database queries for frequently accessed data and optimizing the query itself. The result was around 55 milliseconds faster for the affected operations.»

---

17. Cache consistency with multiple applications

Question:
If multiple applications update the same bank account, how does your application know that the account balance has changed when the old value is already in the cache?

Answer:

«That's a cache consistency problem. I would not rely on the cache as the source of truth; the database remains authoritative.

For data that can be updated by multiple applications, I would use a cache invalidation or synchronization strategy. For example, when an account is updated, the application can publish an event through Kafka or another messaging system, and consumers invalidate or update the corresponding cache entry.

For highly sensitive data like a bank balance, I would also consider using short TTLs or avoiding caching the balance altogether, depending on the consistency requirements.

So the important point is: cache for performance, database for correctness, and an invalidation/event strategy to keep the cache consistent.»

---

18. Multiple applications with only Hibernate/Spring Data

Question:
Using only Hibernate or Spring Data, with the same bank account being updated by multiple applications, how do you manage consistency and latency?

Answer:

«If we are limited to Hibernate and Spring Data JPA, I would rely on database transactions and optimistic locking.

For example, I would add a "@Version" field to the "Account" entity. When Hibernate updates the account, it includes the version in the "WHERE" clause.

If another application has already updated the same account, the version no longer matches, and Hibernate throws an "OptimisticLockException". We can then retry the transaction or return a conflict.

For latency, I would prefer optimistic locking because it doesn't hold database locks while applications are reading and processing the data. It provides concurrency while still protecting the account from lost updates.»

---

19. Optimistic locking and performance

Question:
From a performance perspective, why would you prefer optimistic locking?

Answer:

«From a performance perspective, optimistic locking is usually better when contention is relatively low because it allows concurrent reads and avoids holding database locks.

The trade-off is that when many applications update the same record simultaneously, conflicts can increase and cause retries.

In that case, I would evaluate whether optimistic or pessimistic locking is more appropriate based on the workload.»

---

20. Prompt engineering and AI

Question / Discussion:
You're talking about prompting for every query. Isn't prompting just the first thing you can do?

Answer:

«Yes, I agree. Prompting is important, but it is only one part of the solution. A good prompt can improve the model's output, but for a production AI system I would also consider model selection, context management, RAG, evaluation, latency, cost, and reliability.

So I would not rely only on prompt engineering; I would look at the entire LLM architecture.»

---

21. AI training and OpenAI tokens

Question / Discussion:
You will receive minimum training on how to use AI and the OpenAI tokens provided as part of the induction.

Answer:

«Understood. That makes sense. I’m comfortable working with OpenAI APIs and LLM-based systems, so I should be able to adapt quickly to the specific guidelines, token limits, and AI tools provided during the induction.»

---

Quick Technical Summary

SOLID

- S — Single Responsibility: One class should have one responsibility.
- O — Open/Closed: Open for extension, closed for modification.
- L — Liskov Substitution: Subtypes should be replaceable for their base types.
- I — Interface Segregation: Prefer small, specific interfaces.
- D — Dependency Inversion: Depend on abstractions, not concrete implementations.

React

- Virtual DOM + reconciliation
- Fiber architecture
- State/props trigger rendering
- Rendering generally flows downward
- "React.memo" can prevent unnecessary child renders
- Profile before optimizing

Java Concurrency

- "ExecutorService"
- Thread pools
- "CompletableFuture"
- "synchronized"
- "ReentrantLock"
- "Atomic" classes
- Concurrent collections
- Immutable objects
- Minimize shared mutable state

Hibernate / Spring Data

- Transactions
- Optimistic locking
- "@Version"
- "OptimisticLockException"
- Pessimistic locking when contention requires it
- Database remains the source of truth

AI / LLM

- Prompt engineering
- RAG
- Context management
- Model selection
- Evaluation
- Latency
- Cost
- Reliability
- OpenAI / Anthropic APIs
