# Entrevista — React, Next.js, Node.js y APIs

## 1. What are the key differences between Next and React?

*Answer:*

Next.js is a framework built on top of React. React mainly provides the UI layer and component model, while Next.js provides a complete application framework around it.

The key differences are that Next.js includes things like file-based routing, server-side rendering, static generation, API routes, middleware, and built-in optimization for things like images and performance.

With React alone, I would typically need additional libraries for routing, data fetching, and application structure. So, in practice, I use React when I need flexibility for the frontend layer, and Next.js when I want a more complete solution for building production web applications.

---

## 2. Explain the Node.js event loop. How does Node handle multiple concurrent requests despite being single-threaded?

*Answer:*

Node.js uses an event loop to handle concurrency without creating a thread for every request.

The main JavaScript execution runs on a single thread. When Node receives an I/O operation, such as a database query, file operation, or network request, it delegates that work to the operating system or to its underlying thread pool. While that operation is running, the event loop can continue processing other requests.

When the operation finishes, its callback or promise is placed in the appropriate event-loop queue, and Node executes it when the call stack is available.

So, the key idea is that Node is single-threaded for JavaScript execution, but it achieves high concurrency through *non-blocking I/O and the event loop*, rather than using a separate JavaScript thread for every request.

---

## 3. What's happened during the React rendering and reconciliation process?

*Answer:*

During React rendering, when state or props change, React creates a new virtual representation of the UI by calling the relevant components.

Then React performs *reconciliation*, where it compares the new virtual DOM tree with the previous one. It identifies the minimum set of changes needed.

After that, React commits those changes to the real DOM. This is when the browser DOM is actually updated, and then effects such as useEffect run when appropriate.

So, in simple terms:

*Render → Compare/Reconcile → Commit DOM changes → Run effects*

---

## 4. What are the key differences between REST and GraphQL, and when would you choose one over the other?

*Answer:*

The main difference is how the client retrieves data.

With REST, you have multiple endpoints representing resources, and the server defines the response structure. With GraphQL, you typically have a single endpoint, and the client specifies exactly which fields and relationships it needs.

I would choose REST when the API is relatively simple, caching and HTTP semantics are important, or I want a straightforward and well-understood architecture.

I would choose GraphQL when the frontend needs flexible queries, especially when there are complex relationships or different clients need different data shapes.

In practice, I also consider team expertise, performance, caching strategy, and the complexity of the domain before choosing between them.

---

## 5. How does file-based routing work in Next.js?

*Answer:*

In Next.js, file-based routing means that the folder and file structure defines the application's routes.

For example, in the App Router, if I create:

app/users/page.tsx

that becomes the /users route.

A dynamic route like:

app/users/[id]/page.tsx

maps to /users/:id.

Next.js also supports nested routes through folders, layouts, loading states, and error boundaries.

The main advantage is that routing is convention-based, so I don't need to manually configure every route with a routing library. This makes larger applications easier to organize and maintain.