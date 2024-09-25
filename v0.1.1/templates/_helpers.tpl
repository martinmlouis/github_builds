{{/*
Expand the name of the chart.
*/}}
{{- define "nginx.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nginx.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nginx.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nginx.labels" -}}
helm.sh/chart: {{ include "nginx.chart" . }}
{{ include "nginx.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nginx.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nginx.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nginx.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nginx.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{/*
Define ArgoCD values
*/}}
{{- define "argocdcli.IMAGENAME" -}}
{{- printf "harbor.35.212.92.161.nip.io/leidos/argocd:1.16.0" | quote }}
{{- end }}

{{- define "argocdcli.NAME" -}}
{{- .Chart.Name | quote }}
{{- end }}

{{- define "argocdcli.REPO" -}}
{{- .Values.argocd.REPO | quote }}
{{- end }}

{{- define "argocdcli.REVISION" -}}
{{- .Chart.Version | quote }}
{{- end }}

{{- define "argocdcli.NAMESPACE" -}}
{{- .Values.argocd.NAMESPACE | quote }}
{{- end }}

{{- define "argocdcli.DESTINATION_SERVER" -}}
{{- .Values.argocd.DESTINATION_SERVER | quote }}
{{- end }}

{{- define "argocdcli.LABEL" -}}
{{- printf "Version=v%s" .Chart.Version | quote }}
{{- end }}

{{- define "argocdcli.ARGOCD_SERVER" -}}
{{- .Values.argocd.ARGOCD_SERVER | quote }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "argocdcli.fullname" -}}
{{- printf "argocdcli" | quote }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "argocdcli.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "argocdcli.selectorLabels" -}}
app.kubernetes.io/name: {{ include "argocdcli.NAME" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "argocdcli.labels" -}}
helm.sh/chart: {{ include "argocdcli.chart" . }}
{{ include "nginx.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "argocdcli.serviceAccountName" -}}
{{- printf "argocdcli" | quote }}
{{- end }}

