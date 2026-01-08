# Code Review Guide

**Author:** Nil Podozerov  
**Company:** РИПАС (RIPAS)  
**Version:** 1.0

---

## Purpose of Code Review

Code review is not just about finding bugs. It's about:
- **Knowledge sharing** - Learning from each other
- **Consistency** - Maintaining code quality standards
- **Collaboration** - Building better solutions together
- **Mentorship** - Helping each other grow

---

## For Reviewers

### General Principles

1. **Be kind and constructive**
   - ✅ "Consider using async here for better performance"
   - ❌ "This is terrible, you don't know async?"

2. **Explain the "why"**
   - ✅ "Let's add type hints here so mypy can catch type errors"
   - ❌ "Add type hints"

3. **Distinguish between "must fix" and "nice to have"**
   - Use labels: `[required]`, `[suggestion]`, `[nit]`

4. **Approve early, iterate later**
   - If core logic is good, approve and open follow-up issues for minor improvements

### Review Checklist

#### Functionality
- [ ] Does the code do what it's supposed to do?
- [ ] Are edge cases handled?
- [ ] Is error handling appropriate?
- [ ] Are there any obvious bugs?

#### Code Quality
- [ ] Follows [CODING_STANDARDS.md](CODING_STANDARDS.md)?
- [ ] Type hints present and correct?
- [ ] Docstrings for public APIs?
- [ ] No unnecessary complexity?
- [ ] DRY principle followed (Don't Repeat Yourself)?

#### Testing
- [ ] Are tests comprehensive?
- [ ] Do tests cover edge cases?
- [ ] Are mocks used appropriately?
- [ ] Does coverage meet >= 80%?

#### Security
- [ ] No secrets in code?
- [ ] Input validation present?
- [ ] SQL injection prevented?
- [ ] XSS risks mitigated?

#### Performance
- [ ] No N+1 query problems?
- [ ] Async used for IO?
- [ ] No unnecessary database calls?
- [ ] Efficient algorithms?

#### Documentation
- [ ] README updated (if needed)?
- [ ] API docs updated (if needed)?
- [ ] Complex logic explained?

### Common Feedback Patterns

#### Suggesting Improvements

```markdown
[suggestion] Consider extracting this into a helper function for reusability:

```python
def format_user_message(user: User, message: str) -> str:
    return f"@{user.username}: {message}"
```

This would make it easier to change the format later.
```

#### Pointing Out Issues

```markdown
[required] This will fail if `user.username` is None. Add validation:

```python
if not user.username:
    raise ValueError("User must have a username")
```
```

#### Asking Questions

```markdown
[question] Why did you choose to use synchronous requests here instead of async? 

If there's a specific reason, consider adding a comment explaining it.
```

---

## For Authors

### Before Requesting Review

1. **Self-review your code**
   - Read through the entire diff
   - Check for console.log / debug statements
   - Verify tests pass
   - Run linters

2. **Provide context**
   - Write a clear PR description
   - Link to related issues
   - Explain design decisions
   - Add screenshots for UI changes

3. **Keep PRs focused**
   - One feature/fix per PR
   - Avoid mixing refactoring with features
   - Split large changes into multiple PRs

### Responding to Feedback

1. **Don't take it personally**
   - Reviews are about the code, not you
   - Everyone's code can be improved

2. **Ask for clarification**
   - If you don't understand feedback, ask!
   - "Can you explain what you mean by...?"

3. **Explain your reasoning**
   - If you disagree, explain why
   - "I chose X because..."
   - Be open to changing your mind

4. **Mark resolved comments**
   - After addressing feedback, mark comments as resolved
   - Or reply with "Done!" so reviewer knows

5. **Request re-review**
   - After making changes, request re-review
   - Summarize what changed

### Example Responses

#### Accepting feedback:
```markdown
Good catch! Fixed in latest commit. Changed to:

```python
async def fetch_data(url: str) -> Dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()
```
```

#### Explaining reasoning:
```markdown
I used synchronous requests here because this code runs in a Celery worker
(separate process, not async). Adding async would require wrapping with
`asyncio.run()` which adds complexity without benefit.

Added a comment explaining this.
```

#### Asking for clarification:
```markdown
Could you elaborate on the performance concern? In my testing, this approach
was actually faster because it avoids the overhead of creating async tasks
for such small operations. Happy to benchmark different approaches if needed!
```

---

## Review Response Time

- **Small PRs (< 50 lines):** Aim for 24 hours
- **Medium PRs (50-200 lines):** Aim for 48 hours
- **Large PRs (> 200 lines):** Aim for 3-5 days

If you can't review in time, let the author know or assign to someone else.

---

## Approval Guidelines

### When to Approve ✅

- Core logic is correct
- Tests are comprehensive
- Follows coding standards
- No security issues
- Minor issues can be fixed in follow-ups

### When to Request Changes 🔄

- Bugs present
- Missing critical tests
- Security vulnerabilities
- Doesn't follow standards
- Breaking changes without migration path

### When to Comment 💬

- Suggestions for improvement
- Questions about approach
- Nitpicks (mark as `[nit]`)
- Praise for good code! 🎉

---

## Example Review

```markdown
## Overall

Great work on adding voice transcription! The core logic looks solid and tests
are comprehensive. A few suggestions below:

## Functionality ✅

- [x] Voice messages transcribed correctly
- [x] Error handling for API failures
- [x] Transcripts saved to database

## Suggestions

### src/ai/transcription.py:45

[suggestion] Consider adding retry logic for transient API failures:

```python
@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1))
async def transcribe_audio(file_path: str) -> str:
    ...
```

This would make the system more resilient.

### src/ai/transcription.py:67

[nit] Minor: This could be extracted to a constant:

```python
MAX_AUDIO_FILE_SIZE = 25 * 1024 * 1024  # 25 MB
```

### tests/test_transcription.py:23

[required] Please add a test for when the audio file is too large.

## Performance

[question] Have you tested this with many concurrent transcriptions? 
Whisper API has rate limits - might want to add queuing.

## Documentation

[suggestion] Could you add a docstring example showing how to use this function?

```python
Example:
    >>> transcript = await transcribe_audio("voice.ogg")
    >>> print(transcript)
    "Привет, как дела?"
```

## Great things! 🎉

- Excellent error messages
- Good test coverage (92%)
- Clean separation of concerns

Once the required test is added, I'll approve. Great job overall! 🚀
```

---

## Advanced Topics

### Reviewing Async Code

Check for:
- No blocking calls in async functions
- Proper use of `await`
- No `asyncio.run()` in async context
- Context managers used correctly

### Reviewing Tests

Look for:
- Descriptive test names
- One assertion per test (ideally)
- Proper mocking of external dependencies
- Edge cases covered

### Reviewing Database Code

Check:
- No SQL injection vulnerabilities
- Indexes on frequently queried columns
- No N+1 queries
- Transactions used appropriately

---

## Conflict Resolution

If you disagree with a reviewer:

1. **Discussion** - Explain your reasoning
2. **Research** - Provide examples/benchmarks
3. **Compromise** - Can you meet in the middle?
4. **Escalate** - Ask project lead (Nil Podozerov) to weigh in

Remember: The goal is the best code, not "winning" the argument.

---

## Resources

- [CODING_STANDARDS.md](CODING_STANDARDS.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)
- [How to Do Code Reviews Like a Human](https://mtlynch.io/human-code-reviews-1/)
- [Google's Code Review Guidelines](https://google.github.io/eng-practices/review/)

---

**Author:** Nil Podozerov  
**Company:** РИПАС (RIPAS)  
**Last Updated:** 2026-01-08

