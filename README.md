# Teaching Cairo

This repository is meant to be used as a guideline for anyone who wants to teach Cairo. The methodology is to start with an empty project created with `scarb --init` for vanilla Cairo (not Starknet smart contracts) and its default testing suite (not Starknet Foundry) and then step by step recreate this repository by coding live and following a Test Driven Development (TDD) approach using `scarb test` to check outputs.

## Setup

This project is meant to be used with Docker and the Dev Containers extension for Cursor or VSCode.

## Topics Order

Each module covers a particular characteristic of the language and the proposed teaching order is set by how the modules are defined in the file `lib.cairo`.

For example, if the file `lib.cairo` contains the following code:

```rust
mod felts;
mod functions;
mod integers;
```

It means that the suggested order for the course is to first teach field elements, then functions and finally integers.

## Goals

The teaching goal of each module is defined as a top level comment on each file like this:

```rust
// This section covers the anatomy of a function and how to return a value
// with and without using the "return" keyword

fn foo() -> u32 {
    5
}
// etc...
```