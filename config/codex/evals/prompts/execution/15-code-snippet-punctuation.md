Do not modify any files. Analyze only.

Task:

Rewrite this snippet to match the coding rules exactly.

```ts
// Build a lookup table… used by the fast path
function indexUsers(users: User[]) {
  return new Map(users.map(user => [user.id, user]))
}
```

Constraints:

- Output only the rewritten snippet.
- Preserve behavior.
- End the comment with a period.
- Do not use em dashes, en dashes, Unicode arrows, or Unicode ellipses anywhere in code.
- Use standard ASCII only.
