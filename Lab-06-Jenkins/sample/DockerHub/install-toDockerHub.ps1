# *** Sample script to build, test and push containerized Node JS applications ***
$USER = "fredysa"
$REPO = "nodejstest"
$TagV = "latest"

<#

docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
#>

# build the Docker image
docker image build -t  "$($user)/$($Repo):$($tagV)" .

# Run all unit tests
#docker container run --rm -it "$($user)/$($Repo):$($tagV)" /bin/sh
#npm test
#exit

# Login to Docker Hub

docker login
# Push the image to Docker Hub
docker push "$($user)/$($Repo):$($tagV)"