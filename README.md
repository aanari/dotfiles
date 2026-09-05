# ~/.dotfiles

## Installation

``` sh
FRESH_LOCAL_SOURCE=aanari/dotfiles bash <(curl -sL get.freshshell.com)
```

My dotfiles are managed by [fresh].

## Gmail filters

Gmail filters are managed declaratively with `gmail-filter-apply`. The real
configuration stays private at `~/.config/gmail-filters/filters.toml`; this
public repository contains only an example.

After authenticating with `gws-auth-gmail-settings`, import the current Gmail
state once:

```sh
gmail-filter-apply --import-current ~/.config/gmail-filters/filters.toml
```

Edit that file, then inspect and apply the reconciliation plan:

```sh
gmail-filter-apply
gmail-filter-apply --apply
```

Existing inbox mail is never changed by the normal apply. Backfill a reviewed
rule separately, and only prune filters previously managed by this tool:

```sh
gmail-filter-apply --only github-notifications --backfill
gmail-filter-apply --only github-notifications --backfill --apply
gmail-filter-apply --prune --apply
```

`gmail-inbox-analyze` remains a proposal generator. Review its output rather
than treating inferred categories as policy.

[fresh]: http://freshshell.com
