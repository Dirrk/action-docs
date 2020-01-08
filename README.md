# action-docs
Github action that generates docs for a github action and injects them into the README.md

<!--- BEGIN_ACTION_DOCS --->
## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| action\_docs\_git\_commit\_message | Commit message | action-docs: automated action | false |
| action\_docs\_git\_push | If true it will commit and push the changes | true | false |
| action\_docs\_template\_file | Template file to use for rendering the markdown docs | /src/default\_template.tpl | false |
| action\_docs\_working\_dir | Directory that contains the action.yml and README.md | . | false |

## Outputs

| Name | Description |
|------|-------------|
| num\_changed | Number of files changed |
<!--- END_ACTION_DOCS --->
