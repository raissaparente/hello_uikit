#!/usr/bin/env python3
"""Generate Claude Code and Codex agent files from the OpenCode/OpenChamber source.

Source of truth:
  agent:  .opencode/agents/<name>.md
  skills: .agents/skills/<skill>/SKILL.md  (read natively by Codex and OpenCode;
          exposed to Claude Code through the .claude/skills symlink)

Generated (do not edit by hand):
  .claude/agents/<name>.md   -> Claude Code subagent / `claude --agent <name>`
  .codex/agents/<name>.toml  -> Codex custom agent
  AGENTS.md                  -> Codex project instructions (primary-agent behaviour)
  CLAUDE.md                  -> imports AGENTS.md for Claude Code

Run: python3 scripts/sync-agents.py
"""
import re
from pathlib import Path

root = Path(__file__).resolve().parent.parent
src_dir = root / ".opencode" / "agents"


def parse(path):
    text = path.read_text(encoding="utf-8")
    m = re.match(r"^---\n(.*?)\n---\n(.*)$", text, re.S)
    meta = {}
    for line in m.group(1).splitlines():
        k, _, v = line.partition(":")
        meta[k.strip()] = v.strip()
    return meta, m.group(2).strip() + "\n"


HEADER = "<!-- GENERATED from .opencode/agents/{n}.md by scripts/sync-agents.py. Edit the source, not this file. -->\n"

for src in sorted(src_dir.glob("*.md")):
    name = src.stem
    meta, body = parse(src)
    desc = meta.get("description", name)

    # Claude Code
    out = root / ".claude" / "agents" / f"{name}.md"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        f"---\nname: {name}\ndescription: {desc}\n---\n{HEADER.format(n=name)}\n{body}",
        encoding="utf-8",
    )

    # Codex
    assert "'''" not in body
    out = root / ".codex" / "agents" / f"{name}.toml"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        f'# GENERATED from .opencode/agents/{name}.md by scripts/sync-agents.py. Edit the source, not this file.\n'
        f'name = "{name}"\n'
        f'description = "{desc}"\n'
        f"developer_instructions = '''\n{body}'''\n",
        encoding="utf-8",
    )

    # Primary-agent behaviour for the project (only for mode: primary)
    if meta.get("mode") == "primary":
        (root / "AGENTS.md").write_text(
            f"{HEADER.format(n=name)}\n"
            f"Skills live in `.agents/skills/` (spec-analyzer, create-ukit-screen, guided-questions); use them as the steps below describe.\n\n"
            f"{body}",
            encoding="utf-8",
        )
        (root / "CLAUDE.md").write_text("@AGENTS.md\n", encoding="utf-8")

    print("synced", name)
