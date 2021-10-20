$AllImages = docker images --format "{{.ID}}"
$AllImages | % {
docker image rm $_ --force
}

#docker images --format "{{.ID}}: {{.Repository}}"