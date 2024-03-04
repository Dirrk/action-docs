# action-docs
Github action that generates docs for a github action and injects them into the README.md

# Usage
To use action-docs github action, configure a YAML workflow file, e.g. `.github/workflows/documentation.yml`, with the following:
```yaml
name: Generate action docs
on:
  - pull_request
jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        ref: ${{ github.event.pull_request.head.ref }}

    - name: Update README.md from action.yml
      uses: Dirrk/action-docs@v1
```
| WARNING: This requires your README.md to contain comment delimiters, view this file in raw mode to see how it works |
| --- |

<!--- BEGIN_ACTION_DOCS --->
## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| action\_docs\_debug\_mode | Enable debug mode | false | false |
| action\_docs\_git\_commit\_message | Commit message | chore(action-docs): automated action | false |
| action\_docs\_git\_push | If true it will commit and push the changes | true | false |
| action\_docs\_template\_file | Template file to use for rendering the markdown docs | /src/default\_template.tpl | false |
| action\_docs\_working\_dir | Directory that contains the action.yml and README.md | . | false |

## Outputs

| Name | Description |
|------|-------------|
<!--- END_ACTION_DOCS --->
