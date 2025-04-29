# README

## Welcome to BDD workshop!

Start by setting up your dev environment from

https://github.com/failure-driven/bdd-workshop

### Setup Option 1: Code spaces (easy)

_Use Code Spaces for a seamless experience._

- `code` -> `codespaces` -> **`Create codespace on main`**

```sh
make

# ⚠️ Important ⚠️ manually use correct version of rvm ruby
rvm install $(cat .ruby-version) && rvm use .

make build                  # runs tests

make setup                  # sets up DB and runs dev server

make dev                    # run dev server
                            # codespaces will open up a tab to view in the browser window
```

---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
