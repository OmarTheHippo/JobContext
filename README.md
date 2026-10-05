# JobContext

A small local chat client that sends **your job context** and **the agent roles you pick**
as the system prompt on every call to a GenAI API, so you never re-explain who you are.

The whole app is one file, `jobcontext.txt`: Python (standard library only) with the web
page's HTML, CSS and JavaScript inside it. It's built to be easy to move to a locked-down
machine and easy to edit by uploading a single file to an AI assistant.

## Install

1. Put `jobcontext.txt` and `install.bat` in a folder, e.g. `Documents\JobContext`.
2. Double-click `install.bat`. It checks for Python 3.9+, creates the `data` folder, and
   writes `Start Job-Context.bat`. No admin rights and nothing to `pip install`.
3. Double-click `Start Job-Context.bat`. The app opens in your browser at
   `http://127.0.0.1:5000`. Closing the console window stops it.

If `.bat` files can't be run, use `python jobcontext.txt --install` and then
`python jobcontext.txt`. Python runs a `.txt` file fine.

## First run: Settings

Settings opens on first launch. Enter:

- **Base URL** of your GenAI API, e.g. `https://your-genai-host/v1`. Requests go to
  `<base URL>/chat/completions`, and the screen shows the exact address.
- **Model** name, as your API expects it.
- **API key**. It's saved in `data\settings.json`, encrypted with Windows DPAPI so only
  your Windows account on that PC can read it. It is never written into the code and never
  included in exports.

**Save & test connection** checks it all with one small request. Choose the **Mock**
provider to try the interface without any API.

## Using it

- **Job context:** who you are, meaning your role, organisation, duties, terminology and how
  you like answers. Each chat uses one.
- **Agents:** specialist layers on top, such as Writer or Analyst. A chat can use any number.
- **New chat** asks which context and agents to apply. **System prompt** shows exactly
  what's sent.
- **Update layer…** (or `/update Writer remember that …`) has the model read the chat
  and propose a revised layer. You review and edit it side by side before saving, and the
  last 50 versions are kept.
- **Import / Export:** a single layer as `.md`, or everything as one `.json` bundle,
  optionally with chats. Imports always add and never overwrite.

## Adapting to your API

`_genai_complete()` in section 3 of `jobcontext.txt` sends the common "chat completions"
JSON format and reads `choices[0].message.content`. If your API differs, change the three
lines marked `<-- 1, 2, 3`. To reuse a key source shared with your other apps, fill in
`shared_api_key()` in section 2. It's used only when no key is saved in Settings.

The file opens with a map of its 10 numbered sections, so you can ask for a change to one
section ("change section 9 so that…") instead of editing the whole file.

## Data

Everything lives in `data\` next to the app as plain JSON: `contexts\`, `agents\`,
`chats\` and `settings.json`. Back it up by copying the folder, or use Export.
