# Generate CLOC Badge Action

This GitHub Action generates a lines-of-code badge for your repository using [`cloc`](https://github.com/AlDanial/cloc) and commits it to a specified branch, typically `gh-pages`, which can be served by GitHub Pages. The badge can then be displayed in your repository's `README.md` file.

## Features

- Automatically counts the total lines of code in your repository.
- Updates a JSON file (`cloc.json`) with the line count, formatted for use with Shields.io dynamic badges.
- Commits the `cloc.json` file to a specified branch (creates the branch if it doesn't exist).
- Allows you to display an up-to-date lines-of-code badge in your `README.md`.

## Inputs

### `github_token` (required)

GitHub token for authentication. Use the default `${{ secrets.GITHUB_TOKEN }}` provided by GitHub Actions.

### `branch` (optional)

The branch to commit the badge data to. Defaults to `gh-pages`.

## Usage

### **Step 1: Add the Action to Your Workflow**

Create or update a workflow file (e.g., `.github/workflows/cloc-badge.yml`) in your repository:

```yaml
    name: Generate CLOC Badge

    on:
    push:
        branches: [ main, master ]
    workflow_dispatch:

    permissions:
    contents: write

    jobs:
    build:
        runs-on: ubuntu-latest

        steps:
        - uses: actions/checkout@v3

        - name: Generate CLOC Badge
        uses: your-username/generate-cloc-badge-action@v1.1.0
        with:
            github_token: ${{ secrets.GITHUB_TOKEN }}
            branch: gh-pages  # Optional, defaults to 'gh-pages' if omitted
        ```





