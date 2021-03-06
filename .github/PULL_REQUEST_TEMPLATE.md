- [ ] Have you followed the [guidelines for contributing](https://github.com/Linuxbrew/homebrew-core/blob/master/CONTRIBUTING.md)?
- [ ] Have you checked that there aren't other open [pull requests](https://github.com/Linuxbrew/homebrew-core/pulls) for the same formula update/change?
- [ ] Have you built your formula locally with `brew install --build-from-source <formula>`, where `<formula>` is the name of the formula you're submitting?
- [ ] Does your build pass `brew audit --strict <formula>` (after doing `brew install <formula>`)?
- [ ] Have you included the output of `brew gist-logs <formula>` of the build failure if your PR fixes a build failure. Please quote the exact error message.

-----
