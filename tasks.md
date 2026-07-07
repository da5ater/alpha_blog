# Mentor Tasks: Resolving "Remote Origin Already Exists"

When you tried to run `git remote add origin https://github.com/da5ater/alpha_blog.git`, Git threw the error:
`error: remote origin already exists.`

This is because your repository already has a remote named `origin` pointing to the SSH URL (`git@github.com:...`). When you ran `git push`, Git still tried to use that old SSH URL, resulting in the same `Permission denied` error.

---

## [ ] Task 1: Update or Replace the Remote URL
To switch to HTTPS, you must either update the existing remote URL or delete it and add it again.
- [ ] List your current remote URLs to verify what `origin` points to: `git remote -v`.
- [ ] Update the URL of the existing `origin` remote to the HTTPS version.
- [ ] Verify that the remote now points to the HTTPS URL: `git remote -v`.
- [ ] Push your repository: `git push -u origin main`.

---

# Answer Key & Self-Correction Guide

<details>
<summary>👉 Click to reveal commands to change the remote URL</summary>

### Method 1: Update the existing remote URL (Recommended)
Run this command to change the URL directly:
```bash
git remote set-url origin https://github.com/da5ater/alpha_blog.git
```

---

### Method 2: Remove the old remote and add the new one
If you prefer to start fresh, you can remove the old remote first:
```bash
git remote remove origin
```
And then add the new HTTPS one:
```bash
git remote add origin https://github.com/da5ater/alpha_blog.git
```

---

### Verify and Push
After using either method above, verify the remote URL:
```bash
git remote -v
```
You should see:
`origin  https://github.com/da5ater/alpha_blog.git (fetch)`
`origin  https://github.com/da5ater/alpha_blog.git (push)`

Now push your code:
```bash
git push -u origin main
```
</details>
