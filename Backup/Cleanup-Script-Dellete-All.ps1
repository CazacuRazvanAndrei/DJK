$AllImages = docker images --format "{{.ID}}"
$AllImages | % {
docker images rm $_ --force
}

docker images --format "{{.ID}}: {{.Repository}}"