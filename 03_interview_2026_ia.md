Aquí tienes el Markdown completo de las preguntas y respuestas de esta sesión:

# Interview Questions & Answers

## 1. How did you integrate AI into the software development process? What limitations have you encountered?

I integrated AI into the software development process mainly as an engineering assistant, not as a replacement for developers. I used tools like Claude and OpenAI APIs, as well as coding assistants such as Claude Code and Cursor, for code generation, refactoring, test creation, documentation, debugging, and reviewing existing code. I also used LLMs to build features such as RAG pipelines and asynchronous AI workflows with Celery and Redis.

The main limitations I encountered are that AI can generate code that looks correct but has subtle bugs, misunderstand business requirements, or make incorrect assumptions about an existing architecture. There are also concerns around security, data privacy, hallucinations, and consistency. So I always validate the output through tests, code review, static analysis, and running it against the actual system requirements.

The key for me is to use AI to accelerate development while keeping the developer responsible for the final technical decisions.


## 2. What's was your best software project? Describe the business case and its high-level architecture.

One of my best projects was a high-throughput backend platform in the healthcare and fintech space, where the main business need was to process and expose large volumes of data reliably while maintaining strong security and scalability.

At a high level, I worked with a microservices-oriented architecture. We had Python services using FastAPI and Django, PostgreSQL as the main relational database, Redis for caching and asynchronous workloads, and Kafka for event-driven communication between services. Background processing was handled with Celery, and the infrastructure was containerized with Docker and deployed on Kubernetes in AWS.

The architecture allowed us to scale individual services independently and decouple long-running or resource-intensive operations from the main request-response flow. We also implemented automated testing and CI/CD to make deployments safer and more predictable.

What made the project particularly valuable was that it wasn't just about building features. We had to balance business requirements with scalability, reliability, security, and maintainability, and I was involved in those architectural decisions as well as the implementation.


## 3. Describe how you would design and operate a customer-facing onboarding flow in React that integrates multiple KYC providers, including how you would handle provider failures, retries, inconsistent responses, and a seamless user experience.

I would keep React focused on the user experience and handle the KYC providers through a backend orchestration layer. Each provider would have its own adapter, so we can normalize different responses into a common internal model.

For transient failures, like timeouts or 5xx errors, I’d use retries with exponential backoff and idempotency keys. For permanent failures, like invalid documents, I’d give the user clear feedback without retrying unnecessarily. If a provider is unavailable, I’d use a fallback provider when possible.

On the frontend, I’d maintain a clear onboarding state and preserve the user’s progress, so they don’t have to restart the entire process. Finally, I’d use logging, metrics, and tracing to monitor provider performance and quickly detect failures.
