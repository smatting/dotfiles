---
name: jot
description: Use this skill when the user says "jot", "jot that down", "make a note", "note that", "save that", or asks you to remember something as a jot/note.
version: 1.0.0
---

# Jot CLI Skill

When the user wants to jot something down, use the `jot` CLI to save it.

## CLI Usage

```bash
# Add a jot (inline text)
jot add "text here"

# Add a jot from stdin
echo "text" | jot

# Open $EDITOR to write a jot interactively
jot

# List jots (paginated, boxed display)
jot list

# List jots as plain text
jot list --plain

# List a specific page
jot list --page 2

# Edit a jot by ID
jot edit <id>

# Delete a jot by ID
jot delete <id>
```

## Saving a Jot

When the user says "jot that down" or similar, extract the content from their message and run:

```bash
jot add "<content>"
```

For multi-line or long content, use stdin:

```bash
cat <<'EOF' | jot
content here
EOF
```

## Environment

The CLI reads these env vars (set in `~/.envrc` via direnv):
- `JOT_API_URL=https://jot-api.guvv.cc`
- `JOT_API_USER=stefan`
- `JOT_API_PASSWORD=<password>`

## On Failure

If the API call fails, the draft is automatically saved to `~/.jot_draft` and an error is printed to stderr.
