# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is a personal knowledge base of interview preparation notes, not a software application. It contains a
collection of Markdown/text notes, saved web pages, screenshots, and small standalone code snippets covering
**JavaScript**, **React**/**React Native**, **Ruby**, **Ruby on Rails**, **Python**, OOP theory, math-for-programming
topics, and HR/soft-skills interview prep (in Spanish). There is no build system, package manifest, test suite, or
application entry point — do not assume one exists or try to add one unless the user explicitly asks for it.

## Repository layout

- `EPAM-javascript/`, `javascript/`, `react/` — JS/React/React Native notes and screenshots.
- `ruby/`, `ruby on rails/` — Ruby and Rails interview notes, several per-company subfolders (e.g.
  `ruby/buk`, `ruby/unosquare_2025`), and saved reference pages under `z_important_ruby/`.
- `poo/`, `poo.md` — Object-oriented programming theory notes (Ruby-flavored).
- `python/` — Python interview notes.
- `math/` — Math-for-programming notes.
- `rrhh/` — HR/behavioral interview notes (Spanish).
- `tecnical_tests_companies/` — Take-home/technical challenges from specific companies (e.g. TORC, VAIRIX), each
  typically self-contained with its own `README.md`, `Gemfile`, input files, and small Ruby scripts.
- `preguntas_por_temas/` — Notes organized by topic rather than by company.
- Root-level files (`sophilabs.md`, `ruby-on-rails-y-react.md`, `ruby_on_rails.txt`, `poo.md`, etc.) are large
  standalone study documents, often aggregating Q&A for a specific company or topic.
- `urls.txt` + `open_url_at_once.sh` (root and duplicated under `react/`): a list of reference URLs and a script
  that opens every URL in it via `xdg-open` — run as `./open_url_at_once.sh` from the directory containing the
  matching `urls.txt`.

## Working conventions

- Most content is written in **Spanish**; keep additions consistent with the surrounding file's language rather
  than defaulting to English.
- Notes are predominantly Markdown (`.md`) or plain text (`.txt`); some are raw saved HTML pages
  (do not attempt to "fix" or reformat saved HTML snapshots — they're archival).
- Filenames often encode the topic/question directly (e.g. `10. Que es "num " como modulo en ruby...md`) — follow
  this numbered, descriptive naming pattern when adding new question files to a directory that already uses it.
- Code snippets embedded in notes or under `tecnical_tests_companies/` are illustrative/interview-style solutions,
  not part of a larger running application — treat each as self-contained rather than looking for shared modules,
  configs, or a central entry point across the repo.
- There are duplicate/near-duplicate files in places (e.g. `interview_questions.txt` and
  `interview_questions (copy).txt`, `preguntas_ROR.md` and `preguntas_ROR.txt`). When editing, check whether a
  "(copy)" or alternate-extension sibling exists and needs the same update, or confirm with the user before
  consolidating them.

## Communication style

- When answering interview questions from this repo's content out loud in chat (Python, Django, Ruby, JS, etc.),
  respond in first person, spoken-interview style — short, direct, conversational — not documentation style with
  headers and bullet walls. State the question being answered right before the answer.
- Use **neutral Spanish** in all Spanish responses — no Argentine voseo ("vos", "tenés", "acá", etc.) or other
  regionalisms. Use "tú" or impersonal/infinitive phrasing instead.
