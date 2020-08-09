build:
	docker build -t ubuntudevenv .
run: gradle_cache
	docker run --rm --name ubuntudevenv -d \
	    -v /var/run/docker.sock:/var/run/docker.sock \
	    -v gradle_cache:/home/devuser/.gradle \
	    -v /Users/henrik/Documents/GitHub/monorepo-build:/home/devuser/monorepo-build \
	    ubuntudevenv:latest 
shell:
	docker exec -it ubuntudevenv zsh
stop:
	docker stop ubuntudevenv
gradle_cache:
	docker volume create gradle_cache
dangling:
	docker rmi `docker images -f dangling=true -q`
