Generating a resume with typst

I got tired of fixing format issues of my `resume.odt` file everytime edits were made.

This is a fork of [basic-resume](https://typst.app/universe/package/basic-resume). Making few changes to be ideal for personal use-case.

Modifications to be/can be done:
- [x] Update few header links to be hyperlinks instead of direct ones (eg: github, linkedin)
- [x] Add optional display of GPA
- [x] Have a `.toml` file for easily updating personal info
- [x] Update all functions to be compatible with using`.toml` data
- [x] Tweak design to taste
- [x] Add provision of including multiple links for each project instead of 1 URL
- [ ] Dynamically change layout with vertical list of links when introducing image?
- [x] Make few design choices (eg: which lines to italicize) programmatic (like usage of `consistent` parameter)


## Local Setup
1. Ensure `devbox` and `nix` is installed
2. Run `devbox shell` inside project root
3. Run `devbox run server` for live-reload edits
4. Run `devbox run build` for creating builds in `output` directory
5. Run `devbox run fmt-all` for formatting `src/*.typ` files