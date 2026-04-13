# Qui-Gon LP

Constraint programming model for scheduling a **round-robin podrace tournament** with fair track assignment.

## Problem

Qui-Gon is on Tatooine and needs to organize a tournament of podraces to fix the Royal Starship. He is hoping that young Anakin will win the tournament.

The tournament has **n** competitors (n must be even). It runs over **n − 1** days. Each day, every competitor races exactly once. Over the whole tournament, each pair of competitors meets exactly once (single round-robin).

Each race uses two **tracks**: **0** (left, advantageous) and **1** (right). For fairness, no competitor may start on the same track more than **`maxSucc`** times in a row (for either track).

The goal is to find schedules **`opp`** and **`track`**:

- `opp[c][d]` — opponent of competitor `c` on day `d`
- `track[c][d]` — track (0 or 1) for competitor `c` on day `d`

The original challenge targets **20 competitors** with a solution in **under one minute** (the model sets a 60-second time limit).

## Repository layout

| File | Purpose |
|------|---------|
| `qui_gon.mod` | IBM OPL model: declarations, constraints, CP parameters, and output |

## Model (OPL / CP Optimizer)

The model is written in **OPL** with `using CP;` for **IBM ILOG CP Optimizer** (often installed with CPLEX as “CP Optimizer”).

Default parameters in `qui_gon.mod`:

- `nbCompetitors = 20`
- `maxSucc = 2`
- `cp.param.timeLimit = 60` (seconds)
- `cp.param.DefaultInferenceLevel = "Extended"`

Adjust `nbCompetitors`, `maxSucc`, or the `execute` block parameters as needed.

## How to run

You need a working **CP Optimizer** toolchain with the OPL interpreter (for example **IBM ILOG CPLEX Optimization Studio**).

From the repository root:

```bash
oplrun qui_gon.mod
```

If `oplrun` is not on your `PATH`, use the full path from your CPLEX/CP Optimizer installation (location varies by version and OS).

On success, the model prints a day-by-day schedule: for each day, each competitor’s track and opponent.

## Constraints (summary)

1. **No self-match:** `opp[c][d] ≠ c`
2. **Mutual pairing:** if `a` races `b` on day `d`, then `opp[b][d] = a`, and tracks sum to 1 (one left, one right)
3. **Round-robin:** for each competitor, all opponents across days are distinct (every other competitor exactly once)
4. **Run fairness:** for every window of `maxSucc + 1` consecutive days, track counts are strictly between 0 and `maxSucc + 1` (no all-0 or all-1 streaks longer than allowed)

## License note

`qui_gon.mod` retains IBM copyright and license headers from the original materials.
