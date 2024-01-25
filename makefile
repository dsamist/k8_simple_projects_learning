#.PHONY: run_website stop_website Install_minikube create_docker_registry   #uncomment this line if the make file fails to run because of an already existing make process.

#install docker
install_docker:
	sudo apt install docker.io -y

#build and run the docker file
run_website:
	docker build -t dsamist/website . && docker run --rm --name website_cont -dp 5000:80 dsamist/website

#stop a docker container
stop_website:
	docker stop website_cont

#install minikube on local machine
Install_minikube: install_docker
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
		sudo install minikube-linux-amd64 /usr/local/bin/minikube && \
			minikube start && \
				kubectl get po -A

#create a local registry for docker images:
create_docker_registry:
	docker run --name local-registry -d --restart=always -p 5000:5000 registry:2 && \
		curl --location http://localhost:5000/v2

#configure minikube to use local registry (https://minikube.sigs.k8s.io/docs/handbook/registry/)
connect_minikube_to_local_registry:
	minikube addons configure local-registry && \
		minikube addons enable local-registry

# #tagging and pushing and pulling images to and from the registry:
# docker build -t localhost:5000/my-image 
# docker push localhost:5000/my-image 
# docker pull localhost:5000/my-image 
