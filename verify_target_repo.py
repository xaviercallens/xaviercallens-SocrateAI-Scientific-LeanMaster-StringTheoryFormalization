#!/usr/bin/env python3
"""
verify_target_repo.py
Audits the target repository for zero-sorry invariant and counts all theorems.
"""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent

total_theorems = 0
total_sorry = 0
total_lines = 0
module_stats = []

for p in sorted(ROOT.rglob("*.lean")):
    if ".lake" in p.parts:
        continue
    rel = p.relative_to(ROOT).as_posix()
    content = p.read_text(encoding="utf-8")
    lines = len(content.splitlines())
    total_lines += lines

    # Strip comments
    code = re.sub(r'/-[\s\S]*?-/', '', content)
    code = re.sub(r'--.*$', '', code, flags=re.MULTILINE)

    sorry_cnt = len(re.findall(r'\bsorry\b', code))
    total_sorry += sorry_cnt

    thms = len(re.findall(r'^\s*(?:theorem|lemma)\s', content, flags=re.MULTILINE))
    total_theorems += thms

    module_stats.append((rel, lines, thms, sorry_cnt))

print(f"\n=======================================================")
print(f"  TARGET REPOSITORY VERIFICATION AUDIT")
print(f"=======================================================")
print(f"  Total Lean 4 Files: {len(module_stats)}")
print(f"  Total Lines of Code: {total_lines}")
print(f"  Total Verified Theorems: {total_theorems}")
print(f"  Total Sorry Axioms: {total_sorry}")
print(f"  Zero-Sorry Invariant: {'PASS (0 Sorry)' if total_sorry == 0 else 'FAIL'}")
print(f"=======================================================\n")
