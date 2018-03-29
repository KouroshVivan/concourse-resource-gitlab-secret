# GitLab Secret Resource

Fetch Secrets from Gitlab Secret Variables API

GitLab API: https://docs.gitlab.com/ee/api/project_level_variables.html

To define an Gitlab Secret resource for a Concourse pipeline:

``` yaml
resource_types:
- name: gitlab-secret
  type: docker-image
  source:
    repository: manulifeoss/concourse-resource-gitlab-secret
    tag: latest

resources:
- name: gitlab_secrets
  type: gitlab-secret
  source:
    uri: https://GITLAB_URL
    project_path: gitlab_group/gitlab_project
    private_token: "MYPRIVATETOKEN"
    debug: true
```

## Source Configuration

* `uri`: *Required*. Gitlab URL.

* `project_path`: *Required*. Gitlab project namespace path.

* `private_token`: *Required*. Gitlab Token.

* `timeout`: *Optional*. HTTP requests timeout in seconds. Default `3`.

* `debug`: *Optional*. Show debug output. Default `false`

## Parameter Configuration

* `secrets`: *Required for get*. List of secrets you want to fetch.

### Example

Resource configuration:

``` yaml
jobs:
- name: my-test-app
  plan:
  - get: gitlab_secrets
    params:
      secrets:
      - "MYSECRET"
  - task: "PCF deploy"
    config:
      platform: linux
      image_resource:
        type: docker-image
        source:
          repository: ubuntu
      inputs:
      - name: gitlab_secrets
      run:
        path: sh
        args:
        - "-exc"
        - |
          echo "This is a sample pipeline"
          ls gitlab_secrets
          echo "PRINT SECRETS"
          cat gitlab_secrets/MYSECRET.json
```

## Behavior

### `check`: Not supported.

### `in`: Fetch secrets from Gitlab.

`in` is a python scripts using python-gitlab library
Use the Gitlab Token to find the Gitlab project and fetch project secrets using Gitlab API (https://docs.gitlab.com/ee/api/project_level_variables.html).
Then create one json file by secret.

### `out`: Not supported.
