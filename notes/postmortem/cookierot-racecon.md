# Incident Postmortem: 2FA Authentication Spin-Down Loop via Deployment Race Condition

**Date:** 2026-08-27  
**Status:** Resolved  
**License:** CC0 1.0 Universal (Public Domain Dedication)  

---

## 1. Executive Summary
An isolated incident occurred where attempting to submit a Time-Based One-Time Password (TOTP) 2FA token resulted in an indefinite script freeze ("spindown loop") lasting over 60 seconds. The issue persisted across page reloads on the primary browser profile but was bypassed via Incognito mode. The root cause was identified as a live production CI/CD deployment race condition that corrupted the client-side session cookie, causing a permanent deadlock until local site data was purged.

## 2. Timeline of Events
* **T+00:00** - User initiates login and enters a valid 2FA token.
* **T+00:05** - The submission button enters a perpetual loading state; network response hangs indefinitely.
* **T+01:15** - User forces a page refresh and attempts authentication a second time. The freeze recurs immediately.
* **T+02:30** - User opens an Incognito/Private window and attempts the exact same login workflow. Authentication succeeds instantly.
* **T+04:00** - User runs environmental diagnostics (checking local userscripts/extensions). Extension injection leaks are ruled out.
* **T+05:30** - User clears target site cookies from the primary browser profile.
* **T+06:00** - Standard browser login function is fully restored.

## 3. Root Cause Analysis (RCA)
The incident was a multi-stage failure caused by the intersection of a rolling infrastructure deployment and browser state management. 

```
[ Client Request ] ──( 2FA Token )──> [ Cloud Edge / Load Balancer ]
                                                      │
                                  ┌───────────────────┴──────────────┐
                                  ▼ (Millisecond Switchover)         ▼
                      [ Legacy Auth Service ]          [ Updated Auth Service ]
                      (Sent Set-Cookie header)         (Dropped legacy payload)
                                  │                                  │
                                  └─────────────────┬────────────────┘
                                                    ▼
                                        [ Connection Interrupted ]
                                                    │
                                                    ▼
                                  [ Corrupted Client Cookie Written ]
```
### Phase 1: Microservice Blue/Green Shift
The initial 2FA request was dispatched from a frontend interface running legacy code context. It hit the cloud infrastructure load balancer at the precise millisecond of a backend microservice switchover. The updated container context could not process the legacy payload schema, resulting in an unhandled backend exception and an dropped/infinite HTTP connection state.

### Phase 2: Interrupted Token Mutation ("Rotten Cookie")
While the initial connection was hanging, a network mutation or partial `Set-Cookie` header instruction was initialized. When the user manually refreshed the browser tab to break the freeze, the write operation to the local Chromium SQLite cookie database was cut short. This left a truncated, malformed, or cryptographic-mismatched token ("rotten cookie") saved in the primary profile.

### Phase 3: Client-Side Security Tarplaying
On subsequent authentication attempts, the browser automatically attached the malformed cookie string. The now-stable production environment security firewall interpreted this malformed data as a potential session-hijack or prototype pollution vector. Instead of failing gracefully with a standard HTTP error code, it intentionally routed the connection to a timeout queue (tarplaying) to exhaust attacker resources, causing the observed 1+ minute browser hang.

## 4. Resolution & Mitigation

### Immediate Fix
* **Client-Side:** Manually purge site-specific cookies and local storage state. This forces the browser to drop the corrupted session identifier and negotiate a clean cryptographic handshake with the newly deployed backend.

### Engineering Best Practices (Preventative Measures for Platforms)
1. **Graceful Schema Deprecation:** Ensure backend authentication microservices maintain strict backward compatibility for API schemas during rolling deployments ($\text{Version } N-1$ payloads must be parsed gracefully by $\text{Version } N$ containers).
2. **Atomic Cookie Writes:** Client and server-side state transitions should utilize atomic token rotation patterns to ensure partial network disconnects do not leave malformed cryptographic fragments in local browser memory.
3. **Explicit Defensive Error Handling:** Security firewalls should throw standard, scannable response headers (e.g., `400 Bad Request` or `431 Request Header Fields Too Large`) rather than dropping connections silently when parsing malformed metadata, avoiding misleading client-side freezes.

---
**This repository is for educational and authorized security auditing purposes only. All testing should be conducted in isolated, self-hosted, or explicitly permitted environments. The author assumes no liability for misuse.**

**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repository is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor attribution required.**


_Way to go, brain! Good luck and happy hacking!_
