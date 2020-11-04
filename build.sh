# Customization defaults.
BASE_OS_IMAGE="${BASE_OS_IMAGE:-adoptopenjdk/openjdk11-openj9:ubi}"
OL_DRIVER_VERSION="${OL_DRIVER_VERSION:-20.0.0.10}"
OL_UBI_IMAGE="${OL_UBI_IMAGE:-openliberty/open-liberty:20.0.0.10-kernel-java11-openj9-ubi}"
OL_APP_STACK_IMAGE="${OL_APP_STACK_IMAGE:-openliberty/application-stack:0.3}"
DEVFILE_DOCKERFILE_LOC="${DEVFILE_DOCKERFILE_LOC:-https://raw.githubusercontent.com/OpenLiberty/application-stack/master/outer-loop/0.3/Dockerfile}"
DEVFILE_DEPLOY_YAML_LOC="${DEVFILE_DEPLOY_YAML_LOC:-https://raw.githubusercontent.com/OpenLiberty/application-stack/master/outer-loop/0.3/app-deploy.yaml}"

# Base customization.
sed -e "s!{{.OL_DRIVER_VERSION}}!$OL_DRIVER_VERSION!; s!{{.OL_APP_STACK_IMAGE}}!$OL_APP_STACK_IMAGE!; s!{{.DEVFILE_DOCKERFILE_LOC}}!$DEVFILE_DOCKERFILE_LOC!; s!{{.DEVFILE_DEPLOY_YAML_LOC}}!$DEVFILE_DEPLOY_YAML_LOC!" src/devfile.yaml > devfile.yaml
sed -e "s!{{.BASE_OS_IMAGE}}!$BASE_OS_IMAGE!; s!{{.OL_DRIVER_VERSION}}!$OL_DRIVER_VERSION!" src/stackimage/Dockerfile > stackimage/Dockerfile

# Outer loop customization.
sed -e "s!{{.OL_APP_STACK_IMAGE}}!$OL_APP_STACK_IMAGE!; s!{{.OL_UBI_IMAGE}}!$OL_UBI_IMAGE!" src/outer-loop/latest/Dockerfile > outer-loop/latest/Dockerfile