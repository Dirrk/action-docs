# terraform-docs
A Github action for generating terraform module documentation using terraform-docs and gomplate.

# Configuration
<!--- BEGIN_ACTION_DOCS --->
## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| tf\_docs\_args | Additional args to pass | --sort-inputs-by-required | false |
| tf\_docs\_atlantis\_file | Generate directories by parsing an atlantis formatted yaml to enable provide the file name to parse (eg atlantis.yaml) (disabled by default) | disabled | false |
| tf\_docs\_content\_type | Generate document or table | table | false |
| tf\_docs\_find\_dir | Generate directories by running find ./tf\_docs\_find\_dir -name \*.tf (disabled by default) | disabled | false |
| tf\_docs\_git\_commit\_message | Commit message | terraform-docs: automated action | false |
| tf\_docs\_git\_push | If true it will commit and push the changes | false | false |
| tf\_docs\_indention | Indention level of Markdown sections [1, 2, 3, 4, 5] (default 2) | 2 | false |
| tf\_docs\_output\_file | File in module directory where the docs should be placed | USAGE.md | false |
| tf\_docs\_output\_method | Method should be one of (replace/inject/print) where replace will replace the tf\_docs\_output\_file, inject will inject the content between start and close delims and print will just print the output | inject | false |
| tf\_docs\_template | When provided will be used as the template if/when the OUTPUT\_FILE does not exist | # Usage<br><!--- BEGIN\_TF\_DOCS ---><br><!--- END\_TF\_DOCS ---><br> | false |
| tf\_docs\_working\_dir | Directories of terraform modules to generate docs for seperated by commas (conflicts with atlantis/find dirs) | . | false |

## Outputs

| Name | Description |
|------|-------------|
| num\_changed | Number of files changed |
<!--- END_ACTION_DOCS --->
