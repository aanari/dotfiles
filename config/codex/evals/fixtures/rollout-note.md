Rollout Note: Defaulting to Background Sync

Summary

This note proposes enabling background sync by default for newly created workspaces. The feature already exists behind a flag and has been exercised by a small internal group.

Proposal

Turn on background sync by default for new workspaces only. Existing workspaces keep their current setting. The rollout should happen behind a server-side flag so the team can pause or narrow exposure quickly if needed.

Why now

The current opt-in model hides the feature from most users, which means product feedback is too sparse and docs remain out of date. Making it the default for new workspaces should increase real usage without forcing a migration on existing users.

Operational plan

- enable for 10% of newly created workspaces
- watch error rates and support volume for one week
- increase to 50% if there is no major regression
- move to 100% for new workspaces after that

Non-goals

- migrating existing workspaces automatically
- redesigning sync semantics
- adding a second sync mode

Notes

The feature has a visible status indicator in the UI and can already be disabled in settings if a user prefers manual sync.
