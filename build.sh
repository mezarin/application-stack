####
# For more documentation, see:
#  https://github.com/OpenLiberty/application-stack/wiki/Open-Liberty-Application-Stack-Customization
####

#
# Base image used to build stack image
#
BASE_OS_IMAGE="${BASE_OS_IMAGE:-adoptopenjdk/openjdk14-openj9:ubi}"

#
# Version of Open Liberty runtime to use within both inner and outer loops
#
OL_RUNTIME_VERSION="${OL_RUNTIME_VERSION:-20.0.0.9}"

#
# The Open Liberty base image used in the final stage of the outer loop Dockerfile used to build your application image from
#
OL_UBI_IMAGE="${OL_UBI_IMAGE:-openliberty/open-liberty:20.0.0.9-kernel-java14-openj9-ubi}"

#
# The name and tag of the "stack image you will build.  This will used to create your inner loop development containers, and also as the base image for the first stage of your outer loop image build.
#
STACK_IMAGE="${STACK_IMAGE:-emezari/java-openliberty-20009-j14-ubi:0.0.1}"

#
# URL at which your outer loop Dockerfile is hosted
#
DEVFILE_DOCKERFILE_LOC="${DEVFILE_DOCKERFILE_LOC:-https://raw.githubusercontent.com/mezarin/application-stack/customizedStack/outer-loop/latest/Dockerfile}"

#
# URL at which your outer loop deploy YAML template is hosted
#
DEVFILE_DEPLOY_YAML_LOC="${DEVFILE_DEPLOY_YAML_LOC:-https://raw.githubusercontent.com/mezarin/application-stack/customizedStack/outer-loop/latest/app-deploy.yaml}"

# Base customization.
sed -e "s!{{.OL_RUNTIME_VERSION}}!$OL_RUNTIME_VERSION!; s!{{.STACK_IMAGE}}!$STACK_IMAGE!; s!{{.DEVFILE_DOCKERFILE_LOC}}!$DEVFILE_DOCKERFILE_LOC!; s!{{.DEVFILE_DEPLOY_YAML_LOC}}!$DEVFILE_DEPLOY_YAML_LOC!" src/devfile.yaml > devfile.yaml
sed -e "s!{{.BASE_OS_IMAGE}}!$BASE_OS_IMAGE!; s!{{.OL_RUNTIME_VERSION}}!$OL_RUNTIME_VERSION!" src/stackimage/Dockerfile > stackimage/Dockerfile

# Outer loop customization of Dockerfile
sed -e "s!{{.STACK_IMAGE}}!$STACK_IMAGE!; s!{{.OL_UBI_IMAGE}}!$OL_UBI_IMAGE!" src/outer-loop/Dockerfile > outer-loop/latest/Dockerfile

# Outer loop copy of app-deploy.yaml (no customization at present)
cp src/outer-loop/app-deploy.yaml outer-loop/latest/app-deploy.yaml
