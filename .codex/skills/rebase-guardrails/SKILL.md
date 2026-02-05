---
name: rebase-guardrails
description: Guard and repair Git branch history during rebases or PR cleanup. Use when a PR branch accidentally includes unrelated commits, when rebasing or rewriting history, or when you need to rebuild a branch from a known commit range.
---

# Rebase Guardrails

## Overview

Prevent accidental inclusion of unrelated commits during rebase, and safely repair a branch by reconstructing it from a known commit range. Default to a clean-branch rebuild for safety, with an optional in-place rebase alternative.

## Workflow: Guard + Repair

### 1) Guardrails before any rebase or history rewrite

- Identify the PR base branch and the current head branch.
- Fetch the base: `git fetch origin <base>`.
- List the commit range: `git log --oneline origin/<base>..HEAD`.
- Count commits and sanity-check against the PR scope:
  - `git rev-list --count origin/<base>..HEAD`
  - If the count is materially larger than the PR’s expected commits,
    STOP and repair before rebasing.
- Check for foreign commits (author or subject):  
  `git log --format='%h %an %ae %s' origin/<base>..HEAD`.
- If foreign commits exist, stop and repair before continuing.

### 2) Repair workflow (default, safest): clean branch + cherry-pick range

Use when you know the first commit that should remain in the PR.

Steps:
1. Identify the first commit to keep (`<KEEP>`).
2. Create a clean branch from the PR base:
   - `git checkout -b <clean-branch> origin/<base>`
3. Cherry-pick the allowed range:
   - `git cherry-pick -S <KEEP>^..HEAD` (run from the original branch or use explicit range)
4. Resolve conflicts, keep the intended versions, and continue the cherry-pick.
5. Verify `git log --oneline` only contains expected commits.
6. Point the original branch at the clean one:
   - `git branch -f <branch> <clean-branch>`
7. Push with lease:
   - `git push --force-with-lease origin <branch>`

### 3) Repair workflow (alternate, faster): in-place interactive rebase

Use only if the history is already close to correct and you can confidently drop a prefix.

Steps:
1. Identify the first commit to keep (`<KEEP>`).
2. Run rebase from before it:
   - `git rebase -i <KEEP>^`
3. Drop all commits before `<KEEP>` (or reorder as needed).
4. Resolve conflicts, then `git rebase --continue`.
5. Verify the resulting commit list and push with `--force-with-lease`.

### 4) Safety checks (required)

- Confirm the branch points to the intended PR head before pushing.
- Ensure commits remain signed if signatures are required (`git log --show-signature`).
- Re-run any required lint/test gates if the workflow expects green commits.

## Notes

- Default to the clean-branch rebuild when correctness matters.
- Only use the in-place rebase when you can clearly identify the exact prefix to drop.
