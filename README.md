
Badge

# Generate CLOC Badge Action

This GitHub Action generates a lines-of-code badge for your repository using `cloc` and commits it to a specified branch.

## Inputs

- `github_token` (required): GitHub token for authentication.
- `branch` (optional): The branch to commit the badge to. Defaults to `gh-pages`.

## Usage

```yaml
- name: Generate CLOC Badge
  uses: your-username/generate-cloc-badge-action@v1
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    branch: gh-pages


```

![Total Lines](https://img.shields.io/endpoint?url=https://Nightfury874.github.io/generate-cloc-badge-action//cloc.json)
