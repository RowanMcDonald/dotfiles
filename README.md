# Rowan's dotfiles

A single-file zsh config plus a `brew bundle` for everything I install on a fresh Mac.

## Getting started

### Inspect-first (recommended)

```sh
git clone --bare https://github.com/RowanMcDonald/dotfiles.git ~/dotfiles
git --git-dir=$HOME/dotfiles show HEAD:.bin/setup_dotfiles | less   # read it
bash <(git --git-dir=$HOME/dotfiles show HEAD:.bin/setup_dotfiles)  # run it
```

### Yolo

```sh
curl -fsSL https://raw.githubusercontent.com/RowanMcDonald/dotfiles/master/.bin/setup_dotfiles | bash
```

The whole script is wrapped in `main() { … }; main "$@"`, so a truncated download fails to parse and runs nothing.

## Layout

```
.zshrc                       # entire shell config (one file)
.bin/                        # personal scripts on PATH
.bin/setup_dotfiles          # bootstrap script
Brewfile                     # everything brew installs
.config/mise/config.toml     # pinned runtimes (ruby)
.config/git/ignore           # global gitignore
.config/iterm2/              # iTerm color schemes
.config/nvim/                # neovim config (lazy.nvim)
.config/atuin/               # atuin config
.claude/settings.json        # Claude Code settings
.tmux.conf, .psqlrc, .pryrc, .irbrc, .rgrc
```

## CLI packages

| Package         | Why |
|-----------------|-----|
| `atuin`         | Searchable shell history with sync |
| `bat`           | `cat` with syntax highlighting (aliased to `cat`) |
| `bun`           | JS runtime + package manager (replaces npm; globals → `~/.bun/bin`) |
| `coreutils`     | GNU userland |
| `direnv`        | Per-directory env vars |
| `eza`           | `ls` replacement (aliased to `ls`/`la`) |
| `fd`            | Fast `find` replacement |
| `figlet`        | ASCII banners (drives `fgl`) |
| `fzf`           | Fuzzy finder — bound to `^P` (vim) and `^B` (`co`) |
| `gh`            | GitHub CLI |
| `git`           | Source control |
| `gnu-sed`       | GNU `sed` |
| `go`            | Go toolchain |
| `gource`        | Repo history visualizer (drives `prettygource`) |
| `jq`            | JSON processor |
| `mise`          | Runtime version manager (Ruby + per-project versions) |
| `neovim`        | Editor (aliased to `vim`/`vi`/`v`) |
| `openssl@3`     | TLS lib for Ruby builds |
| `parallel`      | Run shell jobs in parallel |
| `postgresql@17` | Local Postgres (autostarted via brew services) |
| `ripgrep`       | Fast `grep` |
| `rustup`        | Rust toolchain installer |
| `tldr`          | Short man pages |
| `tree`          | Directory tree |
| `uv`            | Fast Python package manager |
| `yarn`          | JS package manager (Rails default) |
| `zoxide`        | Smart `cd` (`z foo`, `zi` interactive) |

## GUI apps (casks)

| App                                       | Why |
|-------------------------------------------|-----|
| `alfred`                                  | Spotlight replacement |
| `anki`                                    | Spaced repetition |
| `font-fira-code`, `font-hack-nerd-font`   | Coding fonts |
| `google-chrome`                           | Browser |
| `notion`                                  | Notes |
| `rectangle`                               | Window snapping |
| `signal`, `zoom`                          | Communication |

## Runtimes

- **Ruby** — pinned in `.config/mise/config.toml` (`3.4`). Rails installed as a global gem.
- **Rust** — `rustup-init` → stable toolchain + `rust-analyzer`, `rustfmt`, `clippy`.
- **JS** — bun, not node. Use `bun install -g <pkg>` for globals.
- **Claude Code** — native installer (`claude.ai/install.sh`), no node dependency.
- **Python** — via `uv`, no global interpreter pinned.

## Aliases

