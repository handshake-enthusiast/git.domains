Development
---

1. Run `docker compose up`
2. Configure necessary [ENV variables](https://github.com/handshake-enthusiast/git.domains/blob/main/lib/constants.rb). Could be done in the _.env_ file.

Contribute
---

Intentionally minimal setup. You could use ChatGPT to write code. Start with discussions, but feel free to open issues and pull requests.

Security
---

I [obtain](https://github.com/handshake-enthusiast/git.domains/blob/main/app.rb#L21) only [a user access token](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-a-user-access-token-for-a-github-app#about-user-access-tokens) with no additional permissions, just the minimum possible default. It is valid for 8 hours and can be used only to read public resources. After 8 hours it expires.

Credits
---

[Uses](https://github.com/handshake-enthusiast/git.domains/blob/main/lib/services/varo/add_record.rb) [Varo](https://github.com/varodomains) as a nameserver.

Sponsorship
---

The initial development was partially [sponsored](https://github.com/opensystm/handshake-micro-grants/issues/11) by [Open Systems](https://github.com/opensystm).

Closing notes
---

I'd appreciate if you star the repo or suggest any improvement. See [What's next?](https://github.com/handshake-enthusiast/git.domains/discussions/3) to proceed with your journey.
