# Dockerfiles

```dockerfile
FROM python:2.7
RUN mkdir -p /app
WORKDIR /app
COPY ./requirements.txt /app/
RUN pip install -r requirements.txt
CMD ["python", "main.py"]
```

## Run

```dockerfile
docker image build -t my-ubuntu -f dockerfile .

docker image build -t my-test -f Dockerfile2 .
```



