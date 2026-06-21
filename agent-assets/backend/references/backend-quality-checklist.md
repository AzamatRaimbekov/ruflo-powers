# Backend Quality Checklist

Use this checklist when a backend task crosses multiple skills.

## Contract

- Resource names are stable, plural, and consumer-oriented.
- Mutating operations define validation, idempotency, and conflict behavior.
- Pagination, filtering, sorting, and error envelopes are documented.
- OpenAPI or equivalent contract is updated when public API shape changes.

## Data

- Query paths are known before schema or index design.
- Migrations are reversible or have a safe forward rollback plan.
- Destructive changes have expand, backfill, contract steps.
- Transactions cover invariants; jobs and external calls are outside transactions unless intentional.

## Security

- Default deny on authorization.
- Inputs are allowlist-validated at boundaries.
- Secrets are never logged, returned, committed, or embedded in generated files.
- Authentication and session/token lifecycle are tested, including expiry and revocation.

## Reliability

- Network calls have explicit timeouts.
- Retries use bounded exponential backoff with jitter and are safe through idempotency.
- Queues have dead-letter handling, visibility timeouts, and backpressure.
- Health endpoints distinguish liveness, readiness, and degraded dependencies.

## Observability

- Logs are structured and include request or trace correlation.
- Metrics have bounded cardinality and measure SLIs, not only symptoms.
- Traces cross service boundaries.
- Alerts link to runbooks and avoid paging on unactionable noise.

## Performance

- Baseline latency, throughput, memory, and query costs are measured before optimization.
- Caches define keys, TTL, invalidation, stampede protection, and consistency tradeoffs.
- N+1, fan-out, payload bloat, and connection pool saturation are checked.
- Performance-sensitive changes have tests, benchmarks, or documented measurement evidence.

## Review

- Tests cover happy path, validation errors, authorization failures, data consistency, retry/idempotency, and regression cases.
- Error responses avoid leaking internals.
- Background jobs are re-runnable or compensatable.
- Documentation and feature docs are updated when behavior changes.
