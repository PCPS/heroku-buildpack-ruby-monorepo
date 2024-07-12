#!/usr/bin/env bash

copy_procfile () {
  local build_dir=$1
  local relative_app_dir=$2

  # copy to top-level in order for Heroku to recognize it
  cp "${build_dir}/${relative_app_dir}/Procfile" "${build_dir}/Procfile" 2>/dev/null

  if [[ $? != 0 ]]; then
  	echo "Failed to copy Procfile, aborting." | indent
  	exit 1
  fi

  # start tasks in the application directory
  sed -i -r -e "s#^(\w:)(.+)#\1 cd ${relative_app_dir} \&\&\2#" "${build_dir}/Procfile"
}
