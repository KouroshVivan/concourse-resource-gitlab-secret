# GitLab Secret Resource

Fetch Secrets from Gitlab Secret Variables API

GitLab API: https://docs.gitlab.com/ee/api/project_level_variables.html

To define an Gitlab Secret resource for a Concourse pipeline:

``` yaml
resource_types:
- name: gitlab-secret
  type: docker-image
  source:
    repository: kvivan/concourse-resource-gitlab-secret
    tag: latest

resources:
- name: gitlab_secrets
  type: gitlab-secret
  source:
    uri: https://GITLAB_URL
    project_path: gitlab_group/gitlab_project
    private_token: ((concourse_token))
    debug: true
```

## Source Configuration

* `uri`: *Required*. Gitlab URL.

* `project_path`: *Required*. Gitlab project namespace path.

* `private_token`: *Required*. Gitlab Token.

* `timeout`: *Optional*. HTTP requests timeout in seconds. Default `3`.

* `debug`: *Optional*. Show debug output. Default `false`

### Example

Resource configuration:

``` yaml
jobs:
- name: my-test-app
  plan:
     - get: concourse-pipelines
       trigger: true
     - get: gitlab-secrets
     - put: pipelines
       params:
         pipelines:
         - name: PipelineName
           team: main
           config_file: concourse-pipelines/pipelines/pipeline.yml
           vars_files:
             - gitlab-secrets/secrets.yml

```

## Behavior

### `check`: Not supported.

### `in`: Fetch secrets from Gitlab.

`in` is a python scripts using python-gitlab library
Use the Gitlab Token to find the Gitlab project and fetch project secrets using Gitlab API (https://docs.gitlab.com/ee/api/project_level_variables.html).
Then a yml containing all secrets of the chosen project.

### `out`: Not supported.
