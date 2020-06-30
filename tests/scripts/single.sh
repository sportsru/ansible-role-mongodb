#!/usr/bin/env bash
# -*- mode: sh; -*-

# set -o xtrace
set -o nounset
set -o errexit

package=${MONGODB_PACKAGE:-mongodb-org}
mongodb_security_authorization=${1:-disabled}
ansible_python_interpreter=${2:-python}

echo "ansible-playbook -i tests/hosts tests/site.yml -e target=mongo1 -e docker_privileged=${DOCKER_PRIVILEGED} -e image_name=${DISTRIBUTION}:${DIST_VERSION}_python${PYTHON_VERSION} -e mongodb_package=${package} -e mongodb_version=${MONGODB_VERSION} -e mongodb_security_authorization=${mongodb_security_authorization} -e ansible_python_interpreter=${ansible_python_interpreter}"
ansible-playbook -i tests/hosts tests/site.yml -e target=mongo1 -e docker_privileged=${DOCKER_PRIVILEGED} -e image_name=${DISTRIBUTION}:${DIST_VERSION}_python${PYTHON_VERSION} -e mongodb_package=${package} -e mongodb_version=${MONGODB_VERSION} -e mongodb_security_authorization=${mongodb_security_authorization} -e ansible_python_interpreter=${ansible_python_interpreter}

