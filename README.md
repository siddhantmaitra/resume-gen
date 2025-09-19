# Generating a PDF resume with typst

I got tired of fixing format issues of my `resume.odt` file everytime edits were made.

This is a fork of [basic-resume](https://typst.app/universe/package/basic-resume), with changes to be ideal for my personal use.

## Local Setup
1. Ensure `devbox` and `nix` is installed
2. Run `devbox shell` inside project root
3. Run `devbox run server` for live-reload edits
4. Run `devbox run build` for creating builds in `output` directory.
5. Run `devbox run fmt-all` for formatting `src/*.typ` files

## Creating a PDF 
1. Create a `.toml` file referencing `sample.toml` in `/data`
2. If using devbox, run `devbox run build $AUTHOR_NAME $FILE_NAME`.
3. If using typst CLI, run in project root: `typst compile --root . src/main.typ --input data=$FILE_NAME output/Resume_${AUTHOR_NAME}.pdf`
