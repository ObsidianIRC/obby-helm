{{- define "obby.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "obby.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "obby.componentLabels" -}}
{{ include "obby.labels" . }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}

{{- define "obby.imageTag" -}}
{{- default .root.Chart.AppVersion .component.tag -}}
{{- end -}}

{{- define "obby.serverName" -}}
{{- default .Values.global.ircFqdn .Values.obbyircd.serverName -}}
{{- end -}}
