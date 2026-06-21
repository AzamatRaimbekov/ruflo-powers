# Publishing & Updating Ruflo Powers

This workspace **is** the source of the public framework repo
**[AzamatRaimbekov/ruflo-powers](https://github.com/AzamatRaimbekov/ruflo-powers)**.
Anyone installs it from there; you publish updates from here.

---

## Update in one command

```bash
bash update.sh "what changed"   # stage everything, commit, push to GitHub
bash update.sh                  # auto timestamp message
bash update.sh -n "msg"         # dry-run — show changes, push nothing
```

That's the whole loop:

```
edit skills / agents / rules / docs  →  bash update.sh "..."  →  it's live
```

Users pick up changes by re-running `install.sh` (or `git pull` in their clone).

---

## How auth works (no token needed)

- `origin` = `git@github.com:AzamatRaimbekov/ruflo-powers.git` (SSH).
- This machine has a working SSH key as GitHub user **AzamatRaimbekov**, so
  `git push` / `update.sh` need **no token and no `gh`**.
- A Personal Access Token is only ever needed to **create a new repo** (SSH can
  push but can't create). The repo already exists, so you won't need one again.

---

## Safety (public repo)

- **Never commit secrets.** `.gitignore` already excludes `.env*`,
  `CLAUDE.local.md`, `settings.local.json`, `*.db`, `.swarm/`, logs, and runtime.
- Before a big change, run `bash update.sh -n "msg"` to preview what will be sent.
- If a secret ever lands in a commit, rotate it immediately — public history is
  effectively permanent.

---

## Installing (for reference / other users)

```bash
git clone https://github.com/AzamatRaimbekov/ruflo-powers.git ~/ruflo-powers
cd ~/your-project && bash ~/ruflo-powers/install.sh
```

Full install guide: **[INSTALL.md](INSTALL.md)**. What's inside: **[README.md](README.md)**.
