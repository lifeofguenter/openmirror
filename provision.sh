#!/usr/bin/env bash

readlink_bin="${READLINK_PATH:-readlink}"
if ! "${readlink_bin}" -f test &> /dev/null; then
  __DIR__="$(dirname "$(python -c "import os,sys; print(os.path.realpath(os.path.expanduser(sys.argv[1])))" "${0}")")"
else
  __DIR__="$(dirname "$("${readlink_bin}" -f "${0}")")"
fi

# required libs
source "${__DIR__}/.bash/functions.lib.sh"

set -E
trap 'throw_exception' ERR

if [[ ! -z "${CI}" ]] && [[ "${CI}" == "true" ]]; then
  openssl aes-256-cbc -K $encrypted_e18adef837ac_key -iv $encrypted_e18adef837ac_iv -in openmirror.enc -out ~/.ssh/openmirror -d
  chmod 600 ~/.ssh/openmirror
fi

if [[ -f requirements.yml ]]; then
  ansible-galaxy install -r requirements.yml
fi

ansible-playbook -i inventory/default.ini playbooks/default.yml
