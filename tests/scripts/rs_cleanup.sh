#!/usr/bin/env bash
# -*- mode: sh; -*-

# set -o xtrace
set -o nounset
set -o errexit

package=${MONGODB_PACKAGE:-mongodb-org}
mongodb_security_authorization=${1:-disabled}
ansible_python_interpreter=${2:-python}

# Idempotence test
echo 'Idempotence test: run'
ansible-playbook -i tests/hosts tests/site.yml -e target=mongo -e docker_privileged=${DOCKER_PRIVILEGED} -e image_name=${DISTRIBUTION}:${DIST_VERSION}_python${PYTHON_VERSION} -e mongodb_package=${package} -e mongodb_version=${MONGODB_VERSION} -e mongodb_replication_replset='rs0' -e mongodb_security_authorization=${mongodb_security_authorization} -e ansible_python_interpreter=${ansible_python_interpreter} \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) || (echo 'Idempotence test: fail' && exit 1)
# Delete all containers
docker kill mongo{1,2,3} && docker rm mongo{1,2,3}

