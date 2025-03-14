
#### Note
If you want to deploy them for experimentation without the cost directly billed to your AWS, you may use a sandbox AWS environment like [kodekloud AWS](https://kodekloud.com/playgrounds/playground-aws), or you may also use Local Stack that helps with deploying to a local AWS emulated environment. 
For that, use docker container of localstack:
```
docker run -d localstack/localstack
#or
localstack start
```
In this case, you want to use tflocal command instead of terraform command to avoid credentials related complications:
```
tflocal apply
tflocal state list
```
Make sure to clean up the resources:
```
tflocal destroy

localstack stop
#or
docker rm [container_id]
```
Or use docker compose from [here](https://github.com/devopshobbies/aws-localstack-lab/tree/main):
```
docker-compose up
```