### Git
| Alias      | Expands to |
|------------|------------|
| `gs`       | `git status -s` |
| `gsl`      | `git shortlog -sn` |
| `gcm`      | `git commit -m` |
| `gca`      | `git commit -a` |
| `gcb`      | `git checkout -b` |
| `ga`       | `git add . ; git status -s` |
| `gl`       | Pretty `git log --graph` |
| `gp`       | `git push -u origin HEAD` |
| `cl`       | `git checkout main && git fetch && git pull` |
| `cl_`      | Same, for `master` |
| `b`        | Branches sorted by latest commit |

### Ruby / Rails
| Alias  | Expands to |
|--------|------------|
| `bi`   | `bundle install` |
| `be`   | `bundle exec` |
| `ber`  | `bundle exec rspec` |

### Navigation
| Alias                    | Expands to |
|--------------------------|------------|
| `..` `...` `....` `.....`| Walk up 1–4 directories (also runs `bwd`) |
| `bwd`                    | `pwd` but with `/` as 🥖 |
| `kk`                     | Toggle between current and previous directory |

### Files / editors
| Alias        | Expands to |
|--------------|------------|
| `ls` / `la`  | `eza -hF` / `eza -la` |
| `cat`        | `bat --paging=never --style=plain` |
| `vim` / `vi` / `v` | `nvim` |
| `rgf`        | Filename search (`rg --files \| rg`) |
| `prettyplease` | `sudo` with a flower-art password prompt |

## Functions

### Git workflow
- **`co`** — fzf-pick a branch or tag, then `git checkout`. Bound to `^B`.
- **`gf`** — fzf-browse changed files.
- **`gb`** — fzf-browse branches with a log preview.
- **`gshow`** — fzf-browse the log; emit selected SHA(s).
- **`gr`** — fzf-browse remotes.
- **`stash`** — fzf-browse stash entries.
- **`gd`** — fzf-pick a branch and delete it.
- **`ff`** — fast-forward to `main`, stashing uncommitted changes temporarily.
- **`gpr`** — push HEAD, then open the GitHub PR-compare URL.
- **`open_pr`** — open the compare URL without pushing.

### Ruby
- **`rubo`** — `rubocop --auto-correct` on files changed since `main`.
- **`lint`** — `standardrb` + `erblint`, then commit as "Lint".
- **`in_each_ruby_dir <cmd>`** — run `<cmd>` in every `Gemfile`-containing subdir.

### Misc
- **`fgl <text>`** — fzf-pick a figlet font, render `<text>`, copy to clipboard.
- **`notify <msg>`** — macOS notification.
- **`pg_kill_conn <db>`** — kill all Postgres connections to `<db>`.
- **`dots`** — bare-repo git wrapper for managing tracked dotfiles from anywhere.
- **`how_many <pattern>`** — count ripgrep matches.

## Key bindings

| Key  | Action |
|------|--------|
| `^P` | fzf-pick a file → `vim <file>` |
| `^B` | fzf-pick a branch/tag (`co`) → insert into command line |

## References

Bare-repo dotfiles strategy: <https://www.atlassian.com/git/tutorials/dotfiles>

## Todos

projections not working outside of rails?

Create a minimal version of vimrc so we get fast boot
https://www.wezm.net/technical/2019/10/useful-command-line-tools/

setup startify to have a git branches section
https://www.reddit.com/r/neovim/comments/ewgo9g/fzf_floating_tab_select/
# look into lazygit
https://github.com/camspiers/dotfiles/blob/master/files/.config/nvim/init.vim#L445-L522

look at http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized


# TODO
Setup something that raises if config files are dirty.

rg --vimgrep  |  wc -l

How does `:g/-/norm nD` work?  https://stackoverflow.com/questions/37293734/vim-delete-starting-from-character-to-end-of-line

Navigate quickfix lists
:cold
https://thepugautomatic.com/2014/03/stacked-vim-searches-down-cold/
