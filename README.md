[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Build status](https://github.com/andrewfitzy/2025-advent-of-code/actions/workflows/build-and-test-project.yml/badge.svg)

# 2025-advent-of-code
Repository for the Advent of Code 2025 challenges

Each day, [advent of code](https://adventofcode.com/2025) presents a challenge for those of brave heart to complete.
This repo contains my answers to the 2025 version of advent of code, not all challenges have been completed. I complete
AoC to get familiar with a technology, its build tools and testing tools, it's kind of a mini-production type workflow
I follow.

In this year I chose to use the following tools:
- [Ruby v3.4.7](https://www.ruby-lang.org/en/news/2025/10/07/ruby-3-4-7-released). Language for this years AOC solutions.
- [Rake v13.3.1](https://github.com/ruby/rake/releases/tag/v13.3.1).
- [Minitest v5.26.1](https://github.com/minitest/minitest/releases/tag/v5.26.1). Unit test framework
- [Rubocop v1.81.7](https://docs.rubocop.org/rubocop/1.81/index.html). Linter
- [pre-commit v0.40.0](https://github.com/jish/pre-commit)
- [debase v0.2.9](https://github.com/ruby-debug/debase). Used for debugging

All development is completed using [VS Code](https://code.visualstudio.com) with the [Ruby LSP](https://github.com/Shopify/ruby-lsp) plugin installed.

## Setup
Firstly install dependencies
```bash
╰─❯ bundler install
```

Then install the pre-commit hooks.
```bash
╰─❯ pre-commit install
```

The environment is now setup and ready to go.

## Testing
To run all the tests:
```bash
╰─❯ rake test
```

To run a single test file:
```bash
╰─❯ rake test TEST=test/day_00/test_task_02.rb
```

## Committing
The pre-commit hook should kick-in, when it does it will lint and prettify the code.
```bash
╰─❯ git add --all
╰─❯ git commit -a
```

## Progress
|                                                | Challenge              |                                         Task 1                                          |                                         Task 2                                          |
| :--------------------------------------------- | :--------------------- | :-------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------: |
| [Day 01](https://adventofcode.com/2025/day/1)  |  |  |  |
| [Day 02](https://adventofcode.com/2025/day/2)  |  |  |  |
| [Day 03](https://adventofcode.com/2025/day/3)  |  |  |  |
| [Day 04](https://adventofcode.com/2025/day/4)  |  |  |  |
| [Day 05](https://adventofcode.com/2025/day/5)  |  |  |  |
| [Day 06](https://adventofcode.com/2025/day/6)  |  |  |  |
| [Day 07](https://adventofcode.com/2025/day/7)  |  |  |  |
| [Day 08](https://adventofcode.com/2025/day/8)  |  |  |  |
| [Day 09](https://adventofcode.com/2025/day/9)  |  |  |  |
| [Day 10](https://adventofcode.com/2025/day/10) |  |  |  |
| [Day 11](https://adventofcode.com/2025/day/11) |  |  |  |
| [Day 12](https://adventofcode.com/2025/day/12) |  |  |  |
