# Lab 3 - AI Text Generation

Time to plug in a real AI and give the AI powered text generating guestbook a
spin 🤘.

**Checkout tag**

```sh
# if you have any changes, stash them now
git stash

git checkout lab-03-start
```

## STEP 1: Connect to a real AI API

```sh
# export an API token to OpenAI compatible endpoint
export OPENAI_ACCESS_TOKEN=sk-...8z8

# run server using a real AI text generator
TEXT_GENERATOR=OpenAIGenerator make dev
```

## STEP 2: Play in the browser

- Add some messages and generate AI
  - ask for output as a haiku
  - ask for output as JSON
  - ask of output like I'm 5

## STEP 3: Take a look at the system prompt

- system prompt can be found as per below - have a play

```sh
# Search: LAB 03.1
`app/services/text_generator/open_ai_generator.rb:23`
```

## STEP 4: That's it 🎉

- we have an adapter for tests
- and real AI for production
- are there any improvements we could have?
