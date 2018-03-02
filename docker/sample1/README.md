## Sample1: Docker Hello World

- This sample runs simple ballerina hello world service in a docker container. 
- The service is annotated with @docker:configuration{} without passing any parameters. 
- Default values for docker annotation attributes will be used to create docker artifacts.
- Following files will be generated from this sample.
    ``` 
    $> docker image
    hello-world-docker:latest
    
    $> tree
    ├── hello-world-docker.balx
    └── target
        └── docker
            └── Dockerfile
    ```
### How to run:

1. Compile the  hello-world-docker.bal file. Command to run docker image will be printed on success:
```bash
$> ballerina build hello-world-docker.bal

Run following command to start docker container: 
docker run -d -p 9090:9090 hello-world-docker:latest
```

2. hello-world-docker.balx, Dockerfile and docker image will be generated: 
```bash
$> tree
.
├── README.md
├── hello-world-docker.bal
├── hello-world-docker.balx
└── target
    └── docker
        └── Dockerfile
```

3. Verify the docker image is created:
```bash
$> docker images
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
hello-world-docker    latest              df83ae43f69b        2 minutes ago        102MB

```

4. Run docker image as a container (Use the command printed on screen in step 1):
```bash
$> docker run -d -p 9090:9090 hello-world-docker:latest
68eb4160ac769f131ebd3ed59f8ee0f6fe6a2e1924e290b04a4cd7513e9b71d1
```

5. Verify docker container is running:
```bash
$> docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED              STATUS              PORTS                    NAMES
68eb4160ac76        hello-world-docker:latest   "/bin/sh -c 'balleri…"   About a minute ago   Up About a minute   0.0.0.0:9090->9090/tcp   vigilant_swartz

```

6. Access the hello world service with curl command:
```bash
$> curl http://localhost:9090/HelloWorld/sayHello
Hello, World from service helloWorld !
```