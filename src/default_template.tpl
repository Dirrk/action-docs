{{- define "escape_chars" }}{{ . | strings.ReplaceAll "_" "\\_" | strings.ReplaceAll "|" "\\|" | strings.ReplaceAll "*" "\\*" }}{{- end }}
{{- define "sanatize_string" }}{{ . | strings.ReplaceAll "\n\n" "<br><br>" | strings.ReplaceAll "  \n" "<br>" | strings.ReplaceAll "\n" "<br>" | tmpl.Exec "escape_chars" }}{{- end }}
{{- $action := (datasource "action") -}}
## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
{{- if has $action "inputs" }}
{{- range $key, $input := $action.inputs }}
| {{ tmpl.Exec "escape_chars" $key }} | {{ if (has $input "description") }}{{ tmpl.Exec "sanatize_string" $input.description }}{{ else }}{{ tmpl.Exec "escape_chars" $key }}{{ end }} | {{ if (has $input "default") }}{{ tmpl.Exec "sanatize_string" $input.default }}{{ else }}N/A{{ end }} | {{ if (has $input "required") }}{{ $input.required }}{{ else }}false{{ end }} |
{{- end }}
{{- end }}

## Outputs

| Name | Description |
|------|-------------|
{{- if has $action "outputs" }}
{{- range $key, $output := $action.outputs }}
| {{ tmpl.Exec "escape_chars" $key }} | {{ if (has $output "description") }}{{ tmpl.Exec "sanatize_string" $output.description }}{{ else }}{{ tmpl.Exec "escape_chars" $key }}{{ end }} |
{{- end }}
{{- end }}
