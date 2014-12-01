export COMMAND=runner

function runner() {
IMAGE=AUTHOR/APP:TAG

docker run -it $IMAGE $*
}
