# Postmortem: Chaining NoSQL Injection, SSTI, and Post-Exploitation Enumeration

## Overview

This system exposed a minimal web attack surface consisting of a few HTTP endpoints and no meaningful enumeration artifacts. The exploitation path relied on chaining three issues:

1. Authentication bypass via improper handling of structured input.
2. Server-side template injection leading to remote code execution.
3. Post-exploitation access via an over-permissive administrative utility.

The challenge emphasized understanding framework behavior over endpoint discovery.

---

## Initial Enumeration

The application exposed only:

- A landing page
- A login endpoint
- A protected staff area

Standard enumeration (directory brute force, source probing, and credential guessing) yielded no results. The lack of surface area shifted focus toward request processing behavior.

---

## 1. Authentication Bypass via Input Deserialization

The login logic incorrectly handled structured request bodies. By altering the request format, user input was interpreted as a structured object rather than plain strings.

This allowed injection of query operators into the authentication flow, resulting in successful login without valid credentials.

Key lessons:

- Request parsers may behave differently depending on content type.
- Structured input must be strictly validated before reaching query logic.
- Authentication systems must not directly consume user-controlled query operators.

---

## 2. Server-Side Template Injection (SSTI)

Authenticated access exposed a template preview feature that evaluated user-supplied input on the server.

The template engine executed expressions rather than rendering them safely, resulting in server-side template injection and arbitrary command execution under the application user.

Key lessons:

- Template engines are execution contexts, not safe renderers.
- User-controlled templates must never be evaluated server-side.
- SSTI often leads directly to RCE when unsafe evaluation is enabled.

---

## Post-Exploitation

Initial access provided a low-privilege service account. Standard privilege escalation vectors (SUID binaries, writable paths, cron jobs, misconfigurations) were not immediately exploitable.

Further enumeration focused on available system capabilities rather than direct escalation paths.

An administrative filesystem utility was found to be executable without elevated privileges. While not a direct privilege escalation vector, it enabled sufficient filesystem inspection to retrieve the required artifact.

Key lesson:

> Capability enumeration can be as important as privilege escalation.

---

## Key Takeaways

### 1. Minimal surfaces can still hide critical flaws
A small number of endpoints can still expose multiple high-impact vulnerabilities.

### 2. Framework behavior is often the attack surface
Understanding parsing, templating, and deserialization behavior is more important than brute enumeration.

### 3. Think in vulnerability classes
NoSQL injection, SSTI, and misconfigured system utilities are recurring patterns across applications.

### 4. Enumeration is context-dependent
Each access level changes what is relevant to inspect next.

### 5. Privilege escalation is not always required
Misconfigured tools and permissions may satisfy objectives without full root compromise.

---

## Reflection

The main blocker was not technical complexity but incorrect assumptions about request handling. Once the parsing behavior was questioned, the exploitation chain became straightforward.

This reinforces a recurring principle in web security:

> Subtle framework behavior often matters more than complex exploitation techniques.

Addendum: the final post-exploitation step was not something I derived independently. After pulling all the stops, I consulted an external write-up which pointed me toward a capability I had overlooked. 
Rather than reproducing that solution, I focused on understanding why it worked and on extracting the general lesson: 

> Post-exploitation should also include capability enumeration, not only privilege-escalation checks. 

---
**This repository is for educational and authorized security auditing purposes only. All testing should be conducted in isolated, self-hosted, or explicitly permitted environments. The author assumes no liability for misuse.**

**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repository is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**


_Way to go, brain! Good luck and happy hacking!_


